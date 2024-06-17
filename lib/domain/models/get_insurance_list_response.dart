// To parse this JSON data, do
//
//     final getInsuranceResponse = getInsuranceResponseFromJson(jsonString);

import 'dart:convert';

GetInsuranceResponse getInsuranceResponseFromJson(String str) =>
    GetInsuranceResponse.fromJson(json.decode(str));

String getInsuranceResponseToJson(GetInsuranceResponse data) =>
    json.encode(data.toJson());

class GetInsuranceResponse {
  GetInsuranceResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<Datum>? data;
  String? returnMessage;

  factory GetInsuranceResponse.fromJson(Map<String, dynamic> json) =>
      GetInsuranceResponse(
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
    this.image,
    this.provider,
    this.phone,
    this.groupNumber,
  });

  int? id;
  String? userId;
  String? image;
  String? provider;
  String? phone;
  String? groupNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        image: json["image"],
        provider: json["provider"],
        phone: json["phone"],
        groupNumber: json["group_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "image": image,
        "provider": provider,
        "phone": phone,
        "group_number": groupNumber,
      };
}
