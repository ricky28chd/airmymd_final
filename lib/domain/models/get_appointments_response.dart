// To parse this JSON data, do
//
//     final appointmentsResponse = appointmentsResponseFromJson(jsonString);

import 'dart:convert';

AppointmentsResponse appointmentsResponseFromJson(String str) =>
    AppointmentsResponse.fromJson(json.decode(str));

String appointmentsResponseToJson(AppointmentsResponse data) =>
    json.encode(data.toJson());

class AppointmentsResponse {
  AppointmentsResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory AppointmentsResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentsResponse(
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
    this.upcoming,
    this.past,
  });

  List<Past>? upcoming;
  List<Past>? past;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        upcoming:
            List<Past>.from(json["upcoming"].map((x) => Past.fromJson(x))),
        past: List<Past>.from(json["past"].map((x) => Past.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "upcoming": List<dynamic>.from(upcoming!.map((x) => x.toJson())),
        "past": List<dynamic>.from(past!.map((x) => x.toJson())),
      };
}

class Past {
  Past({
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
    this.doctor,
    this.user,
    this.patientName,
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
  dynamic transferGroup;
  DateTime? createdAt;
  DateTime? updatedAt;
  Doctor? doctor;
  User? user;
  String? patientName;

  factory Past.fromJson(Map<String, dynamic> json) => Past(
        id: json["id"],
        userId: json["user_id"] as String? ?? '',
        doctorId: json["doctor_id"] as String? ?? '',
        bookingDate: DateTime.parse(json["booking_date"]),
        bookingTime: json["booking_time"] as String? ?? '',
        status: json["status"] as String? ?? '',
        paymentType: json["payment_type"] as String? ?? '',
        reason: json["reason"] as String? ?? '',
        fees: json["fees"] as String? ?? '',
        sourceId: json["source_id"] as String? ?? '',
        sourceName: json["source_name"] == null
            ? null
            : json["source_name"] as String? ?? '',
        transferGroup: json["transfer_group"] as String? ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        doctor: Doctor.fromJson(json["doctor"]),
        user: User.fromJson(json["user"]),
        patientName: json["patient_name"] as String? ?? '',
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
        "doctor": doctor!.toJson(),
        "user": user!.toJson(),
      };
}

class Doctor {
  Doctor({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.state,
    this.zipcode,
    this.bio,
    this.specialization,
    this.patientsGender,
    this.telemedicine,
    this.insurance,
    this.tags,
    this.latitude,
    this.longitude,
    this.days,
    this.specialDays,
    this.fees,
    this.profileImage,
  });

  int? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? bio;
  String? specialization;
  String? patientsGender;
  String? telemedicine;
  String? insurance;
  String? tags;
  String? latitude;
  String? longitude;
  String? days;
  String? specialDays;
  String? fees;
  String? profileImage;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        firstName: json["first_name"] as String? ?? '',
        lastName: json["last_name"] as String? ?? '',
        address: json["address"] as String? ?? '',
        city: json["city"] as String? ?? '',
        state: json["state"] as String? ?? '',
        zipcode: json["zipcode"] as String? ?? '',
        bio: json["bio"] as String? ?? '',
        specialization: json["specialization"] as String? ?? '',
        patientsGender: json["patients_gender"] as String? ?? '',
        telemedicine: json["telemedicine"] as String? ?? '',
        insurance: json["insurance"] as String? ?? '',
        tags: json["tags"] as String? ?? '',
        latitude:
            json["latitude"] == null ? null : json["latitude"] as String? ?? '',
        longitude: json["longitude"] == null
            ? null
            : json["longitude"] as String? ?? '',
        days: json["days"] as String? ?? '',
        specialDays: json["special_days"] as String? ?? '',
        fees: json["fees"] as String? ?? '',
        profileImage: json["profile_photo_url"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "bio": bio,
        "specialization": specialization,
        "patients_gender": patientsGender,
        "telemedicine": telemedicine,
        "insurance": insurance,
        "tags": tags,
        "latitude": latitude,
        "longitude": longitude,
        "days": days,
        "special_days": specialDays,
        "fees": fees,
        "profile_photo_url": profileImage,
      };
}

class User {
  User({
    this.id,
    this.profilePhotoUrl,
  });

  int? id;
  String? profilePhotoUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_photo_url": profilePhotoUrl,
      };
}
