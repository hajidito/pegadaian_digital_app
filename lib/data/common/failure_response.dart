class FailureResponse {
  FailureResponse({
    String? code,
    String? message,
  }) {
    _code = code;
    _message = message;
  }

  FailureResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
  }

  String? _code;
  String? _message;

  String? get code => _code;

  String? get message => _message;
}
