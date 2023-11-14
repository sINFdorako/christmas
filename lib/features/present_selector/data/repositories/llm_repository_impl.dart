import 'package:christmas/core/network/api_constants.dart';
import 'package:christmas/core/network/dio_config.dart';
import 'package:christmas/core/network/failure.dart';
import 'package:christmas/features/present_selector/domain/repositories/llm_repository.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';

class LLMRepositoryImpl implements LLMRepository {
  @override
  Future<Either<Failure, String>> getLLMResponse(String prompt) async {
    try {
      final Map<String, dynamic> data = {
        'model': ApiConstants.openAiModel,
        'prompt': prompt,
        'max_tokens': ApiConstants.maxTokens,
        'temperature': ApiConstants.temperature,
      };

      final response = await DioClient()
          .dio
          .post(ApiConstants.completionsEndpoint, data: jsonEncode(data));

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return Right(jsonResponse['choices'][0]['text']);
      } else {
        return Left(Failure(
            message: 'Failed to fetch data from API',
            code: response.statusCode));
      }
    } catch (e) {
      return Left(Failure(message: 'An error occurred: ${e.toString()}'));
    }
  }
}
