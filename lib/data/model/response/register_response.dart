class RegisterResponse {
  RegisterResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final Data? data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
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
    required this.phoneNumber,
    required this.password,
    required this.createdAt,
  });

  final String? userId;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final int? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json["user_id"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      password: json["password"],
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "created_at": createdAt,
      };
}
