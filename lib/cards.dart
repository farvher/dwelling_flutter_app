import 'package:dwelling_flutter_app/provider.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/user_preferences.dart';
import 'package:dwelling_flutter_app/model/model.dart';

class CardsHomePage extends StatefulWidget {
  @override
  _CardsHomePageState createState() => _CardsHomePageState();
}

class _CardsHomePageState extends State<CardsHomePage>
    with TickerProviderStateMixin {
  DwellingProvider provider = DwellingProvider();
  Future<Property> properties ;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(title: Text('dwelling')),
      bottomNavigationBar: buttonNavigationBar(),
      drawer: UserPreferencesPage(),
      body: new Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: futureWidget())),
    );
  }

  Widget futureWidget(){

    return FutureBuilder<List<Property>>(
      future: provider.getData(), // a previously-obtained Future<String> or null
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
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
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
        stackNum: 5,
        swipeEdge: 4.0,
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        maxHeight: MediaQuery.of(context).size.width * 0.9,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        minHeight: MediaQuery.of(context).size.width * 0.8,
        cardBuilder: (context, index) => Card(
                child: new IconButton(
              icon: FlatButton(
                child: Text(data[index].title),
                onPressed: () { /* ... */ },
              ),
              onPressed: () => print('presionado'),
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
