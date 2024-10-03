class AbsencesResponse {
  AbsencesResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final Data? data;

  factory AbsencesResponse.fromJson(Map<String, dynamic> json) {
    return AbsencesResponse(
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
    required this.absenceId,
    required this.updatedAt,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.isActive,
    required this.createdAt,
  });

  final String? absenceId;
  final dynamic updatedAt;
  final String? userId;
  final String? latitude;
  final String? longitude;
  final bool? isActive;
  final int? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      absenceId: json["absence_id"],
      updatedAt: json["updated_at"],
      userId: json["user_id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      isActive: json["is_active"],
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "absence_id": absenceId,
        "updated_at": updatedAt,
        "user_id": userId,
        "latitude": latitude,
        "longitude": longitude,
        "is_active": isActive,
        "created_at": createdAt,
      };
}
