// To parse this JSON data, do
//
//     final getNotificationList = getNotificationListFromJson(jsonString);

import 'dart:convert';

GetNotificationList getNotificationListFromJson(String str) =>
    GetNotificationList.fromJson(json.decode(str));

String getNotificationListToJson(GetNotificationList data) =>
    json.encode(data.toJson());

class GetNotificationList {
  GetNotificationList({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory GetNotificationList.fromJson(Map<String, dynamic> json) =>
      GetNotificationList(
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
    this.notifications,
    this.unreadCount,
  });

  List<Notification>? notifications;
  int? unreadCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "unread_count": unreadCount,
      };
}

class Notification {
  Notification({
    this.id,
    this.from,
    this.to,
    this.isRead,
    this.title,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? from;
  String? to;
  String? isRead;
  dynamic title;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"] as int? ?? 0,
        from: json["from"] as String? ?? '',
        to: json["to"] as String? ?? '',
        isRead: json["is_read"] as String? ?? '',
        title: json["title"] as String? ?? '',
        message: json["message"] as String? ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "is_read": isRead,
        "title": title,
        "message": message,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
