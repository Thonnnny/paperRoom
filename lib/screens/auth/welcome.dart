import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/background.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';
import '../../providers/login_provider.dart';
import '../tabbar/tabbar.dart';
import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'PAPER ROOM',
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: color6,
                    fontFamily: 'Urbanist'),
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
                            child: const Scaffold(body: LoginScreen()));
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
              Row(children: <Widget>[
                const SizedBox(width: 100),
                const Text(
                  'Made with',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.favorite, color: color5),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  'by',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  'Mondrian',
                  style: TextStyle(
                      color: color6,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist',
                      fontSize: 15),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
