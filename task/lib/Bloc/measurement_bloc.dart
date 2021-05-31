import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task/measurement_screen.dart';
import 'package:task/model/measurement.dart';

import 'package:task/webservices/repository.dart';

class MeasurementBloc {
  final Repository repository = Repository();

  var serviceFetcher = PublishSubject<ResponseFromApi>();

  Stream<ResponseFromApi> get responseData => serviceFetcher.stream;

  getResponse(BuildContext context, String imageURL) async {
    var response = await repository.getMeasurement(imageURL);
    serviceFetcher.sink.add(response);
    if (response.status == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MeasurementScreen(
                    responseFromApi: response,
                  )));
    } else {
      Fluttertoast.showToast(msg: response.status.toString());
    }
  }

  void dispose() async {
    await serviceFetcher.drain();
    serviceFetcher.close();
  }
}

final measurementBloc = MeasurementBloc();
