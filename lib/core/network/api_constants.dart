class ApiConstants {
  static const baseUrl = 'https://api.openai.com';

  /// This endpoint is appended to the [baseUrl] for making requests related
  /// to text completions.
  static const completionsEndpoint = '/v1/completions';

  /// This model is specified in the request body to determine which version
  /// of the GPT model is used for text generation.
  static const openAiModel = 'text-davinci-003';

  /// The maximum number of tokens to be generated in the response.
  static const maxTokens = 500;

  /// A higher temperature value results in more random completions, while
  /// a lower value produces more deterministic and predictable completions.
  static const temperature = 0.7;
  static const apiKey = String.fromEnvironment('API_KEY');
}
