// To parse this JSON data, do
//
//     final removeProduct = removeProductFromJson(jsonString);

import 'dart:convert';

import 'cartResponses.dart';

class RemoveProduct {
  RemoveProduct({
    this.type,
    this.title,
    this.message,
    this.cart,
  });

  String? type;
  String? title;
  String? message;
  Cart? cart;

  RemoveProduct copyWith({
    String? type,
    String? title,
    String? message,
    Cart? cart,
  }) =>
      RemoveProduct(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        cart: cart ?? this.cart,
      );

  factory RemoveProduct.fromRawJson(String str) =>
      RemoveProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RemoveProduct.fromJson(Map<String, dynamic> json) => RemoveProduct(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "cart": cart?.toJson(),
      };
}
