import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';

class SubdivisionInfo {
  Future<List<dynamic>> getSubdivision() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getCountry,
        {"Content-Type": "application/json", "accesstoken": token});
    print('This is the response from the Subdivision screen');
    print(response);
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      List<dynamic> subdivision = rsp['addresses'][0]['subdivisions'];
      subdivision.map((e) => e['name']).toList();
      return subdivision;
    }
    print('This is the response from the Subdivision screen BUT EMPTY');
    return [];
  }
}
