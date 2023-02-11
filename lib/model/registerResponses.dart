// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    this.type,
    this.title,
    this.message,
  });

  String? type;
  String? title;
  String? message;

  RegisterResponse copyWith({
    String? type,
    String? title,
    String? message,
  }) =>
      RegisterResponse(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
      );

  factory RegisterResponse.fromRawJson(String str) =>
      RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
