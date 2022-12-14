import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/product_card.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/helpers/base_client.dart';
import 'package:freshbuyer/helpers/res_apis.dart';
import 'package:freshbuyer/model/productResponse.dart';
import 'package:freshbuyer/screens/detail/detail_screen.dart';
import 'package:freshbuyer/screens/home/hearder.dart';
import 'package:freshbuyer/screens/home/most_popular.dart';
import 'package:freshbuyer/screens/home/search_field.dart';
import 'package:freshbuyer/screens/home/special_offer.dart';
import 'package:freshbuyer/screens/mostpopular/most_popular_screen.dart';
import 'package:freshbuyer/screens/special_offers/special_offers_screen.dart';
import 'package:freshbuyer/class/classApi.dart';

import '../../model/productElement.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  static String route() => '/home';

  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApisClass apisClass = ApisClass();
  late final datas = apisClass.getProductItems();
  @override
  void initState() {
    super.initState();
    apisClass.getProductItems().then((value) {
      print(
          '*************************this is your product data home *************');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.fromLTRB(20, 20, 10, 0);
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
                iconTheme: IconThemeData(color: Colors.white, size: 34),
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
        MostPopularTitle(onTapseeAll: () => _onTapMostPopularSeeAll(context)),
        const SizedBox(height: 24),
        const MostPupularCategory(),
      ],
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
    return FutureBuilder<List<Product>>(
      future: apisClass.getProductItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      ProductCard(
                        data: snapshot.data![index],
                      )
                    ],
                  ),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShopDetailScreen(
                                  data: snapshot.data![index],
                                )),
                      ));
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  void _onTapMostPopularSeeAll(BuildContext context) {
    Navigator.pushNamed(context, MostPopularScreen.route());
  }

  void _onTapSpecialOffersSeeAll(BuildContext context) {
    Navigator.pushNamed(context, SpecialOfferScreen.route());
  }
}
