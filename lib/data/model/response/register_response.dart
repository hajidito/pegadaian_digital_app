class RegisterResponse {
  RegisterResponse({
    String? code,
    String? message,
    Data? data,
  }) {
    _code = code;
    _message = message;
    _data = data;
  }

  RegisterResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _code;
  String? _message;
  Data? _data;

  String? get code => _code;

  String? get message => _message;

  Data? get data => _data;
}

class Data {
  Data({
    String? token,
  }) {
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _token = json['token'];
  }

  String? _token;

  String? get token => _token;
}
