import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/common/dio.dart';
import 'package:pegadaian_digital/data/common/failure.dart';
import 'package:pegadaian_digital/data/model/request/register_request.dart';
import 'package:pegadaian_digital/data/model/response/register_response.dart';

class PegadaianRepository {
  final Dio dio;
  final Logger log;

  PegadaianRepository({required this.dio, required this.log});

  Future<Either<Failure, RegisterResponse>> register(
      RegisterRequest registerRequest) async {
    try {
      final response =
          await dio.post("/auth/register", data: registerRequest.toJson());

      return Right(RegisterResponse.fromJson(response.data));
    } on DioException catch (e) {
      Failure failure = dioException(e);
      log.e("PegadaianRepository: ${failure.message}");
      return Left(failure);
    } catch (e) {
      log.e("PegadaianRepository $e");
      return Left(UnknownFailure(null, null));
    }
  }
}
