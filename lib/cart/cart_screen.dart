import 'package:flutter/material.dart';
import 'package:freshbuyer/class/classCart.dart';
import 'package:freshbuyer/class/classCustomer.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/cartResponses.dart';

import '../components/app_button.dart';
import '../components/app_text.dart';

import '../components/splashorders_Screen.dart';
import '../model/customerResponse.dart';
import '../model/productCartResponse.dart';

class CartScreen extends StatefulWidget {
  final List<CartClass> product;

  const CartScreen({super.key, required this.product});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Color borderColor = const Color(0xffE2E2E2);
  double borderRadius = 18;
  int amount = 1;

  late Future<List<dynamic>> _products;
  late Future<Customer> _customer;
  CustomerCar customerClass = CustomerCar();
  ProductsCar apisClass = ProductsCar();
  @override
  void initState() {
    super.initState();
    _customer = customerClass.getCustomerCart();
    _products = apisClass.getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      // body: BlocBuilder<CartBloc, CartState>(
      //   builder: (context, state) {
      //     return state is CartEmpty
      //         ? const Center(
      //             child: Text("No hay productos en el carrito",
      //                 style: TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.bold,
      //                     color: color3)),
      //           )
      //         :0 SafeArea(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Carrito de compras",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color3),
              ),
              const Divider(
                height: 10,
                thickness: 2,
                color: color5,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    customerInfo(context),
                    myProductListCart(context),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              getCheckoutButton(context, widget.product.length),
            ],
          ),
        ),
      ),
    );
    // },
    // ),
    //);
  }

  Widget customerInfo(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<Customer>(
      future: _customer,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 1,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              //Item cart = snapshot.data![index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                height: size.height * 0.3,
                width: size.width * 0.9,
                child: IntrinsicHeight(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius)),
                    color: color2,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.45,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Expanded(
                                    child: Text(
                                      "${snapshot.data!.fullname}",
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: color6,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget myProductListCart(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<dynamic>>(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Item cart = snapshot.data![index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                height: size.height * 0.3,
                width: size.width,
                child: IntrinsicHeight(
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius)),
                    color: color2,
                    child: Row(
                      children: [
                        imageWidget(index, cart),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width * 0.45,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Expanded(
                                    child: Text(
                                      "${cart.productName}",
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: color6,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Expanded(
                                  child: AppText(
                                      text:
                                          'Precio por unidad: ${cart.productBilledPrice} Bs',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: color3),
                                ),
                              ),
                              Container(
                                width: size.width * 0.4,
                                child: Expanded(
                                  child: AppText(
                                      text: cart.productCode.toString(),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: color3),
                                ),
                              ),
                              // const Spacer(),
                              // ItemCounterWidget(
                              //   onAmountChanged: (newAmount) {
                              //     setState(() {
                              //       amount = newAmount;
                              //     });
                              //   },
                              // )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.close,
                                    color: color3,
                                    size: 25,
                                  ),
                                ),
                                const Spacer(
                                  flex: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.right,
                                    "\$${cart.quantity}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: color6,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget imageWidget(int index, Item cart) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 135,
      width: 135,
      child: Image.network(
        cart.mainImage.toString(),
        fit: BoxFit.cover,
      ),
    );
  }

  // int getPrice(int index) {
  //   return widget.product[index].price * amount;
  // }

  Widget getCheckoutButton(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        roundness: 25,
        label: "Hacer pedido",
        fontWeight: FontWeight.w600,
        padding: const EdgeInsets.symmetric(vertical: 30),
        //trailingWidget: getButtonPriceWidget(),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  // Widget getButtonPriceWidget() {
  //   return Container(
  //     padding: const EdgeInsets.all(2),
  //     decoration: BoxDecoration(
  //       color: const Color(0xff489E67),
  //       borderRadius: BorderRadius.circular(4),
  //     ),
  //     child: Text(
  //       widget.totalPrice.toString(),
  //       style: const TextStyle(fontWeight: FontWeight.w600),
  //     ),
  //   );
  // }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return const SplashOrdersScreen();
        });
  }
}
