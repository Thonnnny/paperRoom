import 'dart:convert';

import 'package:freshbuyer/model/category.dart';
import 'package:freshbuyer/model/priceAcurrecy.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.priceCurrency,
    required this.inOffer,
    required this.mainImage,
    required this.images,
    required this.category,
    required this.visible,
    required this.sku,
    required this.stock,
    required this.tags,
    required this.isVariant,
    required this.variantsCode,
    required this.createdAt,
    required this.v,
  });

  String id;
  String name;
  String description;
  int price;
  PriceCurrency priceCurrency;
  bool inOffer;
  String mainImage;
  List<dynamic> images;
  Category category;
  bool visible;
  String sku;
  int stock;
  List<dynamic> tags;
  bool isVariant;
  String variantsCode;
  DateTime createdAt;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        priceCurrency: PriceCurrency.fromJson(json["priceCurrency"]),
        inOffer: json["inOffer"],
        mainImage: json["mainImage"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        category: Category.fromJson(json["category"]),
        visible: json["visible"],
        sku: json["sku"],
        stock: json["stock"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        isVariant: json["isVariant"],
        variantsCode: json["variantsCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "priceCurrency": priceCurrency.toJson(),
        "inOffer": inOffer,
        "mainImage": mainImage,
        "images": List<dynamic>.from(images.map((x) => x)),
        "category": category.toJson(),
        "visible": visible,
        "sku": sku,
        "stock": stock,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "isVariant": isVariant,
        "variantsCode": variantsCode,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
