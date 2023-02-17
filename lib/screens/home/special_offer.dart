import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshbuyer/components/special_offer_widget.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/model/productsInOffer.dart';

import '../../class/classProductsInOffer.dart';
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
  late Future<List<Offer>> _products;
  ProductsOfferRepository offer = ProductsOfferRepository();
  @override
  void initState() {
    super.initState();
    _products = offer.getProductsInOffer();
  }

  int items = 0;
  List<Widget> list = [];
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
            child: FutureBuilder<List<Offer>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  items = snapshot.data!.length;
                  return PageView.builder(
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return SpecialOfferWidget(context,
                          data: data, index: index);
                    },
                    itemCount: snapshot.data!.length,
                    allowImplicitScrolling: true,
                    onPageChanged: (value) {
                      setState(() {
                        selectIndex = value;
                        items = snapshot.data!.length;
                        list = [];
                      });
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
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

  Widget buildPageIndicator(int items) {
    print('items: $items');
    var size = MediaQuery.of(context).size;

    for (int i = 0; i < items; i++) {
      list.add(i == selectIndex ? indicator(true) : indicator(false));
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
