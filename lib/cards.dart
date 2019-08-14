import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/user_preferences.dart';

class CardsHomePage extends StatefulWidget {
  @override
  _CardsHomePageState createState() => _CardsHomePageState();
}

class _CardsHomePageState extends State<CardsHomePage>
    with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/welcome0.png",
    "assets/welcome1.png",
    "assets/welcome2.png",
    "assets/welcome2.png",
    "assets/welcome1.png",
    "assets/welcome1.png"
  ];

  void reset() {
    setState(() {});
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
      appBar: AppBar(title: Text('dwelling')),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: UserPreferencesPage(),
      body: new Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: cardBuilder())),
    );
  }

  Widget cardBuilder() {
    return new TinderSwapCard(
        orientation: AmassOrientation.BOTTOM,
        totalNum: 12,
        stackNum: 4,
        swipeEdge: 4.0,
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        maxHeight: MediaQuery.of(context).size.width * 0.9,
        minWidth: MediaQuery.of(context).size.width * 0.8,
        minHeight: MediaQuery.of(context).size.width * 0.8,
        cardBuilder: (context, index) => Card(
                child: new IconButton(
              icon: Image.network(
                  'https://raw.githubusercontent.com/ShaunRain/flutter_tindercard/master/assets/welcome2.png'),
              onPressed: () => print('presionado'),
            )),
        cardController: new CardController(),
        swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
          /// Get swiping card's alignment
          if (align.x < 0) {
            //print('a la derecha $details ');
            //Card is LEFT swiping
          } else if (align.x > 0) {
            //print('a la derecha $details ');

            //Card is RIGHT swiping
          }
        },
        animDuration: 400,
        swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
          print('movido $index $orientation');

          /// Get orientation & index of swiped card!
        }
    );
  }



}
