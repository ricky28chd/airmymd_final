// To parse this JSON data, do
//
//     final setLocationResponse = setLocationResponseFromJson(jsonString);

import 'dart:convert';

SetLocationResponse setLocationResponseFromJson(String str) =>
    SetLocationResponse.fromJson(json.decode(str));

String setLocationResponseToJson(SetLocationResponse data) =>
    json.encode(data.toJson());

class SetLocationResponse {
  SetLocationResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory SetLocationResponse.fromJson(Map<String, dynamic> json) =>
      SetLocationResponse(
        returnCode: json["returnCode"],
        data: Data.fromJson(json["data"]),
        returnMessage: json["returnMessage"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": data!.toJson(),
        "returnMessage": returnMessage,
      };
}

class Data {
  Data({
    this.location,
    this.longitude,
    this.latitude,
  });

  String? location;
  String? longitude;
  String? latitude;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
      };
}
