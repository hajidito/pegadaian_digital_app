import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/model/request/login_request.dart';
import 'package:pegadaian_digital/data/model/response/login_response.dart';
import 'package:pegadaian_digital/data/pegadaian_preferences.dart';
import 'package:pegadaian_digital/data/pegadaian_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  PegadaianRepository pegadaianRepository;
  PegadaianPreferences pref;
  Logger log;

  LoginBloc({
    required this.pegadaianRepository,
    required this.pref,
    required this.log,
  }) : super(LoginInitial()) {
    on<LoginClickEvent>(_login);
  }

  void _login(LoginClickEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    final result = await pegadaianRepository.login(event.loginRequest);
    await result.fold(
      (failure) async {
        emit(LoginErrorState(message: failure.message ?? "Gagal Login"));
      },
      (response) async {
        String token = response.data?.token ?? "";
        String userId = response.data?.user?.userId ?? "";

        if (token.isNotEmpty && userId.isNotEmpty) {
          pref.setUserToken(token);
          pref.setUserId(userId);
          pref.setUserLoggedIn(true);

          emit(LoginLoadedState(loginResponse: response));
        } else {
          emit(LoginErrorState(message: "Gagal Login"));
        }
      },
    );
  }
}
