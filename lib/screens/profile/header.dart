import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  dynamic baseName;
  dynamic basePhone;
  dynamic baseEmail;
  dynamic baseAddress;

  @override
  void initState() {
    super.initState();
    getUserName();
    // getUserPhone();
    // getUserEmail();
    // getUserAddress();
  }

  void getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nombre = prefs.getString('fullname');
    setState(() {
      baseName = nombre;
    });
  }

  // void getUserEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     final String? email = prefs.getString('email');
  //     baseEmail = email;
  //   });
  // }

  // void getUserPhone() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     final int? phone = prefs.getInt('phone');
  //     basePhone = phone;
  //   });
  // }

  // void getUserAddress() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     final String? colonia = prefs.getString('colonia');
  //     baseAddress = colonia;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Image.asset('assets/icons/profile/logo@2x.png', scale: 2),
              const SizedBox(width: 16),
              const Expanded(
                child: Text('Perfil de cliente',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                iconSize: 28,
                icon: Image.asset(
                    'assets/icons/tabbar/light/more_circle@2x.png',
                    scale: 2),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Stack(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/icons/if_2_avatar_2754578.png'),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  child: Image.asset('assets/icons/profile/edit_square@2x.png',
                      scale: 2),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text('Editar perfil',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: color6),
                    const SizedBox(width: 8),
                    Text(baseName ?? 'Nombre Apellido',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Icon(Icons.phone, color: color6),
              //       const SizedBox(width: 8),
              //       Text(basePhone.toString(),
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 18)),
              //       const SizedBox(height: 8),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Icon(Icons.email, color: color6),
              //       const SizedBox(width: 8),
              //       Text(baseEmail ?? '',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 18)),
              //       const SizedBox(height: 8),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Icon(Icons.location_on, color: color6),
              //       const SizedBox(width: 8),
              //       Text(baseAddress ?? '',
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 18)),
              //       const SizedBox(height: 8),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
