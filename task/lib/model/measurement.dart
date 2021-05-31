// To parse this JSON data, do
//
//     final responseFromApi = responseFromApiFromJson(jsonString);

import 'dart:convert';

ResponseFromApi responseFromApiFromJson(String str) =>
    ResponseFromApi.fromJson(json.decode(str));

String responseFromApiToJson(ResponseFromApi data) =>
    json.encode(data.toJson());

class ResponseFromApi {
  ResponseFromApi({
    required this.status,
    required this.d,
  });

  int status;
  D d;

  factory ResponseFromApi.fromJson(Map<String, dynamic> json) =>
      ResponseFromApi(
        status: json["status"],
        d: D.fromJson(json["d"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "d": d.toJson(),
      };
}

class D {
  D({
    this.measurementId,
    this.neck,
    this.height,
    this.weight,
    this.belly,
    this.chest,
    this.wrist,
    this.armLength,
    this.thigh,
    this.shoulder,
    this.hips,
    this.ankle,
  });

  String? measurementId;
  String? neck;
  String? height;
  String? weight;
  String? belly;
  String? chest;
  String? wrist;
  String? armLength;
  String? thigh;
  String? shoulder;
  String? hips;
  String? ankle;

  factory D.fromJson(Map<String, dynamic> json) => D(
        measurementId: json["measurementId"],
        neck: json["neck"],
        height: json["height"],
        weight: json["weight"],
        belly: json["belly"],
        chest: json["chest"],
        wrist: json["wrist"],
        armLength: json["armLength"],
        thigh: json["thigh"],
        shoulder: json["shoulder"],
        hips: json["hips"],
        ankle: json["ankle"],
      );

  Map<String, dynamic> toJson() => {
        "measurementId": measurementId,
        "neck": neck,
        "height": height,
        "weight": weight,
        "belly": belly,
        "chest": chest,
        "wrist": wrist,
        "armLength": armLength,
        "thigh": thigh,
        "shoulder": shoulder,
        "hips": hips,
        "ankle": ankle,
      };
}
