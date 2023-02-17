import 'dart:convert';

import 'package:freshbuyer/model/countryResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';

class AddressInfo {
  Future<List<dynamic>> fetchCountries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getCountry,
        {"Content-Type": "application/json", "accesstoken": token});

    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      final countryList = List<Country>.from(
          rsp['countries'].map((country) => Country.fromJson(country)));
      print('This is the response from the address screen');
      print(countryList);
      return countryList;
    }
    print('This is the response from the address screen BUT EMPTY');
    return [];
  }
}
