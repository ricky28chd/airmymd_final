// To parse this JSON data, do
//
//     final bookingRejectResponse = bookingRejectResponseFromJson(jsonString);

import 'dart:convert';

BookingRejectResponse bookingRejectResponseFromJson(String str) =>
    BookingRejectResponse.fromJson(json.decode(str));

String bookingRejectResponseToJson(BookingRejectResponse data) =>
    json.encode(data.toJson());

class BookingRejectResponse {
  BookingRejectResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory BookingRejectResponse.fromJson(Map<String, dynamic> json) =>
      BookingRejectResponse(
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
    this.id,
    this.userId,
    this.doctorId,
    this.bookingDate,
    this.bookingTime,
    this.status,
    this.paymentType,
    this.reason,
    this.fees,
    this.sourceId,
    this.sourceName,
    this.transferGroup,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? doctorId;
  DateTime? bookingDate;
  String? bookingTime;
  String? status;
  String? paymentType;
  String? reason;
  String? fees;
  String? sourceId;
  String? sourceName;
  String? transferGroup;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        bookingDate: DateTime.parse(json["booking_date"]),
        bookingTime: json["booking_time"],
        status: json["status"],
        paymentType: json["payment_type"],
        reason: json["reason"],
        fees: json["fees"],
        sourceId: json["source_id"],
        sourceName: json["source_name"],
        transferGroup: json["transfer_group"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "booking_date":
            "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "booking_time": bookingTime,
        "status": status,
        "payment_type": paymentType,
        "reason": reason,
        "fees": fees,
        "source_id": sourceId,
        "source_name": sourceName,
        "transfer_group": transferGroup,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
