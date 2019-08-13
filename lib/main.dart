import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/cards.dart';
import 'package:dwelling_flutter_app/user_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardsHomePage(),
    );
  }
}
