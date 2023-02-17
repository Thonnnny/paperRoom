import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key, this.title = ''});

  static String route() => '/test';

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color2,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 70),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Estamos trabajando en nueva funcionalidad😊\nEsperalo!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Lottie.asset('assets/images/Working.json'),
              Container(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text('Mira la tienda',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
