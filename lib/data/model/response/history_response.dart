class HistoryResponse {
  HistoryResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final Data? data;

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.items,
    required this.totalItems,
  });

  final List<Item> items;
  final int? totalItems;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      totalItems: json["total_items"],
    );
  }

  Map<String, dynamic> toJson() => {
        "items": items.map((x) => x?.toJson()).toList(),
        "total_items": totalItems,
      };
}

class Item {
  Item({
    required this.absenceId,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? absenceId;
  final String? userId;
  final String? latitude;
  final String? longitude;
  final bool? isActive;
  final int? createdAt;
  final int? updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      absenceId: json["absence_id"],
      userId: json["user_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isActive: json["is_active"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "absence_id": absenceId,
        "user_id": userId,
        "latitude": latitude,
        "longitude": longitude,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
