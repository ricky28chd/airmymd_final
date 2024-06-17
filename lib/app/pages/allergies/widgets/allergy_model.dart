// To parse this JSON data, do
//
//     final allergyModel = allergyModelFromJson(jsonString);

import 'dart:convert';

AllergyModel allergyModelFromJson(String str) => AllergyModel.fromJson(json.decode(str));

String allergyModelToJson(AllergyModel data) => json.encode(data.toJson());

class AllergyModel {
  AllergyModel({
    this.allergies,
  });

  List<Allergy> ?allergies;

  factory AllergyModel.fromJson(Map<String, dynamic> json) => AllergyModel(
    allergies: List<Allergy>.from(json["allergies"].map((x) => Allergy.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "allergies": List<dynamic>.from(allergies!.map((x) => x.toJson())),
  };
}

class Allergy {
  Allergy({
    required this.type,
    required this.name,
    required this.comment,
  });

  String type;
  String name;
  String comment;

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
