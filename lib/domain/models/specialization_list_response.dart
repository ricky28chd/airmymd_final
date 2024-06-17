// To parse this JSON data, do
//
//     final specializationListResponse = specializationListResponseFromJson(jsonString);

import 'dart:convert';

SpecializationListResponse specializationListResponseFromJson(String str) =>
    SpecializationListResponse.fromJson(json.decode(str));

String specializationListResponseToJson(SpecializationListResponse data) =>
    json.encode(data.toJson());

class SpecializationListResponse {
  SpecializationListResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<Datum>? data;
  String? returnMessage;

  factory SpecializationListResponse.fromJson(Map<String, dynamic> json) =>
      SpecializationListResponse(
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
    this.name,
    this.image,
    this.icon,
    this.count,
  });

  int? id;
  String? name;
  String? image;
  String? icon;
  int? count;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        icon: json["icon"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "icon": icon,
        "count": count,
      };
}
