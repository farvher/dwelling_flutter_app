import 'package:dwelling_flutter_app/Login/login.dart';
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
                  leading: Icon(Icons.device_hub),
                  title: Text('Publica gratis'),
                  onTap: () {
                    Navigator.pop(context);
                  }), LoginPage()


            ]
        )
    );
  }
}



