import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/product_card.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/helpers/base_client.dart';
import 'package:freshbuyer/helpers/res_apis.dart';
import 'package:freshbuyer/screens/home/hearder.dart';
import 'package:freshbuyer/screens/home/most_popular.dart';
import 'package:freshbuyer/screens/home/search_field.dart';
import 'package:freshbuyer/screens/home/special_offer.dart';
import 'package:freshbuyer/screens/mostpopular/most_popular_screen.dart';
import 'package:freshbuyer/screens/special_offers/special_offers_screen.dart';
import 'package:freshbuyer/class/classApi.dart';
import 'package:lottie/lottie.dart';

import '../../model/productElement.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> productsList = [];
  ApisClass apisClass = ApisClass();

  Future<List<dynamic>> getProductItems() async {
    try {
      final response = await BaseClient()
          .get(RestApis.getProducts, {"Content-Type": "application/json"});
      print(response);
      final rsp = jsonDecode(response);
      if (rsp['type'] == 'success') {
        setState(() {
          productsList = rsp['products'];
          print('This is the response from the Products Screen');
          print(productsList);
        });
      }
      return productsList;
    } catch (e) {
      print('Error in getProductsInOffer: $e');
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getProductItems();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.fromLTRB(10, 20, 10, 0);

    return SafeArea(
      child: Scaffold(
        backgroundColor: color4,
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            const SliverPadding(
              padding: EdgeInsets.only(top: 0),
              sliver: SliverAppBar(
                elevation: 30,
                centerTitle: true,
                backgroundColor: color5,
                iconTheme: IconThemeData(color: Colors.transparent, size: 34),
                pinned: true,
                flexibleSpace: HomeAppBar(),
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  ((context, index) => _buildBody(context)),
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: padding,
              sliver: _buildPopulars(),
            ),

            //const SliverAppBar(flexibleSpace: SizedBox(height: 24))
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SearchField(),
        const SizedBox(height: 24),
        SpecialOffers(onTapSeeAll: () => _onTapSpecialOffersSeeAll(context)),
        const SizedBox(height: 24),
        MostPopularTitle(onTapseeAll: () {
          _onTapMostPopularSeeAll(context);
        }),
        _buildLine(),
        const SizedBox(height: 24),
        const MostPupularCategory(),
      ],
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

  Widget _buildPopulars() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 600,
        maxCrossAxisExtent: 400,
        childAspectRatio: 0.7,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: 1),
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    if (productsList.isEmpty) {
      return Container(
        height: size.height * 0.9,
        width: size.width * 0.9,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Por los momentos no hay productos en tienda🙃\nPronto tendremos ofertas!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Center(
                  child: Container(
                      child: Lottie.asset('assets/images/empty.json')),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            color: color2,
            child: GestureDetector(
                child: Stack(
                  children: <Widget>[
                    ProductCard(
                      data: productsList[index],
                    )
                  ],
                ),
                onTap: () {}),
          );
        },
      );
    }
  }

  void _onTapMostPopularSeeAll(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const MostPopularScreen()),
        (Route<dynamic> route) => false);
  }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => const SpecialOfferScreen(
                  datas: [],
                )),
        (Route<dynamic> route) => false);
  }
}
