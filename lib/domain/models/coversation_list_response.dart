// To parse this JSON data, do
//
//     final getConversationListResponse = getConversationListResponseFromJson(jsonString);

import 'dart:convert';

GetConversationListResponse getConversationListResponseFromJson(String str) =>
    GetConversationListResponse.fromJson(json.decode(str));

String getConversationListResponseToJson(GetConversationListResponse data) =>
    json.encode(data.toJson());

class GetConversationListResponse {
  GetConversationListResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<Datum>? data;
  String? returnMessage;

  factory GetConversationListResponse.fromJson(Map<String, dynamic> json) =>
      GetConversationListResponse(
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
    this.email,
    this.userType,
    this.profilePhotoPath,
    this.unread,
    this.latestMsg,
    this.profilePhotoUrl,
    this.profile,
  });

  int? id;
  String? email;
  String? userType;
  String? profilePhotoPath;
  int? unread;
  LatestMsg? latestMsg;
  String? profilePhotoUrl;
  Profile? profile;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        email: json["email"],
        userType: json["user_type"],
        profilePhotoPath: json["profile_photo_path"],
        unread: json["unread"],
        latestMsg: LatestMsg.fromJson(json["latest_msg"]),
        profilePhotoUrl: json["profile_photo_url"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "user_type": userType,
        "profile_photo_path": profilePhotoPath,
        "unread": unread,
        "latest_msg": latestMsg!.toJson(),
        "profile_photo_url": profilePhotoUrl,
        "profile": profile!.toJson(),
      };
}

class LatestMsg {
  LatestMsg({
    this.id,
    this.from,
    this.to,
    this.isRead,
    this.message,
    this.media,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic from;
  dynamic to;
  dynamic isRead;
  dynamic message;
  dynamic media;
  dynamic createdAt;
  dynamic updatedAt;

  factory LatestMsg.fromJson(Map<String, dynamic> json) => LatestMsg(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        isRead: json["is_read"],
        message: json["message"] as String? ?? '',
        media: json["media"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "is_read": isRead,
        "message": message,
        "media": media,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Profile {
  Profile({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
  });

  int? id;
  String? userId;
  String? firstName;
  String? lastName;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
      };
}
