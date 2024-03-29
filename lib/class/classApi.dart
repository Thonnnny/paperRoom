import 'dart:convert';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';
import '../model/productElement.dart';

class ApisClass {
  Future<List<Product>> getProductItems() async {
    final response = await BaseClient()
        .get(RestApis.getProducts, {"Content-Type": "application/json"});
    print(response);
    final jsonResponse = jsonDecode(response);
    final products = jsonResponse["products"] as List;
    return products.map((p) => Product.fromJson(p)).toList();
  }
}
