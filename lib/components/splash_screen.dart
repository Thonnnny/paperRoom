import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';
import '../screens/auth/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    const delay = Duration(seconds: 4);

    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    // ignore: unnecessary_new
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        // ignore: prefer_const_constructors
        return WelcomeScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color5,
      body: Center(
        child: splashScreenIcon(),
      ),
    );
  }
}

Widget splashScreenIcon() {
  String iconPath = "assets/images/LOGO.png";
  return Image.asset(
    iconPath,
  );
}
