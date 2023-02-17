// To parse this JSON data, do
//
//     final citiesResponse = citiesResponseFromJson(jsonString);

import 'dart:convert';

class CitiesResponse {
  CitiesResponse({
    this.type,
    this.title,
    this.message,
    this.cities,
  });

  String? type;
  String? title;
  String? message;
  List<City>? cities;

  CitiesResponse copyWith({
    String? type,
    String? title,
    String? message,
    List<City>? cities,
  }) =>
      CitiesResponse(
        type: type ?? this.type,
        title: title ?? this.title,
        message: message ?? this.message,
        cities: cities ?? this.cities,
      );

  factory CitiesResponse.fromRawJson(String str) =>
      CitiesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CitiesResponse.fromJson(Map<String, dynamic> json) => CitiesResponse(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "message": message,
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.name,
    this.id,
  });

  String? name;
  String? id;

  City copyWith({
    String? name,
    String? id,
  }) =>
      City(
        name: name ?? this.name,
        id: id ?? this.id,
      );

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
      };
}
