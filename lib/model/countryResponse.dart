// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

class CountryResponse {
  CountryResponse({
    this.type,
    this.title,
    this.message,
    this.countries,
  });

  String? type;
  String? title;
  String? message;
  List<Country>? countries;

  CountryResponse copyWith({
    String? type,
    String? title,
    String? message,
    List<Country>? countries,
  }) =>
      CountryResponse(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        countries: countries ?? this.countries,
      );

  factory CountryResponse.fromRawJson(String str) =>
      CountryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      CountryResponse(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    this.name,
    this.id,
  });

  String? name;
  String? id;

  Country copyWith({
    String? name,
    String? id,
  }) =>
      Country(
        name: name ?? this.name,
        id: id ?? this.id,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
      };
}
