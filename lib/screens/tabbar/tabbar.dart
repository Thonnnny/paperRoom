import 'package:flutter/material.dart';
import 'package:freshbuyer/cart/cart_screen.dart';
import 'package:freshbuyer/constants.dart';
import 'package:freshbuyer/image_loader.dart';
import 'package:freshbuyer/screens/home/home.dart';
import 'package:freshbuyer/screens/profile/profile_screen.dart';
import 'package:freshbuyer/screens/test/test_screen.dart';
import 'package:freshbuyer/size_config.dart';

import '../DetailsOrders/details_orders.dart';

import '../wallet/wallet_screen.dart';

class TabbarItem {
  final String lightIcon;
  final String boldIcon;
  final String label;

  TabbarItem(
      {required this.lightIcon, required this.boldIcon, required this.label});

  BottomNavigationBarItem item(bool isbold) {
    return BottomNavigationBarItem(
      icon: ImageLoader.imageAsset(isbold ? boldIcon : lightIcon),
      label: label,
    );
  }

  BottomNavigationBarItem get light => item(false);
  BottomNavigationBarItem get bold => item(true);
}

class FRTabbarScreen extends StatefulWidget {
  const FRTabbarScreen({super.key});

  @override
  State<FRTabbarScreen> createState() => _FRTabbarScreenState();
}

class _FRTabbarScreenState extends State<FRTabbarScreen> {
  int _select = 0;

  final screens = [
    const HomeScreen(
      title: '首页0',
    ),
    const CartScreen(),
    const HistoryScreen(),
    const TestScreen(title: 'Orders'),
    const ProfileScreen(),
  ];

  static Image generateIcon(String path) {
    return Image.asset(
      '${ImageLoader.rootPaht}/tabbar/$path',
      width: 24,
      height: 24,
      color: color5,
    );
  }

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: generateIcon('light/Home@2x.png'),
      activeIcon: generateIcon('bold/Home@2x.png'),
      label: 'Inicio',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Bag@2x.png'),
      activeIcon: generateIcon('bold/Bag@2x.png'),
      label: 'Carrito',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Buy@2x.png'),
      activeIcon: generateIcon('bold/Buy@2x.png'),
      label: 'Ordenes',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Wallet@2x.png'),
      activeIcon: generateIcon('bold/Wallet@2x.png'),
      label: 'Billetera',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Profile@2x.png'),
      activeIcon: generateIcon('bold/Profile@2x.png'),
      label: 'Perfil',
    ),
  ];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color3,
      child: Scaffold(
        body: screens[_select],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: color3,
          iconSize: 24,
          type: BottomNavigationBarType.fixed,
          items: items,
          enableFeedback: true,
          onTap: ((value) => setState(() => _select = value)),
          currentIndex: _select,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          showUnselectedLabels: false,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          selectedItemColor: color5,
          unselectedItemColor: color5,
        ),
      ),
    );
  }
}
