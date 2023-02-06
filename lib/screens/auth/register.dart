import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/screens/auth/login.dart';

import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../components/already_have_account.dart';
import '../../components/background.dart';
import '../../components/rounded_button.dart';
import '../../providers/register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  static String route() => '/register';

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reconfirmPassword = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool? _passwordVisible;
  bool? _reconfirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    reconfirmPassword = TextEditingController();
    fullName = TextEditingController();
    phone = TextEditingController();
    _passwordVisible = true;
    _reconfirmPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.06),
              const Text(
                "REGISTRO",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: color6,
                  fontFamily: 'Urbanist',
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Lottie.asset('assets/images/register.json')),
              SizedBox(height: size.height * 0.03),
              ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child: _registerForm()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerForm() {
    Size size = MediaQuery.of(context).size;
    return Form(
        child: Column(
      children: [
        _crearUsuario(),
        SizedBox(height: size.height * 0.01),
        _crearFullname(),
        SizedBox(height: size.height * 0.01),
        _crearTelefono(),
        SizedBox(height: size.height * 0.01),
        _crearPassword(),
        SizedBox(height: size.height * 0.01),
        _crearReconfirmPassword(),
        SizedBox(height: size.height * 0.01),
        AlreadyHaveAnAccountCheck(
          login: false,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreen();
                },
              ),
            );
          },
        ),
        SizedBox(height: size.height * 0.01),
        RoundedButton(
          color: color3,
          text: "INGRESA ",
          press: () {
            // login(email.text, password.text);
            FocusScope.of(context).unfocus();
          },
        ),
        SizedBox(height: size.height * 0.03),
      ],
    ));
  }

  Widget _crearUsuario() {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => registerForm.email = value,
        validator: (value) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          return regExp.hasMatch(value ?? '')
              ? null
              : 'El valor ingresado no luce como un correo';
        },
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist'),
        controller: email,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Icon(
            Icons.email,
            color: color6,
            size: 30,
          ),
          hintText: "Correo electrónico",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _crearPassword() {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        autocorrect: false,
        onChanged: (value) => registerForm.password = value,
        validator: (value) {
          return (value != null && value.length >= 6)
              ? null
              : 'La contraseña debe de ser de 6 caracteres';
        },
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist'),
        //keyboardType: TextInputType.,
        controller: password,
        obscureText: _passwordVisible!,
        cursorColor: color4,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          hintText: "Contraseña",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          prefixIcon: const Icon(
            Icons.lock,
            color: color6,
            size: 30,
          ),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(right: 20),
            tooltip: 'Ver contraseña',
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible != false
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: color6,
              size: 30,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible!;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _crearReconfirmPassword() {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        autocorrect: false,
        onChanged: (value) => registerForm.reconfirmPassword = value,
        validator: (value) {
          if (value!.isEmpty) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Oops...',
              text: 'Ingresa una contraseña',
              confirmBtnColor: Colors.red,
              confirmBtnText: 'Reintentar',
            );
          }
          if (value != password.text) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Oops...',
              text: 'Las contraseñas no coinciden',
              confirmBtnColor: Colors.red,
              confirmBtnText: 'Reintentar',
            );
          }
          return null;
        },
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist'),
        //keyboardType: TextInputType.,
        controller: reconfirmPassword,
        obscureText: _reconfirmPasswordVisible!,
        cursorColor: color4,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          hintText: "Confirma contraseña",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          prefixIcon: const Icon(
            Icons.lock,
            color: color6,
            size: 30,
          ),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(right: 20),
            tooltip: 'Ver contraseña',
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _reconfirmPasswordVisible != false
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: color6,
              size: 30,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _reconfirmPasswordVisible = !_reconfirmPasswordVisible!;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _crearTelefono() {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.phone,
        onChanged: (value) => registerForm.phone = value,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingrese su telefono';
          }
          if (value.length > 8) {
            return 'Por favor ingrese un telefono valido';
          } else {
            return 'se necesita un telefono valido';
          }
        },
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.bold),
        controller: phone,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.contact_phone,
              color: color6,
              size: 30,
            ),
          ),
          hintText: "Teléfono",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _crearFullname() {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        onChanged: (value) => registerForm.fullName = value,
        validator: (value) => value == null || value.isEmpty
            ? 'El campo no puede estar vacio'
            : null,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Urbanist',
        ),
        controller: fullName,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.person,
              color: color6,
              size: 30,
            ),
          ),
          hintText: "Nombre completo",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
