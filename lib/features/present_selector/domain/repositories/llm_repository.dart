import 'package:christmas/core/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class LLMRepository {
  Future<Either<Failure, String>> getLLMResponse(String prompt);
}
