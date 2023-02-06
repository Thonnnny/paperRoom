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
