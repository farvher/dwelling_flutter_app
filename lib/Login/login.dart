import 'package:dwelling_flutter_app/model/user.dart';
import 'package:dwelling_flutter_app/services/loginProvider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _FormPageState createState() => new _FormPageState();
}

class _FormPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  LoginProvider loginProvider = LoginProvider();

  String _username;
  String _password;

  void _submit() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      User user = User(_username, _password);
      await loginProvider.auth(user).then(
              (res) => {
      });
    }
  }

  void performLogin() {
    final snackbar = new SnackBar(
      content: new Text("Email : $_username, password : $_password"),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return  new Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: formKey,
            child: new Column(
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Email"),
                  onSaved: (val) => _username = val,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: "Password"),
                  onSaved: (val) => _password = val,
                  obscureText: true,
                ),
                new RaisedButton(
                  child: new Text(
                    "login",
                    style: new TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: _submit,
                )
              ],
            ),
          ),
        );
  }

  _auth(User user) async {
    var result = await loginProvider.auth(user);
  }
}
