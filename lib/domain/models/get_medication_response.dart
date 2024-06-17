// To parse this JSON data, do
//
//     final getMedicationResponse = getMedicationResponseFromJson(jsonString);

import 'dart:convert';

GetMedicationResponse getMedicationResponseFromJson(String str) =>
    GetMedicationResponse.fromJson(json.decode(str));

String getMedicationResponseToJson(GetMedicationResponse data) =>
    json.encode(data.toJson());

class GetMedicationResponse {
  GetMedicationResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<Datum>? data;
  String? returnMessage;

  factory GetMedicationResponse.fromJson(Map<String, dynamic> json) =>
      GetMedicationResponse(
        returnCode: json["returnCode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        returnMessage: json["returnMessage"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "returnMessage": returnMessage,
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.name,
    this.reason,
  });

  int? id;
  String? userId;
  String? name;
  String? reason;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        name: json["name"] as String? ?? '',
        reason: json["reason"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "reason": reason,
      };
}
