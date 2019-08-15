import 'package:dwelling_flutter_app/provider.dart';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);

  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  static const LatLng _center = const LatLng(4.59808, -74.076044);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.favorite),
        backgroundColor: Colors.pink,
      ),
      //appBar: AppBar(title: Text('dwelling'),centerTitle: true,toolbarOpacity: 0.7),
      bottomNavigationBar: NavigationBar(),
      drawer: UserPreferencesPage(),
      body: new Center(
          child: Container(
              padding: EdgeInsets.all(0.0),
              height: MediaQuery.of(context).size.height * 0.8,
              child: futureWidget())),
    );
  }

  Widget futureWidget() {
    return FutureBuilder<List<Property>>(
      future: provider.getData(),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Property>> snapshot) {
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
            return cardBuilder(snapshot.data);
        }
        return null; // unreachable
      },
    );
  }

  Widget cardBuilder(List<Property> data) {
    return new TinderSwapCard(
        orientation: AmassOrientation.BOTTOM,
        totalNum: 5,
        stackNum: 3,
        swipeEdge: 2.0,
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        minHeight: MediaQuery.of(context).size.height * 0.7,
        cardBuilder: (context, index) => Card(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(0.0),
                        color: Colors.white,
                        child: Image.network(
                            'https://metrocuadrado.blob.core.windows.net/inmuebles/674-M2485555/674-M2485555_10_h.jpg'),
                        alignment: Alignment.topCenter),
                    Center(
                        child: Text(
                      data[index].title,
                      style: optionStyle,
                    )),
                  ],
                ),
                Expanded(
                  child: futureShowMap(),

                )
              ],
            )),
        cardController: new CardController(),
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            print('a la derecha $details ');
            //Card is LEFT swiping
          } else if (align.x > 0) {
            print('a la izquierda $details ');

            //Card is RIGHT swiping
          }
        },
        animDuration: 200,
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          print('movido $index $orientation');

          /// Get orientation & index of swiped card!
        });
  }

  Future<Widget> buildGoogleMap() async{
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
    return GoogleMap(
      onMapCreated: _onMapCreated, compassEnabled: false,
        myLocationEnabled: false,
      rotateGesturesEnabled: false,
      zoomGesturesEnabled: false,
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 15.0,
      )
    );
  }

  Widget futureShowMap() {
    return FutureBuilder<Widget>(
      future: buildGoogleMap(),
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


}
