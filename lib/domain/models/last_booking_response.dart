// To parse this JSON data, do
//
//     final lastBookingResponse = lastBookingResponseFromJson(jsonString);

import 'dart:convert';

LastBookingResponse lastBookingResponseFromJson(String str) =>
    LastBookingResponse.fromJson(json.decode(str));

String lastBookingResponseToJson(LastBookingResponse data) =>
    json.encode(data.toJson());

class LastBookingResponse {
  LastBookingResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory LastBookingResponse.fromJson(Map<String, dynamic> json) =>
      LastBookingResponse(
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
    this.reviewed,
  });

  Reviewed? reviewed;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reviewed: Reviewed.fromJson(json["reviewed"]),
      );

  Map<String, dynamic> toJson() => {
        "reviewed": reviewed!.toJson(),
      };
}

class Reviewed {
  Reviewed({
    this.id,
    this.userId,
    this.doctorId,
    this.bookingDate,
    this.bookingTime,
    this.status,
    this.paymentType,
    this.reason,
    this.doctor,
  });

  int? id;
  String? userId;
  String? doctorId;
  String? bookingDate;
  String? bookingTime;
  String? status;
  String? paymentType;
  dynamic reason;
  Doctor? doctor;

  factory Reviewed.fromJson(Map<String, dynamic> json) => Reviewed(
        id: json["id"],
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        bookingDate: json["booking_date"],
        bookingTime: json["booking_time"],
        status: json["status"],
        paymentType: json["payment_type"],
        reason: json["reason"],
        doctor: Doctor.fromJson(json["doctor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "booking_date": bookingDate,
        "booking_time": bookingTime,
        "status": status,
        "payment_type": paymentType,
        "reason": reason,
        "doctor": doctor!.toJson(),
      };
}

class Doctor {
  Doctor({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.profilePhotoUrl,
  });

  int? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? profilePhotoUrl;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "profile_photo_url": profilePhotoUrl,
      };
}
