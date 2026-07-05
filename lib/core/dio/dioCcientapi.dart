import 'package:dio/dio.dart';

class DioClientApi {
  final Dio dio;
  DioClientApi()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://www.themealdb.com/api/json/v1/1/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ),
      );
}
