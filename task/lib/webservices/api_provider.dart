import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task/model/measurement.dart';

import 'package:task/webservices/api_manager.dart';

class ApiProvider {
  final ApiManager apiManager = ApiManager();

  ///API to login
  Future<ResponseFromApi> getMeasurement(String imageURL) async {
    try {
      Response response = await apiManager.dio().post(
          '/uploadImageforMeasurement',
          queryParameters: {"imageURL": imageURL});
      print(response.data);
      return responseFromApiFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      print('ERROR=> ${e.response?.data}');
      return e.response?.data;
    }
  }
}
