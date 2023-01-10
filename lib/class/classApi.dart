import 'dart:convert';

import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';
import '../model/productElement.dart';
import '../model/productResponse.dart';

class ApisClass {
  Future<List<Product>> getProductItems() async {
    final response = await BaseClient()
        .get(RestApis.apiProducts, {"Content-Type": "application/json"});
    final productResponse = ProductResponse.fromJson(jsonDecode(response));
    return productResponse.products
        .map((e) => Product(
            id: e.id,
            name: e.name,
            description: e.description,
            price: e.price,
            priceCurrency: e.priceCurrency,
            inOffer: e.inOffer,
            mainImage: e.mainImage,
            images: e.images,
            category: e.category,
            visible: e.visible,
            sku: e.sku,
            stock: e.stock,
            tags: e.tags,
            isVariant: e.isVariant,
            variantsCode: e.variantsCode,
            createdAt: e.createdAt,
            v: e.v))
        .toList();
  }
}
