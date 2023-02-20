import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/app_bar.dart';
import 'package:freshbuyer/components/special_offer_widget.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/productsInOffer.dart';

import '../../components/specialOfferCardScreen.dart';
import '../../helpers/base_client.dart';
import '../../helpers/res_apis.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key, required this.datas});
  final List<Offer> datas;

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();

  static String route() => '/special_offers';
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  List<dynamic> productInOfferList = [];

  @override
  void initState() {
    super.initState();
    getProductsInOffer();
  }

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
    return Scaffold(
      backgroundColor: color4,
      appBar: FRAppBar.defaultAppBar(
        context,
        title: 'Ofertas',
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/search@2x.png', scale: 2.0),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final data = productInOfferList[index];
          print('This is the data for all from the product in offer screen');
          print(data);
          return Column(
            children: [
              SpecialOfferCardWidget(context, data: data, index: index),
              const SizedBox(height: 10),
            ],
          );
        },
        itemCount: productInOfferList.length,
      ),
    );
  }
}
