// To parse this JSON data, do
//
//     final allergyResponse = allergyResponseFromJson(jsonString);

import 'dart:convert';

AllergyResponse allergyResponseFromJson(String str) =>
    AllergyResponse.fromJson(json.decode(str));

String allergyResponseToJson(AllergyResponse data) =>
    json.encode(data.toJson());

class AllergyResponse {
  AllergyResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory AllergyResponse.fromJson(Map<String, dynamic> json) =>
      AllergyResponse(
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
    this.allergies,
  });

  List<Allergy>? allergies;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        allergies: List<Allergy>.from(
            json["allergies"].map((x) => Allergy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "allergies": List<dynamic>.from(allergies!.map((x) => x.toJson())),
      };
}

class Allergy {
  Allergy({
    this.type,
    this.name,
    this.comment,
  });

  String? type;
  String? name;
  String? comment;

  factory Allergy.fromJson(Map<String, dynamic> json) => Allergy(
        type: json["type"],
        name: json["name"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "comment": comment,
      };
}
