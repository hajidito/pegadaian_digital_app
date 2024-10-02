part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

final class LoginClickEvent extends LoginEvent {
  final LoginRequest loginRequest;

  const LoginClickEvent({
    required this.loginRequest,
  });

  @override
  List<Object> get props => [loginRequest];
}
