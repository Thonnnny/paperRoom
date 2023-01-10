import 'package:flutter/material.dart';

import '../constants.dart';

abstract class FRAppBar {
  static PreferredSizeWidget defaultAppBar(
    BuildContext context, {
    String title = '',
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: color5,
      elevation: 10,
      leading: IconButton(
        onPressed: (() => Navigator.pop(context)),
        icon: Image.asset(
          'assets/icons/back@2x.png',
          scale: 2.0,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Color(0xFF212121),
        ),
      ),
      centerTitle: false,
      actions: actions,
    );
  }
}
