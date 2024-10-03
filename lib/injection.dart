import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/common/base_url.dart';
import 'package:pegadaian_digital/data/common/dio.dart';
import 'package:pegadaian_digital/data/pegadaian_preferences.dart';
import 'package:pegadaian_digital/data/pegadaian_repository.dart';
import 'package:pegadaian_digital/presentation/feature/attendance/bloc/attendance_bloc.dart';
import 'package:pegadaian_digital/presentation/feature/history/bloc/history_bloc.dart';
import 'package:pegadaian_digital/presentation/feature/home/bloc/home_bloc.dart';
import 'package:pegadaian_digital/presentation/feature/login/bloc/login_bloc.dart';
import 'package:pegadaian_digital/presentation/feature/register/bloc/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'utils/firebase_utils.dart';
import 'utils/notification_plugin.dart';

final getIt = GetIt.instance;
const instanceDefaultDio = "default";

void init() async {
  getIt.registerLazySingleton<Dio>(
    () => configureDio(baseUrl),
    instanceName: instanceDefaultDio,
  );

  getIt.registerLazySingleton(() => Logger());
  await initFirebaseSetting();
  dataInjection();
  initBloc();
}

void dataInjection() {
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  getIt.registerLazySingleton<PegadaianRepository>(
    () => PegadaianRepository(
      dio: getIt.get<Dio>(instanceName: instanceDefaultDio),
      pref: getIt.get<PegadaianPreferences>(),
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
      log: getIt.get<Logger>(),
    ),
  );

  getIt.registerLazySingleton<LoginBloc>(
    () => LoginBloc(
      pegadaianRepository: getIt.get<PegadaianRepository>(),
      pref: getIt.get<PegadaianPreferences>(),
      log: getIt.get<Logger>(),
    ),
  );

  getIt.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      pegadaianRepository: getIt.get<PegadaianRepository>(),
      log: getIt.get<Logger>(),
    ),
  );

  getIt.registerLazySingleton<AttendanceBloc>(
    () => AttendanceBloc(
      pegadaianRepository: getIt.get<PegadaianRepository>(),
      log: getIt.get<Logger>(),
    ),
  );

  getIt.registerLazySingleton<HistoryBloc>(
    () => HistoryBloc(
      pegadaianRepository: getIt.get<PegadaianRepository>(),
      log: getIt.get<Logger>(),
    ),
  );
}

Future<void> initFirebaseSetting() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  notificationPlugin.init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
    }

    if (message.notification != null) {
      if (kDebugMode) {
        print('Message also contained a notification: ${message.notification}');
      }
      FirebaseUtils.firebaseHandler(message);
    }
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseUtils.firebaseHandler(message);
}
