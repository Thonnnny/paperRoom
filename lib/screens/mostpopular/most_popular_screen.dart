import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/app_bar.dart';
import 'package:freshbuyer/components/product_card.dart';

import 'package:freshbuyer/model/productElement.dart';
import 'package:freshbuyer/model/productResponse.dart';
import 'package:freshbuyer/screens/detail/detail_screen.dart';
import 'package:freshbuyer/screens/home/most_popular.dart';

import '../../helpers/base_client.dart';
import '../../helpers/res_apis.dart';

class MostPopularScreen extends StatefulWidget {
  const MostPopularScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<MostPopularScreen> createState() => _MostPopularScreenState();
}

Future<List<Product>> getProducts() async {
  final response = await BaseClient()
      .get(RestApis.apiProducts, {"Content-Type": "application/json"});

  print("******************************************************response");
  print(response);

  final productResponse = ProductResponse.fromJson(jsonDecode(response));
  return productResponse.products;
}

class _MostPopularScreenState extends State<MostPopularScreen> {
  late final datas = getProducts();
  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.fromLTRB(24, 24, 24, 0);
    return Scaffold(
      appBar: FRAppBar.defaultAppBar(
        context,
        title: 'Más populares',
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/search@2x.png', scale: 2.0),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              ((context, index) => const MostPupularCategory()),
              childCount: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: padding,
          sliver: _buildPopulars(),
        ),
        const SliverAppBar(flexibleSpace: SizedBox(height: 24))
      ]),
    );
  }

  Widget _buildPopulars() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 185,
        mainAxisSpacing: 24,
        crossAxisSpacing: 16,
      ),
      delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: 1),
    );
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    return FutureBuilder(
      future: getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      ProductCard(
                        data: snapshot.data![index],
                      )
                    ],
                  ),
                  onTap: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ShopDetailScreen(data: snapshot.data![index])),
                      (Route<dynamic> route) => false));
            },
            itemCount: snapshot.data?.length,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
