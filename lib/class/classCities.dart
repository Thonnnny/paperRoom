import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';

class CitiesInfo {
  Future<List<dynamic>> getCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getCountry,
        {"Content-Type": "application/json", "accesstoken": token});
    print('This is the response from the Cities screen');
    print(response);
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      List<dynamic> cities = rsp['addresses']['subdivisions']['cities'];
      cities.map((e) => e['name']).toList();
      return cities;
    }
    print('This is the response from the Cities screen BUT EMPTY');
    return [];
  }
}
