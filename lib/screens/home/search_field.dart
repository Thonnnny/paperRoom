import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: color5,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Center(
        child: TextField(
          cursorColor: color6,
          onChanged: (value) => log(value),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Buscar productos",
            prefixIcon: Icon(Icons.search, color: color6),
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color2,
            ),
            labelStyle: TextStyle(
              fontSize: 14,
              color: color2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
