import 'package:pegadaian_digital/data/common/failure_response.dart';

abstract class Failure {
  final String? message;
  final FailureResponse? failureResponse;

  const Failure(this.message, this.failureResponse);
}

class ServerFailure extends Failure {
  ServerFailure(super.message, super.failureResponse);
}

class ConnectionTimeoutFailure extends Failure {
  ConnectionTimeoutFailure(super.message, super.failureResponse);
}

class ConnectionErrorFailure extends Failure {
  ConnectionErrorFailure(super.message, super.failureResponse);
}

class BadCertificateFailure extends Failure {
  BadCertificateFailure(super.message, super.failureResponse);
}

class BadResponseFailure extends Failure {
  BadResponseFailure(super.message, super.failureResponse);
}

class CancelFailure extends Failure {
  CancelFailure(super.message, super.failureResponse);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message, super.failureResponse);
}
