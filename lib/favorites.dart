import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  _Favorites createState() => _Favorites();
}

class _Favorites extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
