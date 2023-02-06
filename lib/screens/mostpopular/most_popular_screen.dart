import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/app_bar.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/screens/detail/detail_screen.dart';

import '../../class/classApi.dart';
import '../../components/product_cardtocar.dart';
import '../../model/productElement.dart';

class MostPopularScreen extends StatefulWidget {
  const MostPopularScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<MostPopularScreen> createState() => _MostPopularScreenState();
}

class _MostPopularScreenState extends State<MostPopularScreen> {
  late Future<List<Product>> _products;
  ApisClass apisClass = ApisClass();
  @override
  void initState() {
    super.initState();
    _products = apisClass.getProductItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color4,
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
        body: Center(child: _buildPopularItem(context, 2)));
  }

  Widget _buildPopularItem(BuildContext context, int index) {
    return FutureBuilder(
      future: _products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Product product = snapshot.data![index];
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      ProductCardtoCar(
                        data: snapshot.data![index],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => SafeArea(
                                    child: ShopDetailScreen(
                                  product: product,
                                ))),
                        (Route<dynamic> route) => false);
                  });
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
