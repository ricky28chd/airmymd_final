// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.returnCode,
    required this.data,
    required this.returnMessage,
  });

  int returnCode;
  Data data;
  String returnMessage;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    returnCode: json["returnCode"],
    data: Data.fromJson(json["data"]),
    returnMessage: json["returnMessage"],
  );

  Map<String, dynamic> toJson() => {
    "returnCode": returnCode,
    "data": data.toJson(),
    "returnMessage": returnMessage,
  };
}

class Data {
  Data({
    required this.code,
  });

  int code;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
  };
}
