import 'package:christmas/core/network/api_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  late Dio _dio;

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: 9000),
      receiveTimeout: const Duration(milliseconds: 7000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ApiConstants.apiKey}',
      },
    ));

    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Dio get dio => _dio;
}
