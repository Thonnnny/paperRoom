import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/app_bar.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/screens/detail/detail_screen.dart';

import '../../class/classApi.dart';
import '../../components/product_cardtocar.dart';

class MostPopularScreen extends StatefulWidget {
  const MostPopularScreen({super.key});

  static String route() => '/most_popular';

  @override
  State<MostPopularScreen> createState() => _MostPopularScreenState();
}

class _MostPopularScreenState extends State<MostPopularScreen> {
  ApisClass apisClass = ApisClass();
  late final datas = apisClass.getProductItems();

  @override
  void initState() {
    super.initState();
    apisClass.getProductItems().then((value) {
      print(value);
    });
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
        // body: CustomScrollView(slivers: [
        //   SliverPadding(
        //     padding: padding,
        //     sliver: SliverList(
        //       delegate: SliverChildBuilderDelegate(
        //         ((context, index) => const MostPupularCategory()),
        //         childCount: 1,
        //       ),
        //     ),
        //   ),
        body: Center(child: _buildPopularItem(context, 2))
        // const SliverAppBar(flexibleSpace: SizedBox(height: 24))
        );
  }

  // Widget _buildPopulars() {
  //   return SliverGrid(
  //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //       maxCrossAxisExtent: 185,
  //       mainAxisSpacing: 24,
  //       crossAxisSpacing: 16,
  //     ),
  //     delegate: SliverChildBuilderDelegate(_buildPopularItem, childCount: 1),
  //   );
  // }

  Widget _buildPopularItem(BuildContext context, int index) {
    return FutureBuilder(
      future: apisClass.getProductItems(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      ProductCardtoCar(
                        data: snapshot.data![index],
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopDetailScreen(
                                data: snapshot.data![index],
                              ))));
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
