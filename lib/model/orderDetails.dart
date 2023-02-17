// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

class OrderDetails {
  OrderDetails({
    this.type,
    this.title,
    this.message,
    this.orderDetails,
  });

  String? type;
  String? title;
  String? message;
  OrderDetailsClass? orderDetails;

  OrderDetails copyWith({
    String? type,
    String? title,
    String? message,
    OrderDetailsClass? orderDetails,
  }) =>
      OrderDetails(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        orderDetails: orderDetails ?? this.orderDetails,
      );

  factory OrderDetails.fromRawJson(String str) =>
      OrderDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        orderDetails: json["orderDetails"] == null
            ? null
            : OrderDetailsClass.fromJson(json["orderDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "orderDetails": orderDetails?.toJson(),
      };
}

class OrderDetailsClass {
  OrderDetailsClass({
    this.id,
    this.customer,
    this.products,
    this.totalCurrency,
    this.actualStatus,
    this.paymentStatus,
    this.paymentDate,
    this.statusHistory,
    this.lastUpdate,
    this.createdAt,
    this.v,
    this.total,
    this.billingAddress,
    this.paymentMethod,
    this.observations,
  });

  String? id;
  Customer? customer;
  List<Product>? products;
  TotalCurrency? totalCurrency;
  String? actualStatus;
  String? paymentStatus;
  DateTime? paymentDate;
  List<StatusHistory>? statusHistory;
  DateTime? lastUpdate;
  DateTime? createdAt;
  int? v;
  int? total;
  BillingAddress? billingAddress;
  String? paymentMethod;
  String? observations;

  OrderDetailsClass copyWith({
    String? id,
    Customer? customer,
    List<Product>? products,
    TotalCurrency? totalCurrency,
    String? actualStatus,
    String? paymentStatus,
    DateTime? paymentDate,
    List<StatusHistory>? statusHistory,
    DateTime? lastUpdate,
    DateTime? createdAt,
    int? v,
    int? total,
    BillingAddress? billingAddress,
    String? paymentMethod,
    String? observations,
  }) =>
      OrderDetailsClass(
        id: id ?? this.id,
        customer: customer ?? this.customer,
        products: products ?? this.products,
        totalCurrency: totalCurrency ?? this.totalCurrency,
        actualStatus: actualStatus ?? this.actualStatus,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        paymentDate: paymentDate ?? this.paymentDate,
        statusHistory: statusHistory ?? this.statusHistory,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
        total: total ?? this.total,
        billingAddress: billingAddress ?? this.billingAddress,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        observations: observations ?? this.observations,
      );

