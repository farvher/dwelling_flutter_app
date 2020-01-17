import 'package:dwelling_flutter_app/services/dwellingProvider.dart';
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
  bool liked = false;
  bool showMap = false;
  List<Property> data = <Property>[];
  var totalNum = 3;
  Property lastCard;
  Property firstCard;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle H3  = TextStyle(fontWeight: FontWeight.bold);

  Completer<GoogleMapController> _controller = Completer();
  Widget lastImageWidget;
  Widget lastPosition;

  final Set<Marker> _markers = {};

  static const LatLng _center = const LatLng(4.59808, -74.076044);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        backgroundColor: Colors.transparent,

        title:Text("DWELLING",style: TextStyle(color: Colors.red, fontSize: 30)),
        elevation: 0.0,
        ),
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              showMap = false;
            });
          },
          child: Icon(Icons.edit),
          backgroundColor: Colors.deepPurple,
        ),
        //appBar: AppBar(title: Text('dwelling'),centerTitle: true,toolbarOpacity: 0.7),
        bottomNavigationBar: NavigationBar(),
        drawer: UserPreferencesPage(),
        body: new Center(
          //centra la seccion de cartas
          child: Container(
              padding: EdgeInsets.all(0.0),
              height: MediaQuery.of(context).size.height,
              child: futureCards()),
        ));
  }

  Widget futureCards() {
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
    totalNum = data.length;
    return new TinderSwapCard(
        orientation: AmassOrientation.BOTTOM,
        totalNum: data.length,
        stackNum: 5,
        swipeEdge: 6.0,
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        minHeight: MediaQuery.of(context).size.height * 0.7,
        cardBuilder: (context, index) {
          var p = data[index];
          return createCard(p);
        },
        cardController: new CardController(),
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
        },
        animDuration: 200,
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          if (index + 1 == totalNum) {
            print("[cardBuilder] ultima carta mostrada");
            setState(() {
              //data  es igual a la nueva data consultada
            });
          }
          print('movido $index $orientation');
          if (index + 2 == totalNum) {
            //setea a data la nueva info
            print("[cardBuilder] cargando nueva data");
            // futureCards();
          }
          if (CardSwipeOrientation.LEFT == orientation) {
            liked = false;
          } else if (CardSwipeOrientation.RIGHT == orientation) {
            liked = true;
          }

          /// Get orientation & index of swiped card!
        });
  }

  /**
   * crea la carta*/
  Card createCard(Property p) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(0.0),
        semanticContainer: false,
        elevation: 10,
        child: Column(
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
            Container(
                margin: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white),
                child: showMap
                    ? futureShowMap(p)
                    : RichText(
                        text: TextSpan(
                          text: "Centro internacional, Bogotá D.C." + p.neighborhood.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                          children: <InlineSpan>[
                            TextSpan(text: "\n"),
                            WidgetSpan(
                                child: Icon(Icons.home,
                                    color: Colors.red, size: 16)),
                            TextSpan(text: p.propertyType.toString().toLowerCase()  + " en " + p.businessType.toString().toLowerCase() ),
                            TextSpan(text: "\n"),
                            WidgetSpan(child: Icon(Icons.attach_money,color: Colors.red, size: 16)),
                            TextSpan(text: p.rentPrice.toString()),
                            TextSpan(text: "\n"),
                            TextSpan(text: "Estrato : " + p.stratum.toString()),
                            TextSpan(text: "\n"),
                            WidgetSpan(
                                child: Icon(Icons.view_compact,
                                    color: Colors.red, size: 16)),
                            TextSpan(text: p.rooms.toString() + " Habitaciones"),
                            TextSpan(text: "\n"),
                            WidgetSpan(
                                child: Icon(Icons.airline_seat_legroom_normal,
                                    color: Colors.red, size: 16)),
                            TextSpan(text: p.bathroom.toString() + " Baños"),
                            TextSpan(text: "\n"),
                            WidgetSpan(
                                child: Icon(Icons.timer,
                                    color: Colors.red, size: 16)),
                            TextSpan(text: p.antiquitiy.toString()),
                            TextSpan(text: "\n"),
                            WidgetSpan(
                                child: Icon(Icons.crop_square,
                                    color: Colors.red, size: 16)),
                            TextSpan(text: p.area.toString() + " m2"),
                            TextSpan(text: "\n"),
                            TextSpan(
                                text: "Descripción : ",
                                style: H3),
                            TextSpan(text: p.description),
                          ],
                        ),
                      )
                //futureShowMap(data[index]),
                )
          ],
        ));
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

  /**
   * carga el mapa mientra muestra un circularprogress
   * */
  Widget futureShowMap(Property p) {
    print("[futureShowMap]");
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
            print("[futureShowMap] waiting");
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            print("[futureShowMap] ok");
            return snapshot.data;
        }
        return null; // unreachable
      },
    );
  }

  Future<Widget> buildImages(String url) async {
    return  lastImageWidget = ClipRRect(
      borderRadius: new BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
      child:  Image.network(url)
    );


  }

  /**
   *  carga una imagen de url, mientras muestra la mas reciente*/
  Widget showImages(String url) {
    print("[showImages]");
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
            print("[showImages] waiting");
            return lastImageWidget;
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            print("[showImages] ok");
            return snapshot.data;
        }
        return null; // unreachable
      },
    );
  }
}
