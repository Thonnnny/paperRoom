// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

import 'package:freshbuyer/model/customerResponse.dart';
import 'package:freshbuyer/model/productCartResponse.dart';

class Cart {
  Cart({
    this.type,
    this.title,
    this.message,
    this.cart,
  });

  String? type;
  String? title;
  String? message;
  CartClass? cart;

  Cart copyWith({
    String? type,
    String? title,
    String? message,
    CartClass? cart,
  }) =>
      Cart(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        cart: cart ?? this.cart,
      );

  factory Cart.fromRawJson(String str) => Cart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        cart: json["cart"] == null ? null : CartClass.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "cart": cart?.toJson(),
      };
}

class CartClass {
  CartClass({
    this.id,
    this.customer,
    this.totalCurrency,
    this.actualStatus,
    this.paymentStatus,
    this.paymentDate,
    this.statusHistory,
    this.lastUpdate,
    this.createdAt,
    this.v,
    this.total,
    this.items,
  });

  String? id;
  Customer? customer;
  Currency? totalCurrency;
  String? actualStatus;
  String? paymentStatus;
  dynamic paymentDate;
  List<StatusHistory>? statusHistory;
  DateTime? lastUpdate;
  DateTime? createdAt;
  int? v;
  int? total;
  List<Item>? items;

  CartClass copyWith({
    String? id,
    Customer? customer,
    Currency? totalCurrency,
    String? actualStatus,
    String? paymentStatus,
    dynamic paymentDate,
    List<StatusHistory>? statusHistory,
    DateTime? lastUpdate,
    DateTime? createdAt,
    int? v,
    int? total,
    List<Item>? items,
  }) =>
      CartClass(
        id: id ?? this.id,
        customer: customer ?? this.customer,
        totalCurrency: totalCurrency ?? this.totalCurrency,
        actualStatus: actualStatus ?? this.actualStatus,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentDate: paymentDate ?? this.paymentDate,
        statusHistory: statusHistory ?? this.statusHistory,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
        total: total ?? this.total,
        items: items ?? this.items,
      );

  factory CartClass.fromRawJson(String str) =>
      CartClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartClass.fromJson(Map<String, dynamic> json) => CartClass(
        id: json["_id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        totalCurrency: json["totalCurrency"] == null
            ? null
            : Currency.fromJson(json["totalCurrency"]),
        actualStatus: json["actualStatus"],
        paymentStatus: json["paymentStatus"],
        paymentDate: json["paymentDate"],
        statusHistory: json["statusHistory"] == null
            ? []
            : List<StatusHistory>.from(
                json["statusHistory"]!.map((x) => StatusHistory.fromJson(x))),
        lastUpdate: json["lastUpdate"] == null
            ? null
            : DateTime.parse(json["lastUpdate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        total: json["total"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer": customer?.toJson(),
        "totalCurrency": totalCurrency?.toJson(),
        "actualStatus": actualStatus,
        "paymentStatus": paymentStatus,
        "paymentDate": paymentDate,
        "statusHistory": statusHistory == null
            ? []
            : List<dynamic>.from(statusHistory!.map((x) => x.toJson())),
        "lastUpdate": lastUpdate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "total": total,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Currency {
  Currency({
    this.id,
    this.code,
    this.name,
    this.symbol,
    this.createdAt,
    this.v,
  });

  String? id;
  String? code;
  String? name;
  String? symbol;
  DateTime? createdAt;
  int? v;

  Currency copyWith({
    String? id,
    String? code,
    String? name,
    String? symbol,
    DateTime? createdAt,
    int? v,
  }) =>
      Currency(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Currency.fromRawJson(String str) =>
      Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["_id"],
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "name": name,
        "symbol": symbol,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class StatusHistory {
  StatusHistory({
    this.status,
    this.date,
    this.stateChangedBy,
    this.id,
  });

  String? status;
  DateTime? date;
  String? stateChangedBy;
  String? id;

  StatusHistory copyWith({
    String? status,
    DateTime? date,
    String? stateChangedBy,
    String? id,
  }) =>
      StatusHistory(
        status: status ?? this.status,
        date: date ?? this.date,
        stateChangedBy: stateChangedBy ?? this.stateChangedBy,
        id: id ?? this.id,
      );

  factory StatusHistory.fromRawJson(String str) =>
      StatusHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatusHistory.fromJson(Map<String, dynamic> json) => StatusHistory(
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        stateChangedBy: json["stateChangedBy"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "date": date?.toIso8601String(),
        "stateChangedBy": stateChangedBy,
        "_id": id,
      };
}