  factory OrderDetailsClass.fromRawJson(String str) =>
      OrderDetailsClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailsClass.fromJson(Map<String, dynamic> json) =>
      OrderDetailsClass(
        id: json["_id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        totalCurrency: json["totalCurrency"] == null
            ? null
            : TotalCurrency.fromJson(json["totalCurrency"]),
        actualStatus: json["actualStatus"],
        paymentStatus: json["paymentStatus"],
        paymentDate: json["paymentDate"] == null
            ? null
            : DateTime.parse(json["paymentDate"]),
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
        billingAddress: json["billingAddress"] == null
            ? null
            : BillingAddress.fromJson(json["billingAddress"]),
        paymentMethod: json["paymentMethod"],
        observations: json["observations"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customer": customer?.toJson(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "totalCurrency": totalCurrency?.toJson(),
        "actualStatus": actualStatus,
        "paymentStatus": paymentStatus,
        "paymentDate": paymentDate?.toIso8601String(),
        "statusHistory": statusHistory == null
            ? []
            : List<dynamic>.from(statusHistory!.map((x) => x.toJson())),
        "lastUpdate": lastUpdate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "total": total,
        "billingAddress": billingAddress?.toJson(),
        "paymentMethod": paymentMethod,
        "observations": observations,
      };
}

class BillingAddress {
  BillingAddress({
    this.reference,
    this.country,
    this.subdivision,
    this.city,
  });

  String? reference;
  Country? country;
  TotalCurrency? subdivision;
  City? city;

  BillingAddress copyWith({
    String? reference,
    Country? country,
    TotalCurrency? subdivision,
    City? city,
  }) =>
      BillingAddress(
        reference: reference ?? this.reference,
        country: country ?? this.country,
        subdivision: subdivision ?? this.subdivision,
        city: city ?? this.city,
      );

  factory BillingAddress.fromRawJson(String str) =>
      BillingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        reference: json["reference"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        subdivision: json["subdivision"] == null
            ? null
            : TotalCurrency.fromJson(json["subdivision"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "country": country?.toJson(),
        "subdivision": subdivision?.toJson(),
        "city": city?.toJson(),
      };
}

class City {
  City({
    this.id,
    this.name,
    this.abreviation,
    this.subdivision,
    this.createdAt,
    this.v,
  });

  String? id;
  String? name;
  String? abreviation;
  String? subdivision;
  DateTime? createdAt;
  int? v;

  City copyWith({
    String? id,
    String? name,
    String? abreviation,
    String? subdivision,
    DateTime? createdAt,
    int? v,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        abreviation: abreviation ?? this.abreviation,
        subdivision: subdivision ?? this.subdivision,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        name: json["name"],
        abreviation: json["abreviation"],
        subdivision: json["subdivision"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "abreviation": abreviation,
        "subdivision": subdivision,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class Country {
  Country({
    this.id,
    this.name,
    this.alpha2,
    this.alpha3,
    this.dialCode,
    this.currency,
    this.createdAt,
    this.v,
  });

  String? id;
  String? name;
  String? alpha2;
  String? alpha3;
  String? dialCode;
  String? currency;
  DateTime? createdAt;
  int? v;

  Country copyWith({
    String? id,
    String? name,
    String? alpha2,
    String? alpha3,
    String? dialCode,
    String? currency,
    DateTime? createdAt,
    int? v,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        alpha2: alpha2 ?? this.alpha2,
        alpha3: alpha3 ?? this.alpha3,
        dialCode: dialCode ?? this.dialCode,
        currency: currency ?? this.currency,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["_id"],
        name: json["name"],
        alpha2: json["alpha2"],
        alpha3: json["alpha3"],
        dialCode: json["dialCode"],
        currency: json["currency"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "alpha2": alpha2,
        "alpha3": alpha3,
        "dialCode": dialCode,
        "currency": currency,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class TotalCurrency {
  TotalCurrency({
    this.id,
    this.name,
    this.code,
    this.country,
    this.createdAt,
    this.v,
    this.symbol,
  });

  String? id;
  String? name;
  String? code;
  String? country;
  DateTime? createdAt;
  int? v;
  String? symbol;

  TotalCurrency copyWith({
    String? id,
    String? name,
    String? code,
    String? country,
    DateTime? createdAt,
    int? v,
    String? symbol,
  }) =>
      TotalCurrency(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        country: country ?? this.country,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
        symbol: symbol ?? this.symbol,
      );

  factory TotalCurrency.fromRawJson(String str) =>
      TotalCurrency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalCurrency.fromJson(Map<String, dynamic> json) => TotalCurrency(
        id: json["_id"],
        name: json["name"],
        code: json["code"],
        country: json["country"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "code": code,
        "country": country,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "symbol": symbol,
      };
}

class Customer {
  Customer({
    this.fullname,
    this.email,
    this.phone,
    this.reference,
  });

  String? fullname;
  String? email;
  String? phone;
  String? reference;

  Customer copyWith({
    String? fullname,
    String? email,
    String? phone,
    String? reference,
  }) =>
      Customer(
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        reference: reference ?? this.reference,
      );

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
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

class Product {
  Product({
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
  TotalCurrency? productBilledPriceCurrency;
  String? reference;
  String? mainImage;
  int? quantity;
  String? id;

  Product copyWith({
    String? productName,
    String? productCode,
    int? productBilledPrice,
    TotalCurrency? productBilledPriceCurrency,
    String? reference,
    String? mainImage,
    int? quantity,
    String? id,
  }) =>
      Product(
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

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productName: json["productName"],
        productCode: json["productCode"],
        productBilledPrice: json["productBilledPrice"],
        productBilledPriceCurrency: json["productBilledPriceCurrency"] == null
            ? null
            : TotalCurrency.fromJson(json["productBilledPriceCurrency"]),
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
