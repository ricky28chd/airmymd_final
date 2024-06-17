// To parse this JSON data, do
//
//     final getAllergiesResponse = getAllergiesResponseFromJson(jsonString);

import 'dart:convert';

GetAllergiesResponse getAllergiesResponseFromJson(String str) =>
    GetAllergiesResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String getAllergiesResponseToJson(GetAllergiesResponse data) =>
    json.encode(data.toJson());

class GetAllergiesResponse {
  GetAllergiesResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<Datum>? data;
  String? returnMessage;

  factory GetAllergiesResponse.fromJson(Map<String, dynamic> json) =>
      GetAllergiesResponse(
        returnCode: json["returnCode"] as int? ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        returnMessage: json["returnMessage"] as String? ?? '',
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
    this.comment,
    this.type,
  });

  int? id;
  String? userId;
  String? name;
  String? comment;
  String? type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        name: json["name"] as String? ?? '',
        comment: json["comment"] as String? ?? '',
        type: json["type"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "comment": comment,
        "type": type,
      };
}
