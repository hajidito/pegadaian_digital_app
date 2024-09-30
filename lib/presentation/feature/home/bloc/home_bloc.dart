import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/model/response/user_response.dart';
import 'package:pegadaian_digital/data/pegadaian_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PegadaianRepository pegadaianRepository;
  Logger log;

  HomeBloc({required this.pegadaianRepository, required this.log})
      : super(HomeInitial()) {
    on<GetUserEvent>(_getUser);
  }

  void _getUser(GetUserEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    final result = await pegadaianRepository.getUser();
    await result.fold(
      (failure) async {
        emit(HomeErrorState(
            message: failure.message ?? "Gagal mendapatkan data"));
      },
      (response) async {
        emit(HomeLoadedState(userResponse: response));
      },
    );
  }
}
