import 'package:contatos_flutter/services/back4app/back_4_app_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppDio {
  late Dio _dio;

  Back4AppDio() {
    _dio = Dio();
    _dio.options.baseUrl = dotenv.get("BACK4APP_BASE_URL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }

  Dio get dio => _dio;
}
