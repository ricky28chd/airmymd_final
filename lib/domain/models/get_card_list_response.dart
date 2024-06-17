// To parse this JSON data, do
//
//     final getCardListResponse = getCardListResponseFromJson(jsonString);

import 'dart:convert';

GetCardListResponse getCardListResponseFromJson(String str) =>
    GetCardListResponse.fromJson(json.decode(str));

String getCardListResponseToJson(GetCardListResponse data) =>
    json.encode(data.toJson());

class GetCardListResponse {
  GetCardListResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<Datum>? data;
  String? returnMessage;

  factory GetCardListResponse.fromJson(Map<String, dynamic> json) =>
      GetCardListResponse(
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
    this.cardToken,
    this.cardNumber,
    this.cardName,
    this.cardDate,
    this.cardPrimary,
    this.isDeleted,
    this.createdAt,
  });

  int? id;
  String? userId;
  String? cardToken;
  String? cardNumber;
  String? cardName;
  String? cardDate;
  dynamic cardPrimary;
  String? isDeleted;
  DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        cardToken: json["card_token"] as String? ?? '',
        cardNumber: json["card_number"] as String? ?? '',
        cardName: json["card_name"] as String? ?? '',
        cardDate: json["card_date"] as String? ?? '',
        cardPrimary: json["card_primary"],
        isDeleted: json["is_deleted"] as String? ?? '',
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "card_token": cardToken,
        "card_number": cardNumber,
        "card_name": cardName,
        "card_date": cardDate,
        "card_primary": cardPrimary,
        "is_deleted": isDeleted,
        "created_at": createdAt!.toIso8601String(),
      };
}
