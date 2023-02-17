import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';
import 'package:lottie/lottie.dart';

class WaitingOrder extends StatelessWidget {
  const WaitingOrder({super.key, this.title = ''});

  static String route() => '/test';

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 100),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                '$title\nAun no tienes ordenes activas😊\nHaz una orden!',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Lottie.asset('assets/images/OrderNow.json'),
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
                  child: const Text('Ordenar ahora',
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
