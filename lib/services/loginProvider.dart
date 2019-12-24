import 'dart:io';

import 'package:dwelling_flutter_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:dwelling_flutter_app/constants/endpoints.dart';
import 'dart:convert';

import 'dart:convert';

class LoginProvider {

  Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };
  Future<User> auth(User user) async {
    var res = await http.post(Endpoints.LOGIN, body:json.encode(user.toJson()),
        headers: {"Content-type": "application/json"} );
    if (res.statusCode == 200) {
      var token = json.decode(res.body)['token'];
      user.token = (token);
    }
    return user;
  }
}
