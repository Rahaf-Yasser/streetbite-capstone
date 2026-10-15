import 'package:dio/dio.dart';

import 'package:flutter_app/core/constants/api_constants.dart';
// used one Dio client for all API requests
class DioClient {
  DioClient._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.mealDbBaseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        responseType: ResponseType.json,
        headers: const {'Accept': 'application/json'},
      ),
    );
  }

  static final DioClient _instance = DioClient._();

  factory DioClient.instance() => _instance;

  late final Dio _dio;

  Dio get dio => _dio;
}
