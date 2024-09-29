class RegisterRequest {
  RegisterRequest({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    _name = name;
    _email = email;
    _phone = phone;
    _password = password;
  }

  String? _name;
  String? _email;
  String? _phone;
  String? _password;

  String? get name => _name;

  String? get email => _email;

  String? get phone => _phone;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['password'] = _password;
    return map;
  }
}
