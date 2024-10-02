part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoadedState extends HomeState {
  final UserResponse userResponse;

  const HomeLoadedState({required this.userResponse});

  @override
  List<Object> get props => [userResponse];
}

final class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
