// To parse this JSON data, do
//
//     final saveCardResponse = saveCardResponseFromJson(jsonString);

import 'dart:convert';

SaveCardResponse saveCardResponseFromJson(String str) =>
    SaveCardResponse.fromJson(json.decode(str));

String saveCardResponseToJson(SaveCardResponse data) =>
    json.encode(data.toJson());

class SaveCardResponse {
  SaveCardResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory SaveCardResponse.fromJson(Map<String, dynamic> json) =>
      SaveCardResponse(
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
    this.userId,
    this.cardNumber,
    this.cardName,
    this.cardDate,
    this.id,
  });

  int? userId;
  String? cardNumber;
  String? cardName;
  String? cardDate;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        cardNumber: json["card_number"],
        cardName: json["card_name"],
        cardDate: json["card_date"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "card_number": cardNumber,
        "card_name": cardName,
        "card_date": cardDate,
        "id": id,
      };
}
