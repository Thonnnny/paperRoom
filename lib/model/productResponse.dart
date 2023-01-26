// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:freshbuyer/model/productElement.dart';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    required this.type,
    required this.title,
    required this.message,
    required this.products,
  });

  String type;
  String title;
  String message;
  List<Product> products;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };

  copyWith({
    String? type,
    String? title,
    String? message,
    List<Product>? products,
  }) {
    return ProductResponse(
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      products: products ?? this.products,
    );
  }
}
