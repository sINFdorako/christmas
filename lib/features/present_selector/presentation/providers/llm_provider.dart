import 'package:christmas/features/present_selector/data/repositories/llm_repository_impl.dart';
import 'package:christmas/features/present_selector/domain/usecases/get_llm_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final llmResponseProvider =
    FutureProvider.family<String, String>((ref, prompt) async {
  final llmRepository = LLMRepositoryImpl();
  final result = await GetLLMResponse(llmRepository).execute(prompt);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (response) => response,
  );
});
