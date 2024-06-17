// To parse this JSON data, do
//
//     final medicalHistoryResponse = medicalHistoryResponseFromJson(jsonString);

import 'dart:convert';

MedicalHistoryResponse medicalHistoryResponseFromJson(String str) =>
    MedicalHistoryResponse.fromJson(json.decode(str));

String medicalHistoryResponseToJson(MedicalHistoryResponse data) =>
    json.encode(data.toJson());

class MedicalHistoryResponse {
  MedicalHistoryResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory MedicalHistoryResponse.fromJson(Map<String, dynamic> json) =>
      MedicalHistoryResponse(
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
    this.medicalHistory,
  });

  String? medicalHistory;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        medicalHistory: json["medical_history"],
      );

  Map<String, dynamic> toJson() => {
        "medical_history": medicalHistory,
      };
}
