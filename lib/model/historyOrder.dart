// To parse this JSON data, do
//
//     final historyOrders = historyOrdersFromJson(jsonString);

import 'dart:convert';

class HistoryOrders {
  HistoryOrders({
    this.type,
    this.title,
    this.message,
    this.historyOrders,
  });

  String? type;
  String? title;
  String? message;
  List<HistoryOrder>? historyOrders;

  HistoryOrders copyWith({
    String? type,
    String? title,
    String? message,
    List<HistoryOrder>? historyOrders,
  }) =>
      HistoryOrders(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        historyOrders: historyOrders ?? this.historyOrders,
      );

  factory HistoryOrders.fromRawJson(String str) =>
      HistoryOrders.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryOrders.fromJson(Map<String, dynamic> json) => HistoryOrders(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        historyOrders: json["historyOrders"] == null
            ? []
            : List<HistoryOrder>.from(
                json["historyOrders"]!.map((x) => HistoryOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "historyOrders": historyOrders == null
            ? []
            : List<dynamic>.from(historyOrders!.map((x) => x.toJson())),
      };
}

class HistoryOrder {
  HistoryOrder({
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
    this.observations,
    this.itemsCount,
    this.client,
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
  String? observations;
  int? itemsCount;
  Client? client;

  HistoryOrder copyWith({
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
    String? observations,
    int? itemsCount,
    Client? client,
  }) =>
      HistoryOrder(
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
        observations: observations ?? this.observations,
        itemsCount: itemsCount ?? this.itemsCount,
        client: client ?? this.client,
      );

  factory HistoryOrder.fromRawJson(String str) =>
      HistoryOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryOrder.fromJson(Map<String, dynamic> json) => HistoryOrder(
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
        observations: json["observations"],
        itemsCount: json["itemsCount"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
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
        "observations": observations,
        "itemsCount": itemsCount,
        "client": client?.toJson(),
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
