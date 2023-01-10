import 'package:flutter/material.dart';
// import 'package:freshbuyer/model/category.dart';
// import 'package:freshbuyer/model/priceAcurrecy.dart';
// import 'package:freshbuyer/model/productElement.dart';
import 'package:freshbuyer/screens/detail/detail_screen.dart';

import 'package:freshbuyer/screens/home/home.dart';
import 'package:freshbuyer/screens/mostpopular/most_popular_screen.dart';
import 'package:freshbuyer/screens/profile/profile_screen.dart';
import 'package:freshbuyer/screens/special_offers/special_offers_screen.dart';
import 'package:freshbuyer/screens/test/test_screen.dart';
import 'package:freshbuyer/screens/wallet/wallet_screen.dart';

import 'model/category.dart';
import 'model/priceAcurrecy.dart';
import 'model/productElement.dart';

var initialRoute = HomeScreen.route();
final Category category = Category(
    createdAt: DateTime.now(), description: '', id: '', name: '', v: 1);
final PriceCurrency priceCurrency = PriceCurrency(
    createdAt: DateTime.now(), code: '', id: '', name: '', symbol: '', v: 1);
final Product product = Product(
    category: category,
    createdAt: DateTime.now(),
    description: '',
    id: '',
    images: [],
    inOffer: false,
    isVariant: false,
    mainImage: '',
    name: '',
    price: 0,
    priceCurrency: priceCurrency,
    sku: '',
    stock: 0,
    tags: [],
    v: 0,
    variantsCode: '',
    visible: false);

final Map<String, WidgetBuilder> routes = {
  HomeScreen.route(): (context) => const HomeScreen(title: '123'),
  WalletScreen.route(): (context) => const WalletScreen(),
  MostPopularScreen.route(): (context) => const MostPopularScreen(),
  SpecialOfferScreen.route(): (context) => const SpecialOfferScreen(),
  // ignore: prefer_const_constructors
  ShopDetailScreen.route(): (context) => ShopDetailScreen(
        data: product,
      ),
  ProfileScreen.route(): (context) => const ProfileScreen(),
  TestScreen.route(): (context) => const TestScreen(),
};
