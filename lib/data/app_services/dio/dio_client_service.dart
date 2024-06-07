import 'package:dio/dio.dart';
import 'package:kanban_tracker/data/app_services/dio/dio_logging_interceptor.dart';

class DioClientService {
  static const connectTimeout = Duration(milliseconds: 10000);
  static const receiveTimeout = Duration(milliseconds: 10000);

  final Dio dio;

  DioClientService._({required this.dio});

  factory DioClientService.create() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      ),
    );

    dio.interceptors.add(DioLoggingInterceptor());

    return DioClientService._(dio: dio);
  }
}
