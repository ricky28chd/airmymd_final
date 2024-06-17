// To parse this JSON data, do
//
//     final registerOtpVerificationResponse = registerOtpVerificationResponseFromJson(jsonString);

import 'dart:convert';

RegisterOtpVerificationResponse registerOtpVerificationResponseFromJson(
        String str) =>
    RegisterOtpVerificationResponse.fromJson(json.decode(str));

String registerOtpVerificationResponseToJson(
        RegisterOtpVerificationResponse data) =>
    json.encode(data.toJson());

class RegisterOtpVerificationResponse {
  RegisterOtpVerificationResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory RegisterOtpVerificationResponse.fromJson(Map<String, dynamic> json) =>
      RegisterOtpVerificationResponse(
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
    this.phone,
    this.email,
    this.password,
    this.userType,
    this.token,
  });

  String? phone;
  String? email;
  String? password;
  String? userType;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        userType: json["user_type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
        "password": password,
        "user_type": userType,
        "token": token,
      };
}
