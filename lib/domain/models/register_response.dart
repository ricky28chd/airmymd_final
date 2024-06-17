// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    required this.returnCode,
    required this.data,
    required this.returnMessage,
  });

  int returnCode;
  Data data;
  String returnMessage;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
