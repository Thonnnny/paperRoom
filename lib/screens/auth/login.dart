import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:freshbuyer/helpers/res_apis.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../components/background.dart';
import '../../components/rounded_button.dart';
import '../../helpers/base_client.dart';
import '../../providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool? _passwordVisible;

  Future<dynamic> login(String username, String password) async {
    Map data = {
      'username': username,
      'password': password,
    };
    bool remember = false;
    if ('username' == "" && 'password' == "" && remember == true) {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Oops!",
              text: "Campos Vacios"));
    }
    var response = await BaseClient().post('${RestApis.apiCustomer}/login',
        data, {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("***********************************************login");
      print(response);
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.success,
              title: "Bienvenido!",
              text: "Iniciaste sesion correctamente"));
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    } else {
      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Oops!",
              text: "Usuario o contraseña incorrectos"));
    }
  }

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.06),
            const Text(
              "INICIA SESIÓN",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 30, color: color6),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Lottie.asset('assets/images/login.json')),
            SizedBox(height: size.height * 0.03),
            ChangeNotifierProvider(
                create: (_) => LoginFormProvider(), child: _loginForm()),
            // SwitchListTile(
            //     value: Preferences.remember,
            //     onChanged: (value) {
            //       Preferences.remember = value;
            //       setState(() {});
            //     },
            //     title: const Text('Recordar usuario')),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    Size size = MediaQuery.of(context).size;
    return Form(
        child: Column(
      children: [
        _crearUsuario(),
        SizedBox(height: size.height * 0.01),
        _crearPassword(),
        SizedBox(height: size.height * 0.03),
        RoundedButton(
          color: color3,
          text: "INGRESA ",
          press: () {
            login(username.text, password.text);
            FocusScope.of(context).unfocus();
          },
        ),
        SizedBox(height: size.height * 0.03),
      ],
    ));
  }

  Widget _crearUsuario() {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 50),
      child: TextField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        onChanged: (value) => loginForm.usuario = value,
        // validator: (value) {
        //   String pattern =
        //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        //   RegExp regExp = new RegExp(pattern);

        //   return regExp.hasMatch(value ?? '')
        //       ? null
        //       : 'El valor ingresado no luce como un correo';
        // },
        style: const TextStyle(color: Colors.white),
        controller: username,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          icon: const Icon(
            Icons.person,
            color: color6,
            size: 30,
          ),
          hintText: "Usuario",
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
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 50),
      child: TextField(
        autocorrect: false,
        onChanged: (value) => loginForm.password = value,
        // validator: (value) {
        //   return (value != null && value.length >= 6)
        //       ? null
        //       : 'La contraseña debe de ser de 6 caracteres';
        // },
        style: const TextStyle(color: Colors.white),
        //keyboardType: TextInputType.,
        controller: password,
        obscureText: _passwordVisible!,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 3.0),
              borderRadius: BorderRadius.circular(20)),
          hintText: "Contraseña",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist'),
          icon: const Icon(
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
}
