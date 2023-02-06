import 'package:flutter/material.dart';
import 'package:freshbuyer/screens/auth/login.dart';
import 'package:freshbuyer/screens/auth/register.dart';
import 'package:freshbuyer/screens/home/home.dart';
import 'package:freshbuyer/screens/profile/profile_screen.dart';
import 'package:freshbuyer/screens/special_offers/special_offers_screen.dart';
import 'package:freshbuyer/screens/test/test_screen.dart';
import 'package:freshbuyer/screens/wallet/wallet_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.route(): (context) => const HomeScreen(title: '123'),
  LoginScreen.route(): (context) => const LoginScreen(),
  RegisterScreen.route(): (context) => const RegisterScreen(),
  WalletScreen.route(): (context) => const WalletScreen(),
  // MostPopularScreen.route(): (context) => const MostPopularScreen(),
  SpecialOfferScreen.route(): (context) => const SpecialOfferScreen(),
  // ignore: prefer_const_constructors

  ProfileScreen.route(): (context) => const ProfileScreen(),
  TestScreen.route(): (context) => const TestScreen(),
};
