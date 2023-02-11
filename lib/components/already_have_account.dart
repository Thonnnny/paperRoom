import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool? login;
  final VoidCallback? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ?? false
              ? "¿No tienes ninguna cuenta? "
              : "¿Ya tienes alguna cuenta? ",
          style: const TextStyle(
            color: color6,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ?? false ? "Regístrate aquí" : "Ingresa aquí",
            style: const TextStyle(
              color: color2,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
