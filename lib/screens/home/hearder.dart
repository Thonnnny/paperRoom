import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

import '../../helpers/base_client.dart';
import '../../helpers/res_apis.dart';
import '../../providers/login_provider.dart';
import '../auth/login.dart';
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

  // void logOut() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? token = prefs.getString('sessiontoken');
  //   var data = {};
  //   var response = await BaseClient().post(RestApis.apiLogOut, data,
  //       {"Content-Type": "application/json", "sessiontoken": token});
  //   var rsp = jsonDecode(response);
  //   print(rsp);
  //   Navigator.pushNamed(context, LoginScreen.route());
  // }

  void logOut() {
    final loginProvider =
        Provider.of<LoginFormProvider>(context, listen: false);
    loginProvider.logOut();
    Navigator.pushNamed(context, LoginScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
              child: const CircleAvatar(
                backgroundImage: AssetImage('$kIconPath/me.png'),
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
                      baseName ?? ' Nombre',
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
    );
  }
}
