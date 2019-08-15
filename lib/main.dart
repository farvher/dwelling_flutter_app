import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/cards.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      title: 'Dwelling App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: CardsHomePage(),
    );
  }

}
