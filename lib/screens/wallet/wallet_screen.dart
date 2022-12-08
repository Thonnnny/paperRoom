import 'package:flutter/material.dart';
import 'package:freshbuyer/screens/profile/profile_screen.dart';

import '../../constants.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  static String route() => '/wallet';

  @override
  // ignore: library_private_types_in_public_api
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _paypalCard(context),
          _activityText(),
          _activityList(),
        ],
      ),
    );
  }
}

Container _paypalCard(context) {
  return Container(
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
    decoration: BoxDecoration(
      color: Colors.white,
      border:
          Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      boxShadow: [
        const BoxShadow(
            color: color4, offset: Offset(0, 3), blurRadius: 6, spreadRadius: 1)
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset('assets/images/Paypal-logo.png', height: 30),
                const SizedBox(width: 20),
                const Text(
                  'BALANCE',
                  style: TextStyle(
                      color: color5, fontFamily: "worksans", fontSize: 12),
                ),
              ],
            ),
            const Icon(Icons.info_outline, size: 18)
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('assets/images/chip_thumb.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text(
                      '\$',
                      style: TextStyle(fontFamily: "vistolsans", fontSize: 25),
                    ),
                    const SizedBox(width: 13),
                    Text(
                      '452,20',
                      style: const TextStyle(
                          fontFamily: "sfprotext", fontSize: 45),
                    ),
                    const SizedBox(width: 13),
                  ],
                ),
                const Text(
                  'Available',
                  style: TextStyle(
                      fontFamily: "worksans", color: color5, fontSize: 17),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            SizedBox(
              height: 25,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  "MR.RAGNAR LOTHBROK",
                  style: TextStyle(
                      fontFamily: "worksans", color: color5, fontSize: 12),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return const ProfileScreen();
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            ),
            const Spacer()
          ],
        ),
      ],
    ),
  );
}

Container _activityText() {
  return Container(
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: color4))),
    margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 5),
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Activity',
          style: TextStyle(
              fontFamily: "worksans",
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Text(
              'VIEW ALL',
              style: TextStyle(
                  fontFamily: "worksans",
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: color6),
            ),
            Icon(Icons.chevron_right, color: color5),
          ],
        ),
      ],
    ),
  );
}

ListView _activityList() {
  return ListView(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    padding: const EdgeInsets.all(15),
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: Image.asset('assets/images/Nike.png'),
          title: const Text(
            'Nike Medieval',
            style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: const Text(
            'Jan 21, 2019',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: const Text(
            '-249,99 USD',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: SizedBox(
            width: 42,
            child: Image.asset('assets/images/if_9_avatar_2754584.png'),
          ),
          title: const Text(
            'Lagertha Lothbrok',
            style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: const Text(
            'Jan 18, 2019',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: const Text(
            '+102,00 USD',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: _tileDecoration(),
        child: ListTile(
          leading: ClipOval(
            child: Container(
              color: color3,
              child: Image.asset(
                "assets/images/icon_shop.png",
                fit: BoxFit.scaleDown,
                width: 35.0,
                height: 35.0,
              ),
            ),
          ),
          title: const Text(
            'Spotify Finance Limited',
            style: TextStyle(
                fontFamily: "worksans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          subtitle: const Text(
            'Jan 11, 2019',
            style:
                TextStyle(fontFamily: "worksans", fontWeight: FontWeight.w300),
          ),
          trailing: const Text(
            '-9,99 USD',
            style: TextStyle(fontFamily: "worksans"),
          ),
        ),
      ),
    ],
  );
}

BoxDecoration _tileDecoration() {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white, width: 0, style: BorderStyle.solid),
    borderRadius: const BorderRadius.all(
      Radius.circular(5.0),
    ),
    // ignore: prefer_const_literals_to_create_immutables
    boxShadow: [
      const BoxShadow(
          color: color4, offset: Offset(0, 0), blurRadius: 3, spreadRadius: 1)
    ],
  );
}
