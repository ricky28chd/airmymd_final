// To parse this JSON data, do
//
//     final pushNotificationSetting = pushNotificationSettingFromJson(jsonString);

import 'dart:convert';

PushNotificationSetting pushNotificationSettingFromJson(String str) =>
    PushNotificationSetting.fromJson(json.decode(str));

String pushNotificationSettingToJson(PushNotificationSetting data) =>
    json.encode(data.toJson());

class PushNotificationSetting {
  PushNotificationSetting({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory PushNotificationSetting.fromJson(Map<String, dynamic> json) =>
      PushNotificationSetting(
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
