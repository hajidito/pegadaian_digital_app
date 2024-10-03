class UserResponse {
  UserResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final Data? data;

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
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
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? userId;
  final String? name;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final int? createdAt;
  final int? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json["user_id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      phoneNumber: json["phone_number"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "password": password,
        "phone_number": phoneNumber,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
