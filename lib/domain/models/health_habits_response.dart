// To parse this JSON data, do
//
//     final healthHabitsResponse = healthHabitsResponseFromJson(jsonString);

import 'dart:convert';

HealthHabitsResponse healthHabitsResponseFromJson(String str) => HealthHabitsResponse.fromJson(json.decode(str));

String healthHabitsResponseToJson(HealthHabitsResponse data) => json.encode(data.toJson());

class HealthHabitsResponse {
  HealthHabitsResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int ?returnCode;
  Data ?data;
  String ?returnMessage;

  factory HealthHabitsResponse.fromJson(Map<String, dynamic> json) => HealthHabitsResponse(
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
    this.habits,
  });

  String? habits;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    habits: json["habits"],
  );

  Map<String, dynamic> toJson() => {
    "habits": habits,
  };
}
