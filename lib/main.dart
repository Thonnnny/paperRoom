import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshbuyer/bloc/cart/bloc/cart_bloc.dart';
import 'package:freshbuyer/bloc/orders/bloc/orders_bloc.dart';
import 'package:freshbuyer/bloc/product/bloc/product_bloc.dart';
import 'package:freshbuyer/bloc/user/bloc/user_bloc.dart';
import 'package:freshbuyer/routes.dart';
import 'package:freshbuyer/theme.dart';

import 'components/splash_screen.dart';

void main() {
  runApp(const PaperRoomApp());
}

class PaperRoomApp extends StatelessWidget {
  const PaperRoomApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => OrdersBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fresh-Buyer',
        theme: appTheme(),
        routes: routes,
        home: const SplashScreen(),
      ),
    );
  }
}
