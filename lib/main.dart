

import 'package:dwelling_flutter_app/Login/login.dart';
import 'package:dwelling_flutter_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:dwelling_flutter_app/cards.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  User user = User("","");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      title: 'Dwelling App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.red
      ),
      home:  CardsHomePage(),
    );
  }

}
