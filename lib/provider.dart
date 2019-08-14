import 'package:http/http.dart' as http;
import 'package:dwelling_flutter_app/endpoints.dart';
import 'package:dwelling_flutter_app/model/property.dart';
import 'dart:convert';

class DwellingProvider {
  DwellingProvider();

  Future<List<Property>> getData() async {
    var res = await http.get(Endpoints.INIT_RESULTS);
    if (res.statusCode == 200) {
      List list = jsonDecode(res.body);
      var propertyList = list.map((e) => new Property.fromJson(e)).toList();
      return propertyList;
    }
    return null;
  }

  Future<List<Property>> getDataEndpoint(String endpoint) async {
    var res = await http.get(endpoint);
    if (res.statusCode == 200) {
      List list = jsonDecode(res.body);
      var propertyList = list.map((e) => new Property.fromJson(e)).toList();
      return propertyList;
    }
    return null;
  }
}
