import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshbuyer/model/productElement.dart';

import '../../bloc/shop/shop_bloc.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late List<Product> cartItems;
  double totalAmount = 0;
  void calculateTotalAmount(List<Product> list) {
    double res = 0;

    list.forEach((element) {
      res = res + element.price * element.price;
    });
    totalAmount = res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        if (state is ShopPageLoadedState) {
          cartItems = state.cartData.shopitems;
          calculateTotalAmount(cartItems);
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }

        if (state is ItemAddingCartState) {
          cartItems = state.cartItems;
          calculateTotalAmount(cartItems);
        }
        return Scaffold(
          backgroundColor: Colors.yellow,
          appBar: AppBar(
            backgroundColor: Color(0XFFF8F5F0),
            title: const Text(
              'Shopping Cart',
              style: TextStyle(color: Colors.purple),
            ),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          bottomNavigationBar: Container(
            height: 68,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 8,
                    color: const Color(0xFF000000).withOpacity(0.20),
                  ),
                  BoxShadow(
                    offset: const Offset(0, -1),
                    blurRadius: 3,
                    color: const Color(0xFF000000).withOpacity(0.20),
                  ),
                  BoxShadow(
                    offset: const Offset(0, -1),
                    blurRadius: 4,
                    color: const Color(0xFF000000).withOpacity(0.14),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                )),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const Text('Total Amount'),
                  Text('\$${totalAmount.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
          body: cartItems == null || cartItems.length == 0
              ? const Center(child: Text('Your Cart is Empty'))
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    cartItems[index].mainImage,
                                    height: 64,
                                    width: 64,
                                  ),
                                  SizedBox(width: 20),
                                  Text(cartItems[index].name),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        if (state is ShopPageLoadedState) {
                                          state.cartData.shopitems
                                              .removeAt(index);
                                          calculateTotalAmount(cartItems);
                                          BlocProvider.of<ShopBloc>(context)
                                              .add(ItemDeleteCartEvent(
                                                  cartItems:
                                                      state.cartData.shopitems,
                                                  index: index));
                                        } else if (state
                                            is ItemAddedCartState) {
                                          state.cartItems.removeAt(index);
                                          calculateTotalAmount(cartItems);

                                          // ignore: avoid_single_cascade_in_expression_statements
                                          BlocProvider.of<ShopBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems: state.cartItems,
                                                index: index));
                                        } else if (state
                                            is ItemDeletingCartState) {
                                          state.cartItems.removeAt(index);
                                          calculateTotalAmount(cartItems);

                                          // ignore: avoid_single_cascade_in_expression_statements
                                          BlocProvider.of<ShopBloc>(context)
                                            ..add(ItemDeleteCartEvent(
                                                cartItems: state.cartItems,
                                                index: index));
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      if (cartItems[index].price > 0)
                                        setState(() {
                                          calculateTotalAmount(cartItems);
                                          cartItems[index].price--;
                                        });
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 0.5)),
                                      child: Text(
                                        cartItems[index].price.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        calculateTotalAmount(cartItems);
                                        cartItems[index].price++;
                                      });
                                    },
                                  ),
                                  Spacer(),
                                  Text(
                                      '\$${cartItems[index].price * cartItems[index].price} ')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
