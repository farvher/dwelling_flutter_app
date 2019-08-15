import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/cards.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
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
