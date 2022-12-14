import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/routes.dart';

import '../bloc/cart/bloc/cart_bloc.dart';

import '../components/app_button.dart';
import '../components/app_text.dart';
import '../components/item_counter.dart';

import '../model/productElement.dart';
import 'checkout_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  final Product product;

  const CartScreen({super.key, required this.product});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double height = 110;
  Color borderColor = Color(0xffE2E2E2);
  double borderRadius = 18;
  int amount = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.existCart
              ? SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Carrito de compras",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: color3),
                        ),
                        const Divider(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                              height: height,
                              margin: const EdgeInsets.symmetric(
                                vertical: 30,
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    imageWidget(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: '${widget.product.name}',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: color6,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        AppText(
                                            text: '${widget.product.price}'
                                                .toString(),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: color2),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        // const Spacer(),
                                        ItemCounterWidget(
                                          onAmountChanged: (newAmount) {
                                            setState(() {
                                              amount = newAmount;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Icon(
                                          Icons.close,
                                          color: color3,
                                          size: 25,
                                        ),
                                        const Spacer(
                                          flex: 5,
                                        ),
                                        SizedBox(
                                          width: 70,
                                          child: AppText(
                                            text:
                                                "\$${getPrice().toStringAsFixed(2)}",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            textAlign: TextAlign.right,
                                            color: color3,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        getCheckoutButton(context)
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text("No hay productos en el carrito",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color3)),
                );
        },
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 135,
      child: Image.network('${widget.product.mainImage}'),
    );
  }

  int getPrice() {
    return widget.product.price * amount;
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        roundness: 25,
        label: "Hacer pedido",
        fontWeight: FontWeight.w600,
        padding: const EdgeInsets.symmetric(vertical: 30),
        // trailingWidget: getButtonPriceWidget(),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        "\$12.96",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return const CheckoutBottomSheet();
        });
  }
}
