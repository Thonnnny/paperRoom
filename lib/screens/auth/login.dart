import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbuyer/helpers/res_apis.dart';
import 'package:freshbuyer/screens/auth/register.dart';
import 'package:freshbuyer/screens/auth/welcome.dart';
import 'package:freshbuyer/screens/tabbar/tabbar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../components/already_have_account.dart';

import '../../helpers/base_client.dart';
import '../../providers/login_provider.dart';
import '../../size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  static String route() => '/login';
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isChecked = false;
  bool? _passwordVisible;

  void login(String email, String password, bool remember) async {
    Map data = {
      'email': email,
      'password': password,
      'remember': remember,
    };
    if (email.isEmpty || password.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Campos vacios',
        confirmBtnColor: Colors.red,
        confirmBtnText: 'Reintentar',
        onConfirmBtnTap: () {
          Navigator.pop(context);
        },
      );
    } else {
      print('************************this is data login***************$data');
      var response = await BaseClient()
          .post(RestApis.apiLogin, data, {"Content-Type": "application/json"});
      final rsp = jsonDecode(response);
      print(
          '************************this is response decoding***************$rsp');
      if (rsp['type'] == 'error') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: '${rsp['message']}',
          confirmBtnColor: Colors.red,
          confirmBtnText: 'Reintentar',
        );
      }
      if (rsp['type'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', rsp['user']['userId'].toString());
        prefs.setString('fullname', rsp['user']['fullname']);
        prefs.setString('sessiontoken', rsp['sessiontoken']);
        prefs.setString('accesstoken', rsp['accesstoken']);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const SafeArea(child: FRTabbarScreen())),
            (Route<dynamic> route) => false);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Bienvenido',
          text: '${rsp['user']['fullname']} ' '${rsp['message']}',
          confirmBtnColor: Colors.green,
          confirmBtnText: 'Continuar',
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    _passwordVisible = true;
    _isChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: color4,
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: size.height * 0.4,
                    leading: IconButton(
                      icon: Image.asset(
                        'assets/icons/back@2x.png',
                        scale: 1,
                        color: color4,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const WelcomeScreen()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                          height: 428,
                          width: double.infinity,
                          color: color4,
                          child: Lottie.asset('assets/images/login.json')),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ..._buildTitle(),
                          const SizedBox(height: 10),
                          _buildLine(),
                          const SizedBox(height: 30),
                          ChangeNotifierProvider(
                              create: (_) => LoginFormProvider(),
                              child: _loginForm()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTitle() {
    var size = MediaQuery.of(context).size;
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.75,
            child: const Center(
              child: Text(
                'Inicio de sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 32, color: color3),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 3, color: color6);
  }

  Widget _loginForm() {
    Size size = MediaQuery.of(context).size;
    return Form(
        child: Column(
      children: [
        _crearUsuario(),
        SizedBox(height: size.height * 0.02),
        _crearPassword(),
        SizedBox(height: size.height * 0.01),
        remember(),
        SizedBox(height: size.height * 0.01),
        AlreadyHaveAnAccountCheck(
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const RegisterScreen();
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            backgroundColor: color3,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            login(email.text, password.text, _isChecked);
            FocusScope.of(context).unfocus();
          },
          child: const Text('INGRESA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: color2,
                fontFamily: 'Urbanist',
              )),
        ),
        SizedBox(height: size.height * 0.03),
      ],
    ));
  }

  Widget _crearUsuario() {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => loginForm.email = value,
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
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist'),
        controller: email,
        //cursorColor: firstColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 2.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 2.0),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: const Icon(
            Icons.person,
            color: color6,
            size: 30,
          ),
          hintText: "Email",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 15,
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
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        autocorrect: false,
        onChanged: (value) => loginForm.password = value,
        validator: (value) {
          return (value != null && value.length >= 6)
              ? null
              : 'La contraseña debe de ser de 6 caracteres';
        },
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist'),
        //keyboardType: TextInputType.,
        controller: password,
        obscureText: _passwordVisible!,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 2.0),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: color6, width: 2.0),
              borderRadius: BorderRadius.circular(20)),
          hintText: "Contraseña",
          hintStyle: const TextStyle(
              color: color2,
              fontSize: 15,
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

  Widget remember() {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 50),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              fillColor: MaterialStateProperty.all(color3),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              side: const BorderSide(color: color6, width: 2.0),
              checkColor: color5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                  loginForm.remember = _isChecked;
                });
              },
              activeColor: color6,
            ),
          ),
          const Text(
            'Recordar usuario',
            style: TextStyle(
                color: color2,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist'),
          ),
        ],
      ),
    );
  }
}
