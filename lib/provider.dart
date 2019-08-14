
import 'package:http/http.dart' as http;
import 'package:dwelling_flutter_app/endpoints.dart';
import 'dart:convert';

class DwellingProvider{


  DwellingProvider();

  Future<String> getData() async{
    var res = await http
        .get(Endpoints.INIT_RESULTS);
    var decodedJson = jsonDecode(res.body);

    return decodedJson.toString();
  }
}