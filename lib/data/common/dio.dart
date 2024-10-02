import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/common/failure.dart';
import 'package:pegadaian_digital/data/common/failure_response.dart';
import 'package:pegadaian_digital/data/pegadaian_preferences.dart';
import 'package:pegadaian_digital/injection.dart';

Dio configureDio(String baseUrl) {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      baseUrl: baseUrl,
      validateStatus: (status) {
        if (status == null || status >= 500) {
          return false;
        } else {
          return true;
        }
      },
      maxRedirects: 0,
      followRedirects: false,
    ),
  );

  dio.interceptors.add(LogInterceptor());

  String? token = getIt.get<PegadaianPreferences>().getUserToken();
  dio.options.headers['Content-Type'] = 'application/json';
  if (token != null) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  return dio;
}

Failure dioException(DioException e) {
  try {
    Logger().e("dioException ${e.response?.data}", error: e);
    FailureResponse? failureResponse =
        FailureResponse.fromJson(e.response?.data);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ConnectionTimeoutFailure(e.message, failureResponse);

      //in connection error cause base e.error like httpEx and socket
      case DioExceptionType.connectionError:
        return ConnectionErrorFailure(e.message, failureResponse);

      case DioExceptionType.badCertificate:
        return BadCertificateFailure(e.message, failureResponse);

      case DioExceptionType.badResponse:
        return BadResponseFailure(e.message, failureResponse);

      case DioExceptionType.cancel:
        return CancelFailure(e.message, failureResponse);

      default:
        return UnknownFailure(e.message, failureResponse);
    }
  } catch (e) {
    Logger().e("catch dioException ${e.toString()}", error: e);
    return UnknownFailure(e.toString(), null);
  }
}
