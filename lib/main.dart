import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/cards.dart';
import 'package:dwelling_flutter_app/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: CardsHomePage(),
    );
  }
}
