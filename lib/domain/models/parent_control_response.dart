import 'dart:convert';

ParentControlResponse parentControlResponseFromJson(String str) =>
    ParentControlResponse.fromJson(json.decode(str));

class ParentControlResponse {
  ParentControlResponse({
    required this.returnCode,
    required this.activeUserToken,
  });

  final int returnCode;
  final String activeUserToken;

  factory ParentControlResponse.fromJson(Map<String, dynamic> json) =>
      ParentControlResponse(
        returnCode: json['returnCode'],
        activeUserToken: json['data']['token'],
      );
}
