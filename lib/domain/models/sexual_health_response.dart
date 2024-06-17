// To parse this JSON data, do
//
//     final sexualHealthResponse = sexualHealthResponseFromJson(jsonString);

import 'dart:convert';

SexualHealthResponse sexualHealthResponseFromJson(String str) => SexualHealthResponse.fromJson(json.decode(str));

String sexualHealthResponseToJson(SexualHealthResponse data) => json.encode(data.toJson());

class SexualHealthResponse {
  SexualHealthResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int ?returnCode;
  Data ?data;
  String ?returnMessage;

  factory SexualHealthResponse.fromJson(Map<String, dynamic> json) => SexualHealthResponse(
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
    this.sexualHealth,
  });

  String ?sexualHealth;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sexualHealth: json["sexual_health"],
  );

  Map<String, dynamic> toJson() => {
    "sexual_health": sexualHealth,
  };
}
