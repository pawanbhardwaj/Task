import 'package:task/model/measurement.dart';

import 'package:task/webservices/api_provider.dart';

class Repository {
  final ApiProvider apiProvider = ApiProvider();

  Future<ResponseFromApi> getMeasurement(String imageURL) =>
      apiProvider.getMeasurement(imageURL);
}
