class RegisterRequest {
  RegisterRequest({
    this.name,
    this.email,
    this.phone,
    this.password,
  });

  String? name;
  String? email;
  String? phone;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone_number'] = phone;
    map['password'] = password;
    return map;
  }
}
