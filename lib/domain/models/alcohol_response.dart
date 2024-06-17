// To parse this JSON data, do
//
//     final alcoholResponse = alcoholResponseFromJson(jsonString);

import 'dart:convert';

AlcoholResponse alcoholResponseFromJson(String str) =>
    AlcoholResponse.fromJson(json.decode(str));

String alcoholResponseToJson(AlcoholResponse data) =>
    json.encode(data.toJson());

class AlcoholResponse {
  AlcoholResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory AlcoholResponse.fromJson(Map<String, dynamic> json) =>
      AlcoholResponse(
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
    this.drinkAlcohol,
    this.howMany,
    this.drinksInDay,
    this.cutDown,
    this.feltGuilty,
    this.morningDrink,
  });

  String? drinkAlcohol;
  String? howMany;
  String? drinksInDay;
  String? cutDown;
  String? feltGuilty;
  String? morningDrink;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        drinkAlcohol: json["drink_alcohol"],
        howMany: json["how_many"],
        drinksInDay: json["drinks_in_day"],
        cutDown: json["cut_down"],
        feltGuilty: json["felt_guilty"],
        morningDrink: json["morning_drink"],
      );

  Map<String, dynamic> toJson() => {
        "drink_alcohol": drinkAlcohol,
        "how_many": howMany,
        "drinks_in_day": drinksInDay,
        "cut_down": cutDown,
        "felt_guilty": feltGuilty,
        "morning_drink": morningDrink,
      };
}
