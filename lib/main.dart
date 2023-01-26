import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freshbuyer/bloc/cart/bloc/cart_bloc.dart';
import 'package:freshbuyer/bloc/orders/bloc/orders_bloc.dart';
import 'package:freshbuyer/bloc/product/bloc/product_bloc.dart';
import 'package:freshbuyer/bloc/shop/shop_bloc.dart';
import 'package:freshbuyer/bloc/user/bloc/user_bloc.dart';
import 'package:freshbuyer/components/push_notification.dart';
import 'package:freshbuyer/providers/login_provider.dart';
import 'package:freshbuyer/providers/orders_provider.dart';
import 'package:freshbuyer/routes.dart';
import 'package:freshbuyer/screens/auth/login.dart';
import 'package:freshbuyer/screens/auth/validateToken.dart';
import 'package:freshbuyer/screens/tabbar/tabbar.dart';
import 'package:freshbuyer/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ValidateToken validateToken = ValidateToken();
  await validateToken.handleSession();
  //await PushNotificationService.initializeApp();
  runApp(const PaperRoomApp());
}

var prefs = SharedPreferences.getInstance();
bool? validateUser;

class PaperRoomApp extends StatefulWidget {
  const PaperRoomApp({super.key});

  @override
  State<PaperRoomApp> createState() => _PaperRoomAppState();
}

class _PaperRoomAppState extends State<PaperRoomApp> {
  void getSaveToken() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? saveToken = prefs.getBool('savetoken');
    validateUser = saveToken;
    print('*************************this is the token*********************');
    print(validateUser);
  }

  @override
  void initState() {
    super.initState();
    getSaveToken();
  }

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
        BlocProvider(
          create: (context) => ShopBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: LoginFormProvider()),
          ChangeNotifierProvider.value(value: OrderFormProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fresh-Buyer',
          theme: appTheme(),
          initialRoute: validateUser == false || validateUser == null
              ? '/login'
              : validateUser == true
                  ? '/home'
                  : '/login',
          routes: {
            '/login': (BuildContext context) => const SplashScreen(),
            '/home': (BuildContext context) => const FRTabbarScreen(),
          },
        ),
      ),
    );
  }
}
