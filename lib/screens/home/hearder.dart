import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freshbuyer/components/splash_screen.dart';
import 'package:freshbuyer/screens/auth/welcome.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

import '../../helpers/base_client.dart';
import '../../helpers/res_apis.dart';
import '../../providers/login_provider.dart';
import '../profile/profile_screen.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  dynamic baseName;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final String? nombre = prefs.getString('fullname');
      baseName = nombre;
    });
  }

  void logOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('sessiontoken');
      if (token == null || token.isEmpty || token == 'null' || token == false) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const SafeArea(child: WelcomeScreen())),
            (Route<dynamic> route) => false);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Cerrando sesión',
          text: 'Sesión cerrada',
          confirmBtnColor: Colors.green,
          confirmBtnText: 'Continuar',
        );
      } else {
        final loginProvider =
            // ignore: use_build_context_synchronously
            Provider.of<LoginFormProvider>(context, listen: false);
        var response = await BaseClient().get(RestApis.getLogOut,
            {"Content-Type": "application/json", "sessiontoken": token});
        var rsp = jsonDecode(response);
        print('this is a try to logout $rsp');
        print(rsp);
        if (rsp['type'] == "success") {
          print('logout successful');

          loginProvider.logOut();

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const SafeArea(child: WelcomeScreen())),
              (Route<dynamic> route) => false);
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Cerrando sesión',
            text: '${rsp['message']}',
            confirmBtnColor: Colors.green,
            confirmBtnText: 'Continuar',
          );
        } else {
          print('this is a try  but a failed to logout');
          setState(() {
            loginProvider.logOut();
          });
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: '${rsp['title']}',
            text: '${rsp['message']}, no eres usuario registrado.',
            confirmBtnColor: Colors.red,
            confirmBtnText: 'Continuar',
            onConfirmBtnTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const SafeArea(child: WelcomeScreen())),
                  (Route<dynamic> route) => false);
            },
          );
        }
      }
    } catch (e) {
      print('this is a try to logout $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: color5,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                onTap: () =>
                    Navigator.pushNamed(context, ProfileScreen.route()),
                child: const CircleAvatar(
                  backgroundColor: color6,
                  backgroundImage:
                      AssetImage('$kIconPath/if_2_avatar_2754578.png'),
                  radius: 24,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bienvenido 👋',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        baseName ?? 'Cliente',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),

              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.login_rounded,
                    color: Colors.white, size: 40.0),
                onPressed: () {
                  logOut();
                },
              ),
              // const SizedBox(width: 16),
              // IconButton(
              //   iconSize: 28,
              //   icon: Image.asset('$kIconPath/light/heart@2x.png', color: blueDark),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
