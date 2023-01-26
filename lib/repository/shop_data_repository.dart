import '../helpers/base_client.dart';
import '../helpers/res_apis.dart';
import '../model/productElement.dart';

class ShopDataProvider {
  Future<ShopData> getShopItems() async {
    List<Product> shopItems = [];
    final response = await BaseClient()
        .get(RestApis.apiProducts, {"Content-Type": "application/json"});
    shopItems = response;
    return ShopData(shopitems: shopItems);
  }

  Future<ShopData> geCartItems() async {
    List<Product> shopItems = [];
    final response = await BaseClient()
        .get(RestApis.apiProducts, {"Content-Type": "application/json"});
    shopItems = response;
    return ShopData(shopitems: shopItems);
  }
}
