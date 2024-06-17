// To parse this JSON data, do
//
//     final generalHealthResponse = generalHealthResponseFromJson(jsonString);

import 'dart:convert';

GeneralHealthResponse generalHealthResponseFromJson(String str) =>
    GeneralHealthResponse.fromJson(json.decode(str));

String generalHealthResponseToJson(GeneralHealthResponse data) =>
    json.encode(data.toJson());

class GeneralHealthResponse {
  GeneralHealthResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory GeneralHealthResponse.fromJson(Map<String, dynamic> json) =>
      GeneralHealthResponse(
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
    this.general,
    this.skin,
    this.eyes,
  });

  String? general;
  String? skin;
  String? eyes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        general: json["general"],
        skin: json["skin"],
        eyes: json["eyes"],
      );

  Map<String, dynamic> toJson() => {
        "general": general,
        "skin": skin,
        "eyes": eyes,
      };
}
