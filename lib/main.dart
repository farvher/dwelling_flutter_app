import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  @override
  _ExampleHomePageState createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage>
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

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return new Scaffold(
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
        });
  }
}
