// To parse this JSON data, do
//
//     final drugResponse = drugResponseFromJson(jsonString);

import 'dart:convert';

DrugResponse drugResponseFromJson(String str) =>
    DrugResponse.fromJson(json.decode(str));

String drugResponseToJson(DrugResponse data) => json.encode(data.toJson());

class DrugResponse {
  DrugResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory DrugResponse.fromJson(Map<String, dynamic> json) => DrugResponse(
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
    this.streetDrug,
    this.needleDrug,
  });

  String? streetDrug;
  String? needleDrug;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        streetDrug: json["street_drug"],
        needleDrug: json["needle_drug"],
      );

  Map<String, dynamic> toJson() => {
        "street_drug": streetDrug,
        "needle_drug": needleDrug,
      };
}
