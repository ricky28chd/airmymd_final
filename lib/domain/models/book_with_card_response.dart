// To parse this JSON data, do
//
//     final bookWithCardResponse = bookWithCardResponseFromJson(jsonString);

import 'dart:convert';

BookWithCardResponse bookWithCardResponseFromJson(String str) =>
    BookWithCardResponse.fromJson(json.decode(str));

String bookWithCardResponseToJson(BookWithCardResponse data) =>
    json.encode(data.toJson());

class BookWithCardResponse {
  BookWithCardResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory BookWithCardResponse.fromJson(Map<String, dynamic> json) =>
      BookWithCardResponse(
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
    this.userId,
    this.bookingDate,
    this.bookingTime,
    this.paymentType,
    this.doctorId,
    this.status,
    this.reason,
    this.fees,
    this.sourceId,
    this.sourceName,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.doctorFirstname,
    this.doctorLastName,
  });

  int? userId;
  DateTime? bookingDate;
  String? bookingTime;
  String? paymentType;
  int? doctorId;
  String? status;
  String? reason;
  String? fees;
  String? sourceId;
  dynamic sourceName;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? doctorFirstname;
  String? doctorLastName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        bookingTime: json["booking_time"],
        paymentType: json["payment_type"],
        doctorId: json["doctor_id"],
        status: json["status"],
        reason: json["reason"],
        fees: json["fees"],
        sourceId: json["source_id"],
        sourceName: json["source_name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        doctorFirstname: json["doctor_firstname"] as String? ?? '',
        doctorLastName: json["doctor_last_name"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "booking_date":
            "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "booking_time": bookingTime,
        "payment_type": paymentType,
        "doctor_id": doctorId,
        "status": status,
        "reason": reason,
        "fees": fees,
        "source_id": sourceId,
        "source_name": sourceName,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "doctor_firstname": doctorFirstname,
        "doctor_last_name": doctorLastName,
      };
}
