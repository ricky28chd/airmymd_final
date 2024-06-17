// To parse this JSON data, do
//
//     final deleteBankCardResponse = deleteBankCardResponseFromJson(jsonString);

import 'dart:convert';

DeleteBankCardResponse deleteBankCardResponseFromJson(String str) =>
    DeleteBankCardResponse.fromJson(json.decode(str));

String deleteBankCardResponseToJson(DeleteBankCardResponse data) =>
    json.encode(data.toJson());

class DeleteBankCardResponse {
  DeleteBankCardResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<dynamic>? data;
  String? returnMessage;

  factory DeleteBankCardResponse.fromJson(Map<String, dynamic> json) =>
      DeleteBankCardResponse(
        returnCode: json["returnCode"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        returnMessage: json["returnMessage"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "returnMessage": returnMessage,
      };
}
