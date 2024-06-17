// To parse this JSON data, do
//
//     final deleteInsuranceCard = deleteInsuranceCardFromJson(jsonString);

import 'dart:convert';

DeleteInsuranceCard deleteInsuranceCardFromJson(String str) =>
    DeleteInsuranceCard.fromJson(json.decode(str));

String deleteInsuranceCardToJson(DeleteInsuranceCard data) =>
    json.encode(data.toJson());

class DeleteInsuranceCard {
  DeleteInsuranceCard({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<dynamic>? data;
  String? returnMessage;

  factory DeleteInsuranceCard.fromJson(Map<String, dynamic> json) =>
      DeleteInsuranceCard(
        returnCode: json["returnCode"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        returnMessage: json["returnMessage"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "returnMessage": returnMessage,
      };
}
