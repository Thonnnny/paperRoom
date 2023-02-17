import 'dart:convert';

import 'package:freshbuyer/model/productsInOffer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';
import '../model/activeResponses.dart';

class ActiveOrderInfo {
  Future<List<dynamic>> getActiveOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getActiveOrders,
        {"Content-Type": "application/json", "accesstoken": token});
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      List<dynamic> activeOrders = rsp['activeOrders'];
      print('This is the response from the active orders screen');
      print(activeOrders);
      return activeOrders;
    } else {
      print('No hay ordenes activas');
      return [];
    }
  }
}
