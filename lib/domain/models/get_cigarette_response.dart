// To parse this JSON data, do
//
//     final getCigaretteResponse = getCigaretteResponseFromJson(jsonString);

import 'dart:convert';

GetCigaretteResponse getCigaretteResponseFromJson(String str) =>
    GetCigaretteResponse.fromJson(json.decode(str));

String getCigaretteResponseToJson(GetCigaretteResponse data) =>
    json.encode(data.toJson());

class GetCigaretteResponse {
  GetCigaretteResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory GetCigaretteResponse.fromJson(Map<String, dynamic> json) =>
      GetCigaretteResponse(
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
    this.cigarette,
    this.tobacco,
  });

  Cigarette? cigarette;
  String? tobacco;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cigarette: Cigarette.fromJson(json["cigarette"]),
        tobacco: json["tobacco"],
      );

  Map<String, dynamic> toJson() => {
        "cigarette": cigarette!.toJson(),
        "tobacco": tobacco,
      };
}

class Cigarette {
  Cigarette({
    this.selection,
    this.datePacks,
    this.ageYears,
    this.packs,
    this.years,
  });

  String? selection;
  String? datePacks;
  String? ageYears;
  String? packs;
  String? years;

  factory Cigarette.fromJson(Map<String, dynamic> json) => Cigarette(
        selection: json["selection"] as String? ?? '',
        datePacks: json["date/packs"] as String? ?? '',
        ageYears: json["age/years"] as String? ?? '',
        packs: json["packs"] as String? ?? '',
        years: json["years"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "selection": selection,
        "date/packs": datePacks,
        "age/years": ageYears,
        "packs": packs,
        "years": years,
      };
}
