// import 'dart:convert';

// import 'package:freshbuyer/model/cartResponses.dart';
// import 'package:freshbuyer/model/currencyResponse.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../helpers/base_client.dart';
// import '../helpers/res_apis.dart';
// import '../model/customerResponse.dart';

// class CartOnlyObjectCar {
//   Future<CartClass> getOnlyObjectCart() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('accesstoken');
//     var response = await BaseClient().get(RestApis.getCart,
//         {"Content-Type": "application/json", "accesstoken": token});
//     print('This is the response from the cart screen');
//     print(response);
//     var rsp = jsonDecode(response);
//     if (rsp['type'] == 'success') {
//       Cart cart = Cart.fromJson(rsp);
//       if (cart.cart?.customer?.fullname == null) {
//         return CartClass(
//             customer: Customer(
//               fullname: '',
//               reference: '',
//             ),
//             items: [],
//             total: 0,
//             actualStatus: '',
//             createdAt: DateTime.now(),
//             id: '',
//             lastUpdate: DateTime.now(),
//             paymentDate: DateTime.now(),
//             paymentStatus: '',
//             statusHistory: [],
//             totalCurrency: Currency(
//               code: '',
//               name: '',
//               symbol: '',
//               createdAt: DateTime.now(),
//               id: '',
//               v: 0,
//             ),
//             v: 0);
//       } else {
//         return cart.cart!;
//       }
//     } else {
//       print('No hay productos en el carrito');
//       return CartClass(
//           customer: Customer(
//             fullname: '',
//             reference: '',
//           ),
//           items: [],
//           total: 0,
//           actualStatus: '',
//           createdAt: DateTime.now(),
//           id: '',
//           lastUpdate: DateTime.now(),
//           paymentDate: DateTime.now(),
//           paymentStatus: '',
//           statusHistory: [],
//           totalCurrency: Currency(
//             code: '',
//             name: '',
//             symbol: '',
//             createdAt: DateTime.now(),
//             id: '',
//             v: 0,
//           ),
//           v: 0);
//     }
//   }
// }
