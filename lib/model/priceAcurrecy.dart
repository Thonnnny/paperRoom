class PriceCurrency {
  PriceCurrency({
    required this.id,
    required this.code,
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.v,
  });

  String id;
  String code;
  String name;
  String symbol;
  DateTime createdAt;
  int v;

  factory PriceCurrency.fromJson(Map<String, dynamic> json) => PriceCurrency(
        id: json["_id"],
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "name": name,
        "symbol": symbol,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
