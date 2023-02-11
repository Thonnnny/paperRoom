// To parse this JSON data, do
//
//     final logOutResponse = logOutResponseFromJson(jsonString);

import 'dart:convert';

class LogOutResponse {
  LogOutResponse({
    this.type,
    this.title,
    this.message,
  });

  String? type;
  String? title;
  String? message;

  LogOutResponse copyWith({
    String? type,
    String? title,
    String? message,
  }) =>
      LogOutResponse(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
      );

  factory LogOutResponse.fromRawJson(String str) =>
      LogOutResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogOutResponse.fromJson(Map<String, dynamic> json) => LogOutResponse(
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
