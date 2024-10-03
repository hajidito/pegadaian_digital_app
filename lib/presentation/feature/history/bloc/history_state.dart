part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();
}

final class HistoryInitial extends HistoryState {
  @override
  List<Object> get props => [];
}

final class HistoryLoadingState extends HistoryState {
  @override
  List<Object> get props => [];
}

final class HistoryLoadedState extends HistoryState {
  final HistoryResponse historyResponse;

  const HistoryLoadedState({required this.historyResponse});

  @override
  List<Object> get props => [historyResponse];
}

final class HistoryErrorState extends HistoryState {
  final String message;

  const HistoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
