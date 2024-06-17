// To parse this JSON data, do
//
//     final surgeriesResponse = surgeriesResponseFromJson(jsonString);

import 'dart:convert';

SurgeriesResponse surgeriesResponseFromJson(String str) =>
    SurgeriesResponse.fromJson(json.decode(str));

String surgeriesResponseToJson(SurgeriesResponse data) =>
    json.encode(data.toJson());

class SurgeriesResponse {
  SurgeriesResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory SurgeriesResponse.fromJson(Map<String, dynamic> json) =>
      SurgeriesResponse(
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
    this.surgeries,
    this.year,
    this.age,
  });

  String? surgeries;
  String? year;
  String? age;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surgeries: json["surgeries"],
        year: json["year"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "surgeries": surgeries,
        "year": year,
        "age": age,
      };
}
