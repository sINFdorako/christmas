import 'package:christmas/core/network/failure.dart';
import 'package:christmas/features/present_selector/domain/repositories/llm_repository.dart';
import 'package:dartz/dartz.dart';

class GetLLMResponse {
  final LLMRepository llmRepository;

  GetLLMResponse(this.llmRepository);

  Future<Either<Failure, String>> execute(String prompt) async {
    return await llmRepository.getLLMResponse(prompt);
  }
}
