// To parse this JSON data, do
//
//     final medicationResponse = medicationResponseFromJson(jsonString);

import 'dart:convert';

MedicationResponse medicationResponseFromJson(String str) => MedicationResponse.fromJson(json.decode(str));

String medicationResponseToJson(MedicationResponse data) => json.encode(data.toJson());

class MedicationResponse {
  MedicationResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int ?returnCode;
  Data ?data;
  String ?returnMessage;

  factory MedicationResponse.fromJson(Map<String, dynamic> json) => MedicationResponse(
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
    this.medications,
  });

  List<Medication>? medications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    medications: List<Medication>.from(json["medications"].map((x) => Medication.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "medications": List<dynamic>.from(medications!.map((x) => x.toJson())),
  };
}

class Medication {
  Medication({
    this.name,
    this.reason,
  });

  String ?name;
  String ?reason;

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
    name: json["name"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "reason": reason,
  };
}
