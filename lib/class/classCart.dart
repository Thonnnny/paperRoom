import 'dart:convert';

import 'package:freshbuyer/model/cartResponses.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';

class ProductsCar {
  Future<List<dynamic>> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient().get(RestApis.getCart,
        {"Content-Type": "application/json", "accesstoken": token});
    print('This is the response from the cart screen');
    print(response);
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      Cart cart = Cart.fromJson(rsp);
      if (cart.cart?.items == null) {
        return [];
      } else {
        return cart.cart!.items!;
      }
    } else {
      print('No hay productos en el carrito');
      return [];
    }
  }
}
