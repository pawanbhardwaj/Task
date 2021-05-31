import 'package:flutter/material.dart';
import 'package:task/main.dart';

import 'package:task/model/measurement.dart';

class MeasurementScreen extends StatefulWidget {
  final ResponseFromApi? responseFromApi;
  MeasurementScreen({this.responseFromApi});

  @override
  _MeasurementScreenState createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  ScrollController _scrollController = ScrollController();
  List<String> bodyPart = [
    'neck',
    'height',
    'weight',
    'belly',
    'chest',
    'wrist',
    'armLength',
    'thigh',
    'shoulder',
    'hips',
    'ankle'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 21, top: kToolbarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Home Page')));
              },
              child: Text(
                "Take Measurement Again",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListView.builder(
                controller: _scrollController,
                itemCount: bodyPart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(bodyPart[index].toUpperCase()),
                        Spacer(),
                        Text(
                          widget.responseFromApi!.d
                              .height!, // since belly, thigh ,wrist etc all are having same values in the response!!!! If different we can write separately too.
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ));
                })
          ],
        ),
      ),
    ));
  }
}
