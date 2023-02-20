import 'dart:convert';

import 'package:freshbuyer/model/productsInOffer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';

class ProductsOfferRepository {
  Future<List<Offer>> getProductsInOffer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accesstoken');
    var response = await BaseClient()
        .get(RestApis.getProductInOffer, {"Content-Type": "application/json"});
    var rsp = jsonDecode(response);
    if (rsp['type'] == 'success') {
      ProductsInOffer offer = ProductsInOffer.fromJson(rsp);
      print('This is the response from the Products in Offer screen');
      print(offer.offers);
      return offer.offers!;
    } else {
      print('No hay productos en ofertas');
      return [];
    }
  }
}
