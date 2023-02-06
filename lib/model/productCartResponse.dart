import 'dart:convert';

import 'package:freshbuyer/model/currencyResponse.dart';

class Item {
  Item({
    this.productName,
    this.productCode,
    this.productBilledPrice,
    this.productBilledPriceCurrency,
    this.reference,
    this.mainImage,
    this.quantity,
    this.id,
  });

  String? productName;
  String? productCode;
  int? productBilledPrice;
  Currency? productBilledPriceCurrency;
  String? reference;
  String? mainImage;
  int? quantity;
  String? id;

  Item copyWith({
    String? productName,
    String? productCode,
    int? productBilledPrice,
    Currency? productBilledPriceCurrency,
    String? reference,
    String? mainImage,
    int? quantity,
    String? id,
  }) =>
      Item(
        productName: productName ?? this.productName,
        productCode: productCode ?? this.productCode,
        productBilledPrice: productBilledPrice ?? this.productBilledPrice,
        productBilledPriceCurrency:
            productBilledPriceCurrency ?? this.productBilledPriceCurrency,
        reference: reference ?? this.reference,
        mainImage: mainImage ?? this.mainImage,
        quantity: quantity ?? this.quantity,
        id: id ?? this.id,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        productName: json["productName"],
        productCode: json["productCode"],
        productBilledPrice: json["productBilledPrice"],
        productBilledPriceCurrency: json["productBilledPriceCurrency"] == null
            ? null
            : Currency.fromJson(json["productBilledPriceCurrency"]),
        reference: json["reference"],
        mainImage: json["mainImage"],
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productCode": productCode,
        "productBilledPrice": productBilledPrice,
        "productBilledPriceCurrency": productBilledPriceCurrency?.toJson(),
        "reference": reference,
        "mainImage": mainImage,
        "quantity": quantity,
        "_id": id,
      };
}
