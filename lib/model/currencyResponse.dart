class Currency {
  Currency({
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

  Currency copyWith({
    String? id,
    String? code,
    String? name,
    String? symbol,
    DateTime? createdAt,
    int? v,
  }) =>
      Currency(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        createdAt: createdAt ?? this.createdAt,
        v: v ?? this.v,
      );

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
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
