import 'dart:convert';

class Customer {
  Customer({
    this.fullname,
    this.reference,
  });

  String? fullname;
  String? reference;

  Customer copyWith({
    String? fullname,
    String? reference,
  }) =>
      Customer(
        fullname: fullname ?? this.fullname,
        reference: reference ?? this.reference,
      );

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        fullname: json["fullname"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "reference": reference,
      };
}
