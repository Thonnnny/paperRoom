class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.v,
  });

  String id;
  String name;
  String description;
  DateTime createdAt;
  int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
