// To parse this JSON data, do
//
//     final productsInOffer = productsInOfferFromJson(jsonString);

import 'dart:convert';

import 'package:freshbuyer/model/oldCategory.dart';
import 'package:freshbuyer/model/priceAcurrecy.dart';

class ProductsInOffer {
  ProductsInOffer({
    this.type,
    this.title,
    this.message,
    this.offers,
  });

  String? type;
  String? title;
  String? message;
  List<Offer>? offers;

  ProductsInOffer copyWith({
    String? type,
    String? title,
    String? message,
    List<Offer>? offers,
  }) =>
      ProductsInOffer(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        offers: offers ?? this.offers,
      );

  factory ProductsInOffer.fromRawJson(String str) =>
      ProductsInOffer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsInOffer.fromJson(Map<String, dynamic> json) =>
      ProductsInOffer(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        offers: json["offers"] == null
            ? []
            : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "offers": offers == null
            ? []
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
      };
}

class Offer {
  Offer({
    this.id,
    this.name,
    this.description,
    this.price,
    this.priceCurrency,
    this.inOffer,
    this.mainImage,
    this.images,
    this.category,
    this.visible,
    this.sku,
    this.stock,
    this.tags,
    this.isVariant,
    this.variantsCode,
    this.createdAt,
    this.v,
    this.offerPrice,
    this.offerValidFrom,
    this.offerValidThrough,
  });

  String? id;
  String? name;
  String? description;
  int? price;
  PriceCurrency? priceCurrency;
  bool? inOffer;
  String? mainImage;
  List<dynamic>? images;
  Category? category;
  bool? visible;
  String? sku;
  int? stock;
  List<dynamic>? tags;
  bool? isVariant;
  String? variantsCode;
  DateTime? createdAt;
  int? v;
  int? offerPrice;
  DateTime? offerValidFrom;
  DateTime? offerValidThrough;

  Offer copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    PriceCurrency? priceCurrency,
    bool? inOffer,
    String? mainImage,
    List<dynamic>? images,
    Category? category,
    bool? visible,
    String? sku,
    int? stock,
    List<dynamic>? tags,
    bool? isVariant,
    String? variantsCode,
    DateTime? createdAt,
    int? v,
    int? offerPrice,
    DateTime? offerValidFrom,
    DateTime? offerValidThrough,
  }) =>
      Offer(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        priceCurrency: priceCurrency ?? this.priceCurrency,
        inOffer: inOffer ?? this.inOffer,
        mainImage: mainImage ?? this.mainImage,
        images: images ?? this.images,
        category: category ?? this.category,
        visible: visible ?? this.visible,
        sku: sku ?? this.sku,
        stock: stock ?? this.stock,
        tags: tags ?? this.tags,
        isVariant: isVariant ?? this.isVariant,
        variantsCode: variantsCode ?? this.variantsCode,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
        offerPrice: offerPrice ?? this.offerPrice,
        offerValidFrom: offerValidFrom ?? this.offerValidFrom,
        offerValidThrough: offerValidThrough ?? this.offerValidThrough,
      );

  factory Offer.fromRawJson(String str) => Offer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        priceCurrency: json["priceCurrency"] == null
            ? null
            : PriceCurrency.fromJson(json["priceCurrency"]),
        inOffer: json["inOffer"],
        mainImage: json["mainImage"],
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        visible: json["visible"],
        sku: json["sku"],
        stock: json["stock"],
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        isVariant: json["isVariant"],
        variantsCode: json["variantsCode"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        offerPrice: json["offerPrice"],
        offerValidFrom: json["offerValidFrom"] == null
            ? null
            : DateTime.parse(json["offerValidFrom"]),
        offerValidThrough: json["offerValidThrough"] == null
            ? null
            : DateTime.parse(json["offerValidThrough"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "priceCurrency": priceCurrency?.toJson(),
        "inOffer": inOffer,
        "mainImage": mainImage,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "category": category?.toJson(),
        "visible": visible,
        "sku": sku,
        "stock": stock,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "isVariant": isVariant,
        "variantsCode": variantsCode,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "offerPrice": offerPrice,
        "offerValidFrom": offerValidFrom?.toIso8601String(),
        "offerValidThrough": offerValidThrough?.toIso8601String(),
      };
}
