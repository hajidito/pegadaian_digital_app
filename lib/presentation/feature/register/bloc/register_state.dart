part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
}

final class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterLoadingState extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterLoadedState extends RegisterState {
  final RegisterResponse registerResponse;

  const RegisterLoadedState({required this.registerResponse});

  @override
  List<Object> get props => [registerResponse];
}

final class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
