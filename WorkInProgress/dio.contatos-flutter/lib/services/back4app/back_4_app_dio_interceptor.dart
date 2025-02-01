import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["X-Parse-Application-Id"] = dotenv.get("BACK4APP_API_ID");
    options.headers["X-Parse-REST-API-Key"] = dotenv.get("BACK4APP_API_KEY");
    options.headers["Content-Type"] = "application/json";
    super.onRequest(options, handler);
  }
}
