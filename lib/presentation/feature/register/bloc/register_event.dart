part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

final class RegisterClickEvent extends RegisterEvent {
  final RegisterRequest registerRequest;

  const RegisterClickEvent({
    required this.registerRequest,
  });

  @override
  List<Object> get props => [registerRequest];
}
