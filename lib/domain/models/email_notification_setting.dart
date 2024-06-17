// To parse this JSON data, do
//
//     final emailNotificationSetting = emailNotificationSettingFromJson(jsonString);

import 'dart:convert';

EmailNotificationSetting emailNotificationSettingFromJson(String str) =>
    EmailNotificationSetting.fromJson(json.decode(str));

String emailNotificationSettingToJson(EmailNotificationSetting data) =>
    json.encode(data.toJson());

class EmailNotificationSetting {
  EmailNotificationSetting({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory EmailNotificationSetting.fromJson(Map<String, dynamic> json) =>
      EmailNotificationSetting(
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
    this.status,
  });

  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
