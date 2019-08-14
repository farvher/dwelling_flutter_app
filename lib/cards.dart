import 'package:dwelling_flutter_app/provider.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/user_preferences.dart';
import 'package:dwelling_flutter_app/model/property.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CardsHomePage extends StatefulWidget {
  @override
  _CardsHomePageState createState() => _CardsHomePageState();
}

class _CardsHomePageState extends State<CardsHomePage>
    with TickerProviderStateMixin {
  DwellingProvider provider = DwellingProvider();
  Future<Property> properties;

  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold , color: Colors.white);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

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
      bottomNavigationBar: buttonNavigationBar(),
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

  Widget buttonNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Perfil'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Favoritos'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  Widget cardBuilder(List<Property> data) {
    return new TinderSwapCard(
        orientation: AmassOrientation.BOTTOM,
        totalNum: data.length,
        stackNum: 6,
        swipeEdge: 2.0,
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        minHeight: MediaQuery.of(context).size.height * 0.7,
        cardBuilder: (context, index) => Card(
                child: Stack(
              children: <Widget>[
                Image.network(
                    'https://metrocuadrado.blob.core.windows.net/inmuebles/674-M2485555/674-M2485555_10_h.jpg'),
                Center(child: Text(data[index].description, style: optionStyle,)),
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                )],
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
        animDuration: 400,
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          print('movido $index $orientation');

          /// Get orientation & index of swiped card!
        });
  }
}
