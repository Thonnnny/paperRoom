import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/background.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';
import '../../providers/login_provider.dart';
import '../tabbar/tabbar.dart';
import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Bienvenido a",
                style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: color2),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'PAPER ROOM',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: color6,
                      fontFamily: 'Urbanist'),
                ),
              ),
              Lottie.asset('assets/images/welcome.json'),
              RoundedButton(
                text: "INGRESAR",
                color: color3,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // ignore: prefer_const_constructors
                        return ChangeNotifierProvider(
                            create: (_) => LoginFormProvider(),
                            child: Container(
                                height: size.height,
                                child: const LoginScreen()));
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              RoundedButton(
                text: "VER TIENDA",
                color: color3,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        // ignore: prefer_const_constructors
                        return SafeArea(child: FRTabbarScreen());
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              // ignore: prefer_const_literals_to_create_immutables
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 40),
                child: Row(children: const <Widget>[
                  Text(
                    'Powered with',
                    style: TextStyle(
                        color: color3,
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.flash_on, color: color6),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'by',
                    style: TextStyle(
                        color: color3,
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Mondrian ITS',
                    style: TextStyle(
                        color: color6,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                        fontSize: 15),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
