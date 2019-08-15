import 'package:flutter/material.dart';

class UserPreferencesPage extends StatefulWidget {
  @override
  _UserPreferencesPage createState() => _UserPreferencesPage();
}

class _UserPreferencesPage extends State<UserPreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.device_hub),
            title: Text('Publica gratis'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Mis Inmuebles'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ButtonBar(
            children: <Widget>[],
          )
        ],
      ),
    );
  }
}
