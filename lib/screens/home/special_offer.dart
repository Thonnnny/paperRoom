import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshbuyer/components/special_offer_widget.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/productsInOffer.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../class/classProductsInOffer.dart';
import '../../helpers/base_client.dart';
import '../../helpers/res_apis.dart';
import '../../model/oldCategory.dart';

typedef SpecialOffersOnTapSeeAll = void Function();

class SpecialOffers extends StatefulWidget {
  final SpecialOffersOnTapSeeAll? onTapSeeAll;
  const SpecialOffers({super.key, this.onTapSeeAll});

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late final List<Category> categories = homeCategries;
  List<dynamic> productInOfferList = [];
  @override
  void initState() {
    super.initState();
    //_products = offer.getProductsInOffer();
    getProductsInOffer();
  }

  int items = 0;
  int selectIndex = 0;

  Future<List<dynamic>> getProductsInOffer() async {
    try {
      var response = await BaseClient().get(
          RestApis.getProductInOffer, {"Content-Type": "application/json"});
      var rsp = jsonDecode(response);
      if (rsp['type'] == 'success') {
        setState(() {
          productInOfferList = rsp['offers'];
          print('This is the response from the Products in Offer screen');
          print(productInOfferList);
        });
      }
      return productInOfferList;
    } catch (e) {
      print('Error in getProductsInOffer: $e');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (productInOfferList.isEmpty) {
      return Center(
        child: Card(
          elevation: 5,
          color: color2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Por los momentos no hay productos en oferta😊\nPronto tendremos ofertas!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: size.width * 0.5,
                      height: size.height * 0.3,
                      child: Lottie.asset('assets/images/noProducts.json')),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          _buildTitle(),
          _buildLine(),
          const SizedBox(height: 24),
          Stack(children: [
            Container(
              height: size.height * 0.45,
              decoration: const BoxDecoration(
                color: color3,
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: PageView.builder(
                itemBuilder: (context, index) {
                  final data = productInOfferList[index];
                  print('This is the data of Products in Offer: $data');
                  return SpecialOfferWidget(context, data: data, index: index);
                },
                itemCount: productInOfferList.length,
                allowImplicitScrolling: true,
                onPageChanged: (value) {
                  setState(() {
                    selectIndex = value;
                    items = productInOfferList.length;
                  });
                },
              ),
            ),
            buildPageIndicator(items),
          ]),
          const SizedBox(height: 24),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 100,
              mainAxisSpacing: 24,
              crossAxisSpacing: 10,
              maxCrossAxisExtent: 100,
            ),
            itemBuilder: ((context, index) {
              final data = categories[index];
              return GestureDetector(
                onTap: () {},
                // Navigator.pushNamed(context, MostPopularScreen.route()),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: color2,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          data.icon,
                          width: 35,
                          height: 35,
                          color: color5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FittedBox(
                      child: Text(
                        data.title,
                        style: const TextStyle(
                            color: color3,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      );
    }
  }

  Widget buildPageIndicator(int items) {
    var size = MediaQuery.of(context).size;
    List<Widget> list = [];
    for (int i = 0; i < items; i++) {
      list.add(indicator(i == selectIndex ? true : false));
    }
    if (items == 0) {
      list.add(indicator(true));
      const CircularProgressIndicator();
    }
    return Container(
      height: size.height * 0.45,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  Widget indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 4.0,
        width: isActive ? 16 : 4.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          color: isActive ? color6 : color2,
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      height: 2,
      width: 40,
      decoration: const BoxDecoration(
        color: color3,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Ofertas especiales',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: color3),
        ),
        TextButton(
          onPressed: () => widget.onTapSeeAll?.call(),
          child: const Text(
            'Ver Todo',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: color6),
          ),
        ),
      ],
    );
  }
}
