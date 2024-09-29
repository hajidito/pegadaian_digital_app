import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pegadaian_digital/data/common/dio.dart';
import 'package:pegadaian_digital/data/common/failure.dart';
import 'package:pegadaian_digital/data/model/request/register_request.dart';
import 'package:pegadaian_digital/data/model/response/register_response.dart';

class PegadaianRepository {
  final Dio dio;

  PegadaianRepository({required this.dio});

  Future<Either<Failure, RegisterResponse>> register(
      RegisterRequest registerRequest) async {
    try {
      // final response =
      //     await dio.post("/auth/register", data: registerRequest.toJson());
      //
      // return Right(RegisterResponse.fromJson(response.data));
      return Right(RegisterResponse(
        code: "200",
        message: "success",
        data: Data(token: "tokentokentoken"),
      ));
    } on DioException catch (e) {
      return Left(dioException(e));
    } catch (e) {
      Logger().e("PegadaianRepository $e");
      return Left(UnknownFailure(null, null));
    }
  }
}
