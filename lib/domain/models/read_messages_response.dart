// To parse this JSON data, do
//
//     final readMessagesResponse = readMessagesResponseFromJson(jsonString);

import 'dart:convert';

ReadMessagesResponse readMessagesResponseFromJson(String str) =>
    ReadMessagesResponse.fromJson(json.decode(str));

String readMessagesResponseToJson(ReadMessagesResponse data) =>
    json.encode(data.toJson());

class ReadMessagesResponse {
  ReadMessagesResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  int? data;
  String? returnMessage;

  factory ReadMessagesResponse.fromJson(Map<String, dynamic> json) =>
      ReadMessagesResponse(
        returnCode: json["returnCode"],
        data: json["data"],
        returnMessage: json["returnMessage"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": data,
        "returnMessage": returnMessage,
      };
}
