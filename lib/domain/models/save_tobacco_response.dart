// To parse this JSON data, do
//
//     final saveTobaccoCard = saveTobaccoCardFromJson(jsonString);

import 'dart:convert';

SaveTobaccoCard saveTobaccoCardFromJson(String str) =>
    SaveTobaccoCard.fromJson(json.decode(str));

String saveTobaccoCardToJson(SaveTobaccoCard data) =>
    json.encode(data.toJson());

class SaveTobaccoCard {
  SaveTobaccoCard({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory SaveTobaccoCard.fromJson(Map<String, dynamic> json) =>
      SaveTobaccoCard(
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
    this.date,
    this.age,
    this.packs,
    this.years,
  });

  String? selection;
  String? date;
  String? age;
  String? packs;
  String? years;

  factory Cigarette.fromJson(Map<String, dynamic> json) => Cigarette(
        selection: json["selection"],
        date: json["date"],
        age: json["age"],
        packs: json["packs"],
        years: json["years"],
      );

  Map<String, dynamic> toJson() => {
        "selection": selection,
        "date": date,
        "age": age,
        "packs": packs,
        "years": years,
      };
}
