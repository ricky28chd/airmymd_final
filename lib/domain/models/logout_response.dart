// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) =>
    LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<dynamic>? data;
  String? returnMessage;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
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
