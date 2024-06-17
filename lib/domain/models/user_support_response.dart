import 'dart:convert';

UserSupportResponse userSupportResponseFromJson(String str) =>
    UserSupportResponse.fromJson(json.decode(str));

class UserSupportResponse {
  UserSupportResponse({
    this.returnCode,
    this.returnMessage,
  });
  int? returnCode;
  String? returnMessage;

  factory UserSupportResponse.fromJson(Map<String, dynamic> json) =>
      UserSupportResponse(
        returnCode: json['returnCode'],
        returnMessage: json['returnMessage'],
      );
}
