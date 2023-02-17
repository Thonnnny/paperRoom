// To parse this JSON data, do
//
//     final confirmOrderResponse = confirmOrderResponseFromJson(jsonString);

import 'dart:convert';

class ConfirmOrderResponse {
  ConfirmOrderResponse({
    this.type,
    this.title,
    this.message,
  });

  String? type;
  String? title;
  String? message;

  ConfirmOrderResponse copyWith({
    String? type,
    String? title,
    String? message,
  }) =>
      ConfirmOrderResponse(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
      );

  factory ConfirmOrderResponse.fromRawJson(String str) =>
      ConfirmOrderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfirmOrderResponse.fromJson(Map<String, dynamic> json) =>
      ConfirmOrderResponse(
        type: json["type"],
        title: json["title"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
      };
}
