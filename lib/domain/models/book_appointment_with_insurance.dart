// To parse this JSON data, do
//
//     final insuranceBookingResponse = insuranceBookingResponseFromJson(jsonString);

import 'dart:convert';

InsuranceBookingResponse insuranceBookingResponseFromJson(String str) =>
    InsuranceBookingResponse.fromJson(json.decode(str));

String insuranceBookingResponseToJson(InsuranceBookingResponse data) =>
    json.encode(data.toJson());

class InsuranceBookingResponse {
  InsuranceBookingResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory InsuranceBookingResponse.fromJson(Map<String, dynamic> json) =>
      InsuranceBookingResponse(
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
    this.doctorId,
    this.bookingDate,
    this.bookingTime,
    this.paymentType,
    this.reason,
    this.sourceId,
    this.sourceName,
    this.doctorFirstname,
    this.doctorLastName,
  });

  int? doctorId;
  DateTime? bookingDate;
  String? bookingTime;
  String? paymentType;
  dynamic reason;
  String? sourceId;
  String? sourceName;
  String? doctorFirstname;
  String? doctorLastName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        doctorId: json["doctor_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        bookingTime: json["booking_time"],
        paymentType: json["payment_type"],
        reason: json["reason"],
        sourceId: json["source_id"],
        sourceName: json["source_name"],
        doctorFirstname: json["doctor_firstname"],
        doctorLastName: json["doctor_last_name"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "booking_date":
            "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "booking_time": bookingTime,
        "payment_type": paymentType,
        "reason": reason,
        "source_id": sourceId,
        "source_name": sourceName,
        "doctor_firstname": doctorFirstname,
        "doctor_last_name": doctorLastName,
      };
}
