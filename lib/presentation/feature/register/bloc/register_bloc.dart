import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/model/request/register_request.dart';
import 'package:pegadaian_digital/data/model/response/register_response.dart';
import 'package:pegadaian_digital/data/pegadaian_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  PegadaianRepository pegadaianRepository;
  Logger log;

  RegisterBloc({required this.pegadaianRepository, required this.log})
      : super(RegisterInitial()) {
    on<RegisterClickEvent>(_register);
  }

  void _register(RegisterClickEvent event, Emitter<RegisterState> emit) async {
    final result = await pegadaianRepository.register(event.registerRequest);
    await result.fold(
      (failure) async {
        emit(RegisterErrorState(message: failure.message ?? "Gagal Mendaftar"));
      },
      (response) async {
        emit(
          RegisterLoadedState(registerResponse: response),
        );
      },
    );
  }
}
