// To parse this JSON data, do
//
//     final activeOrdersResponse = activeOrdersResponseFromJson(jsonString);

import 'dart:convert';

class ActiveOrdersResponse {
  ActiveOrdersResponse({
    this.type,
    this.title,
    this.message,
    this.activeOrders,
  });

  String? type;
  String? title;
  String? message;
  List<ActiveOrder>? activeOrders;

  ActiveOrdersResponse copyWith({
    String? type,
    String? title,
    String? message,
    List<ActiveOrder>? activeOrders,
  }) =>
      ActiveOrdersResponse(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        activeOrders: activeOrders ?? this.activeOrders,
      );

  factory ActiveOrdersResponse.fromRawJson(String str) =>
      ActiveOrdersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActiveOrdersResponse.fromJson(Map<String, dynamic> json) =>
      ActiveOrdersResponse(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        activeOrders: json["activeOrders"] == null
            ? []
            : List<ActiveOrder>.from(
                json["activeOrders"]!.map((x) => ActiveOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "activeOrders": activeOrders == null
            ? []
            : List<dynamic>.from(activeOrders!.map((x) => x.toJson())),
      };
}

class ActiveOrder {
  ActiveOrder({
    this.id,
    this.totalCurrency,
    this.actualStatus,
    this.paymentStatus,
    this.paymentDate,
    this.lastUpdate,
    this.createdAt,
    this.v,
    this.total,
    this.paymentMethod,
    this.itemsCount,
    this.client,
    this.observations,
    this.estimatedDeliveryDate,
  });

  String? id;
  TotalCurrency? totalCurrency;
  String? actualStatus;
  String? paymentStatus;
  DateTime? paymentDate;
  DateTime? lastUpdate;
  DateTime? createdAt;
  int? v;
  int? total;
  String? paymentMethod;
  int? itemsCount;
  Client? client;
  String? observations;
  DateTime? estimatedDeliveryDate;

  ActiveOrder copyWith({
    String? id,
    TotalCurrency? totalCurrency,
    String? actualStatus,
    String? paymentStatus,
    DateTime? paymentDate,
    DateTime? lastUpdate,
    DateTime? createdAt,
    int? v,
    int? total,
    String? paymentMethod,
    int? itemsCount,
    Client? client,
    String? observations,
    DateTime? estimatedDeliveryDate,
  }) =>
      ActiveOrder(
        id: id ?? this.id,
        totalCurrency: totalCurrency ?? this.totalCurrency,
        actualStatus: actualStatus ?? this.actualStatus,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentDate: paymentDate ?? this.paymentDate,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
        total: total ?? this.total,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        itemsCount: itemsCount ?? this.itemsCount,
        client: client ?? this.client,
        observations: observations ?? this.observations,
        estimatedDeliveryDate:
            estimatedDeliveryDate ?? this.estimatedDeliveryDate,
      );

  factory ActiveOrder.fromRawJson(String str) =>
      ActiveOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActiveOrder.fromJson(Map<String, dynamic> json) => ActiveOrder(
        id: json["_id"],
        totalCurrency: json["totalCurrency"] == null
            ? null
            : TotalCurrency.fromJson(json["totalCurrency"]),
        actualStatus: json["actualStatus"],
        paymentStatus: json["paymentStatus"],
        paymentDate: json["paymentDate"] == null
            ? null
            : DateTime.parse(json["paymentDate"]),
        lastUpdate: json["lastUpdate"] == null
            ? null
            : DateTime.parse(json["lastUpdate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        total: json["total"],
        paymentMethod: json["paymentMethod"],
        itemsCount: json["itemsCount"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        observations: json["observations"],
        estimatedDeliveryDate: json["estimatedDeliveryDate"] == null
            ? null
            : DateTime.parse(json["estimatedDeliveryDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalCurrency": totalCurrency?.toJson(),
        "actualStatus": actualStatus,
        "paymentStatus": paymentStatus,
        "paymentDate": paymentDate?.toIso8601String(),
        "lastUpdate": lastUpdate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "total": total,
        "paymentMethod": paymentMethod,
        "itemsCount": itemsCount,
        "client": client?.toJson(),
        "observations": observations,
        "estimatedDeliveryDate": estimatedDeliveryDate?.toIso8601String(),
      };
}

class Client {
  Client({
    this.fullname,
    this.email,
    this.phone,
    this.reference,
  });

  String? fullname;
  String? email;
  String? phone;
  String? reference;

  Client copyWith({
    String? fullname,
    String? email,
    String? phone,
    String? reference,
  }) =>
      Client(
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        reference: reference ?? this.reference,
      );

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "reference": reference,
      };
}

class TotalCurrency {
  TotalCurrency({
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

  TotalCurrency copyWith({
    String? id,
    String? code,
    String? name,
    String? symbol,
    DateTime? createdAt,
    int? v,
  }) =>
      TotalCurrency(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory TotalCurrency.fromRawJson(String str) =>
      TotalCurrency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalCurrency.fromJson(Map<String, dynamic> json) => TotalCurrency(
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
