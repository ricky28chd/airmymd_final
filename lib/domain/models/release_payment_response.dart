// To parse this JSON data, do
//
//     final paymentReleaseResponse = paymentReleaseResponseFromJson(jsonString);

import 'dart:convert';

PaymentReleaseResponse paymentReleaseResponseFromJson(String str) =>
    PaymentReleaseResponse.fromJson(json.decode(str));

String paymentReleaseResponseToJson(PaymentReleaseResponse data) =>
    json.encode(data.toJson());

class PaymentReleaseResponse {
  PaymentReleaseResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  List<dynamic>? data;
  String? returnMessage;

  factory PaymentReleaseResponse.fromJson(Map<String, dynamic> json) =>
      PaymentReleaseResponse(
        returnCode: json["returnCode"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        returnMessage: json["returnMessage"],
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": List<dynamic>.from(data!.map((x) => x)),
        "returnMessage": returnMessage,
      };
}
