import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/model/response/history_response.dart';
import 'package:pegadaian_digital/data/pegadaian_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  PegadaianRepository pegadaianRepository;
  Logger log;

  HistoryBloc({
    required this.pegadaianRepository,
    required this.log,
  }) : super(HistoryInitial()) {
    on<GetHistoryEvent>(_getHistory);
  }

  void _getHistory(GetHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());

    final result = await pegadaianRepository.getHistory();
    await result.fold(
      (failure) async {
        emit(HistoryErrorState(
            message: failure.message ?? "Gagal mendapatkan data"));
      },
      (response) async {
        emit(HistoryLoadedState(historyResponse: response));
      },
    );
  }
}
