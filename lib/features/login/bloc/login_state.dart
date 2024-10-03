part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoadedState extends LoginState {
  final LoginResponse loginResponse;

  const LoginLoadedState({required this.loginResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [loginResponse];
}

final class LoginErrorState extends LoginState {
  final String message;

  const LoginErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
