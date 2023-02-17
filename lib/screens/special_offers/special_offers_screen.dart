import 'package:flutter/material.dart';
import 'package:freshbuyer/components/app_bar.dart';
import 'package:freshbuyer/components/special_offer_widget.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/productsInOffer.dart';

import '../../class/classProductsInOffer.dart';
import '../../components/specialOfferCardScreen.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key, required this.datas});
  final List<Offer> datas;

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();

  static String route() => '/special_offers';
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  late Future<List<Offer>> _products;
  ProductsOfferRepository offer = ProductsOfferRepository();
  @override
  void initState() {
    super.initState();
    _products = offer.getProductsInOffer();
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
      body: FutureBuilder<List<Offer>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.length;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];
                return Column(
                  children: [
                    SpecialOfferCardWidget(context, data: data, index: index),
                    const SizedBox(height: 10),
                  ],
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
