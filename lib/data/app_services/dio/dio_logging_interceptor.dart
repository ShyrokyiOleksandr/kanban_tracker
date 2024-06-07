import 'package:dio/dio.dart';

class DioLoggingInterceptor extends LogInterceptor {
  DioLoggingInterceptor() : super(requestBody: true, responseBody: true);
}
