// To parse this JSON data, do
//
//     final readNotificationResponse = readNotificationResponseFromJson(jsonString);

import 'dart:convert';

ReadNotificationResponse readNotificationResponseFromJson(String str) => ReadNotificationResponse.fromJson(json.decode(str));

String readNotificationResponseToJson(ReadNotificationResponse data) => json.encode(data.toJson());

class ReadNotificationResponse {
    ReadNotificationResponse({
        this.returnCode,
        this.data,
        this.returnMessage,
    });

    int ?returnCode;
    int ?data;
    String? returnMessage;

    factory ReadNotificationResponse.fromJson(Map<String, dynamic> json) => ReadNotificationResponse(
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
