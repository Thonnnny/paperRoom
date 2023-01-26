import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshbuyer/model/productElement.dart';
import 'package:freshbuyer/screens/UI/shopping_cart.dart';

import '../../bloc/shop/shop_bloc.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.shopItem}) : super(key: key);

  final Product shopItem;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Product> cartItems = [];

  bool _itemselected = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {},
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ItemAddingCartState) {
            cartItems = state.cartItems;
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "E-com",
              ),
              elevation: 0,
              backgroundColor: Colors.orange,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      height: 350,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(widget.shopItem.mainImage),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  widget.shopItem.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  '\$${widget.shopItem.price}',
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Quantity',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (widget.shopItem.price > 0)
                                      setState(() {
                                        widget.shopItem.price--;
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
                                      widget.shopItem.price.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      widget.shopItem.price++;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                            onPressed: () {
                              if (_itemselected == false) {
                                Product cartItem = Product(
                                  mainImage: widget.shopItem.mainImage,
                                  name: widget.shopItem.name,
                                  price: widget.shopItem.price,
                                  category: widget.shopItem.category,
                                  description: widget.shopItem.description,
                                  id: widget.shopItem.id,
                                  createdAt: widget.shopItem.createdAt,
                                  images: widget.shopItem.images,
                                  inOffer: widget.shopItem.inOffer,
                                  isVariant: widget.shopItem.isVariant,
                                  priceCurrency: widget.shopItem.priceCurrency,
                                  sku: widget.shopItem.sku,
                                  stock: widget.shopItem.stock,
                                  tags: widget.shopItem.tags,
                                  v: widget.shopItem.v,
                                  variantsCode: widget.shopItem.variantsCode,
                                  visible: widget.shopItem.visible,
                                );

                                cartItems.add(cartItem);

                                // ignore: avoid_single_cascade_in_expression_statements
                                BlocProvider.of<ShopBloc>(context)
                                  ..add(
                                      ItemAddedCartEvent(cartItems: cartItems));

                                setState(() {
                                  _itemselected = true;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<ShopBloc>(context),
                                      child: ShoppingCart(),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              _itemselected ? 'Go to Cart' : 'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
