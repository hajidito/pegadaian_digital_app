class FailureResponse {
  FailureResponse({
    String? code,
    bool? status,
    String? message,
  }) {
    _code = code;
    _status = status;
    _message = message;
  }

  FailureResponse.fromJson(dynamic json) {
    _code = json['code'];
    _status = json['status'];
    _message = json['message'];
  }

  String? _code;
  bool? _status;
  String? _message;

  String? get code => _code;

  bool? get status => _status;

  String? get message => _message;
}
