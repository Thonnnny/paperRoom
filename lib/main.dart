import 'package:flutter/material.dart';
import 'package:freshbuyer/routes.dart';
import 'package:freshbuyer/theme.dart';

import 'components/splash_screen.dart';

void main() {
  runApp(const FreshBuyerApp());
}

class FreshBuyerApp extends StatelessWidget {
  const FreshBuyerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh-Buyer',
      theme: appTheme(),
      routes: routes,
      home: const SplashScreen(),
    );
  }
}
