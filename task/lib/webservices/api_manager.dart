import 'package:dio/dio.dart';

class ApiManager {
  Dio dio() {
    Dio dio = Dio(
      new BaseOptions(
        baseUrl: 'https://backend-test-zypher.herokuapp.com',
      ),
    );

    return dio;
  }
}
