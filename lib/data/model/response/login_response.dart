class LoginResponse {
  LoginResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  final int? code;
  final String? message;
  final Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
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
    required this.user,
    required this.token,
  });

  final User? user;
  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  final String? userId;
  final String? name;
  final String? email;
  final String? phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["user_id"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
      };
}
