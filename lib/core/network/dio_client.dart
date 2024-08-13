import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  final Dio dio;

  DioClient._internal()
      : dio = Dio(
          BaseOptions(
            baseUrl: "https://pokeapi.co/api/v2/pokemon",
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

  factory DioClient() {
    return _instance;
  }
}
