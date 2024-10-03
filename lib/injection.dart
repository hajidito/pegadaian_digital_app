import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/common/base_url.dart';
import 'package:pegadaian_digital/data/common/dio.dart';
import 'package:pegadaian_digital/data/pegadaian_preferences.dart';
import 'package:pegadaian_digital/data/pegadaian_repository.dart';
import 'package:pegadaian_digital/features/register/bloc/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/login/bloc/login_bloc.dart';

final getIt = GetIt.instance;
const instanceDefaultDio = "default";

void init() async {
  getIt.registerLazySingleton<Dio>(
    () => configureDio(baseUrl),
    instanceName: instanceDefaultDio,
  );

  getIt.registerLazySingleton(() => Logger());

  dataInjection();
  initBloc();
}

void dataInjection() {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerLazySingleton<PegadaianRepository>(
    () => PegadaianRepository(
      dio: getIt.get<Dio>(instanceName: instanceDefaultDio),
      log: getIt.get<Logger>(),
    ),
  );

  getIt.registerLazySingleton<PegadaianPreferences>(
    () => PegadaianPreferences(preferences: getIt.get<SharedPreferences>()),
  );
}

void initBloc() {
  getIt.registerLazySingleton<RegisterBloc>(
          () => RegisterBloc(
              pegadaianRepository: getIt.get<PegadaianRepository>(),
              log: getIt.get<Logger>()
          )
  );

  getIt.registerLazySingleton<LoginBloc>(
        () => LoginBloc(
            pegadaianRepository: getIt.get<PegadaianRepository>(),
            pref: getIt.get<PegadaianPreferences>(),
            log: getIt.get<Logger>()
    )
  );
}
