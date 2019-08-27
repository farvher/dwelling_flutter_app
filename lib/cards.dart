import 'package:dwelling_flutter_app/services/provider.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/user_preferences.dart';
import 'package:dwelling_flutter_app/model/property.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dwelling_flutter_app/navigation_bar.dart';

class CardsHomePage extends StatefulWidget {
  @override
  _CardsHomePageState createState() => _CardsHomePageState();
}

class _CardsHomePageState extends State<CardsHomePage>
    with TickerProviderStateMixin {
  DwellingProvider provider = DwellingProvider();
  Future<Property> properties;
  bool liked = false;
  bool showMap = false;
  List<Property> data = <Property>[];
  var totalNum = 5;
  var actualCard = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  Completer<GoogleMapController> _controller = Completer();
  Widget lastImageWidget;
  Widget lastPosition;

  final Set<Marker> _markers = {};

  static const LatLng _center = const LatLng(4.59808, -74.076044);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         setState(() {
           showMap = false;
         });
        },
        child: Icon(Icons.favorite),
        backgroundColor: Colors.pink,
      ),
      //appBar: AppBar(title: Text('dwelling'),centerTitle: true,toolbarOpacity: 0.7),
      bottomNavigationBar: NavigationBar(),
      drawer: UserPreferencesPage(),
      body: new Center(
          //centra la seccion de cartas
          child: Container(
              padding: EdgeInsets.all(0.0),
              height: MediaQuery.of(context).size.height ,
              child: data.isEmpty ? futureCards() : cardBuilder(data) )),
    );
  }

  Widget futureCards() {
    return FutureBuilder<List<Property>>(
      future: provider.getData() ,
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Property>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
            return Text('Connecion active');
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            data = snapshot.data;
            return cardBuilder(snapshot.data);
        }
        return null; // unreachable
      },
    );
  }

  Widget cardBuilder(List<Property> data) {
    return new TinderSwapCard(
        orientation: AmassOrientation.BOTTOM,
        totalNum: totalNum,
        stackNum: 5,
        swipeEdge: 6.0,
        maxWidth: MediaQuery.of(context).size.width * 0.7,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        minHeight: MediaQuery.of(context).size.height * 0.7,
        cardBuilder: (context, index) {
          var p = data[index];
          return Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  showImages(
                      'https://metrocuadrado.blob.core.windows.net/inmuebles/674-M2485555/674-M2485555_10_h.jpg'),
                  Center(
                      child: Text(
                    p.title,
                    style: optionStyle,
                  )),
                ],
              ),
              Expanded(
                  child: showMap  ? futureShowMap(data[index]) : Row(children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: FlatButton.icon(
                            icon: Icon(Icons.business),
                            label: Text(p.propertyType[0].toString()))),
                    FlatButton(onPressed: (){ setState(() {
                      showMap = !showMap;
                    });},child: Text("Mapa"),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: FlatButton.icon(
                            icon: Icon(Icons.room),
                            label: Text(p.rooms.toString()))),
                    Expanded(
                      child: FlatButton.icon(
                          icon: Icon(Icons.local_parking),
                          label: Text(p.parking.toString())),
                    ),
                    Expanded(
                      child: FlatButton.icon(
                          icon: Icon(Icons.crop_square),
                          label: Text(p.area.toString())),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[],
                ),
              ]) //futureShowMap(data[index]),
                  )
            ],
          ));
        },
        cardController: new CardController(),
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            liked = true;
            //Card is LEFT swiping
          } else if (align.x > 0) {
            liked = false;
            //Card is RIGHT swiping
          }
        },
        animDuration: 200,
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          actualCard = index;
          if(index+1 == totalNum){
            setState(() {
              data.clear();
            });
          }
          print('movido $index $orientation');

          /// Get orientation & index of swiped card!
        });
  }

  Future<Widget> buildGoogleMap(var lat, var lon) async {
    _markers.clear();
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_center.toString()),
      position: _center,
      infoWindow: InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
    return lastPosition = GoogleMap(
        //onMapCreated: _onMapCreated,
        compassEnabled: false,
        myLocationEnabled: false,
        rotateGesturesEnabled: false,
        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ));
  }

  Widget futureShowMap(Property p) {
    return FutureBuilder<Widget>(
      future: buildGoogleMap(p.latitude, p.longitude),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
            return Text('Connecion active');
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return snapshot.data;
        }
        return null; // unreachable
      },
    );
  }

  Future<Widget> buildImages(String url) async {
    return Container(
        padding: EdgeInsets.all(0.0),
        color: Colors.white,
        child: lastImageWidget = Image.network(url),
        alignment: Alignment.topCenter);
  }

  Widget showImages(String url) {
    return FutureBuilder<Widget>(
      future: buildImages(url),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Press button to start.');
          case ConnectionState.active:
            return Text('Connecion active');
          case ConnectionState.waiting:
            return lastImageWidget;
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return snapshot.data;
        }
        return null; // unreachable
      },
    );
  }

}
