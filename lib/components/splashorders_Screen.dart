import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freshbuyer/cart/cart_screen.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/screens/tabbar/tabbar.dart';
import 'package:lottie/lottie.dart';

class SplashOrdersScreen extends StatefulWidget {
  const SplashOrdersScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashOrdersScreenState createState() => _SplashOrdersScreenState();
}

class _SplashOrdersScreenState extends State<SplashOrdersScreen> {
  @override
  void initState() {
    super.initState();

    const delay = Duration(seconds: 3);

    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    // ignore: unnecessary_new
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        // ignore: prefer_const_constructors
        return FRTabbarScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      body: Center(
        child: splashScreenIcon(),
      ),
    );
  }
}

Widget splashScreenIcon() {
  String iconPath = 'assets/images/confirmed.json';
  return Lottie.asset(iconPath);
}
