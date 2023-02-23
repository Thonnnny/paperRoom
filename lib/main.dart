import 'package:flutter/material.dart';
import 'package:freshbuyer/providers/login_provider.dart';
import 'package:freshbuyer/providers/orders_provider.dart';
import 'package:freshbuyer/providers/register_provider.dart';
import 'package:freshbuyer/screens/auth/checkConnection.dart';

import 'package:freshbuyer/screens/auth/validateToken.dart';
import 'package:freshbuyer/screens/tabbar/tabbar.dart';
import 'package:freshbuyer/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/splash_screen.dart';

final internetChecker = CheckInternetConnection();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await PushNotificationService.initializeApp();
  ValidateToken validateToken = ValidateToken();
  await validateToken.handleSession();
  runApp(const PaperRoomApp());
}

var prefs = SharedPreferences.getInstance();

class PaperRoomApp extends StatefulWidget {
  const PaperRoomApp({super.key});

  @override
  State<PaperRoomApp> createState() => _PaperRoomAppState();
}

class _PaperRoomAppState extends State<PaperRoomApp> {
  bool? validateUser;

  void getSaveToken() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? saveToken = prefs.getBool('savetoken');
    validateUser = saveToken;
    print('This is the save token bool $validateUser');
  }

  @override
  void initState() {
    super.initState();
    getSaveToken();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginFormProvider()),
        ChangeNotifierProvider.value(value: RegisterFormProvider()),
        ChangeNotifierProvider.value(value: OrderFormProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Paper Room',
        theme: appTheme(),
        initialRoute:
            validateUser != 'false' ? '/login' : '/home', //'/login', //'/home',
        routes: {
          '/login': (BuildContext context) => const SplashScreen(),
          '/home': (BuildContext context) =>
              const SafeArea(child: FRTabbarScreen()),
        },
      ),
    );
  }
}
