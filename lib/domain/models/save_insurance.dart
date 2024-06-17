// To parse this JSON data, do
//
//     final addInsuranceResponse = addInsuranceResponseFromJson(jsonString);

import 'dart:convert';

AddInsuranceResponse addInsuranceResponseFromJson(String str) =>
    AddInsuranceResponse.fromJson(json.decode(str)as Map<String,dynamic>);

String addInsuranceResponseToJson(AddInsuranceResponse data) =>
    json.encode(data.toJson());

class AddInsuranceResponse {
  AddInsuranceResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory AddInsuranceResponse.fromJson(Map<String, dynamic> json) =>
      AddInsuranceResponse(
        returnCode: json["returnCode"],
        data: Data.fromJson(json["data"]as Map<String,dynamic>),
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
    this.id,
    this.image,
    this.provider,
    this.phone,
    this.groupNumber,
  });

  int? id;
  String? image;
  String? provider;
  String? phone;
  String? groupNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        image: json["image"],
        provider: json["provider"],
        phone: json["phone"],
        groupNumber: json["group_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "provider": provider,
        "phone": phone,
        "group_number": groupNumber,
      };
}
