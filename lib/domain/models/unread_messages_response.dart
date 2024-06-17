// To parse this JSON data, do
//
//     final unreadMessagesResponse = unreadMessagesResponseFromJson(jsonString);

import 'dart:convert';

UnreadMessagesResponse unreadMessagesResponseFromJson(String str) =>
    UnreadMessagesResponse.fromJson(json.decode(str));

String unreadMessagesResponseToJson(UnreadMessagesResponse data) =>
    json.encode(data.toJson());

class UnreadMessagesResponse {
  UnreadMessagesResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  int? data;
  String? returnMessage;

  factory UnreadMessagesResponse.fromJson(Map<String, dynamic> json) =>
      UnreadMessagesResponse(
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
