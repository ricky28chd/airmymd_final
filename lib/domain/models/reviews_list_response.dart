// To parse this JSON data, do
//
//     final reviewsListResponse = reviewsListResponseFromJson(jsonString);

import 'dart:convert';

ReviewsListResponse reviewsListResponseFromJson(String str) =>
    ReviewsListResponse.fromJson(json.decode(str));

String reviewsListResponseToJson(ReviewsListResponse data) =>
    json.encode(data.toJson());

class ReviewsListResponse {
  ReviewsListResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory ReviewsListResponse.fromJson(Map<String, dynamic> json) =>
      ReviewsListResponse(
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
    this.reviews,
    this.doctorProfile,
  });

  List<Review>? reviews;
  DoctorProfile? doctorProfile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        doctorProfile: DoctorProfile.fromJson(json["doctor_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "doctor_profile": doctorProfile!.toJson(),
      };
}

class DoctorProfile {
  DoctorProfile({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.profilePhotoUrl,
    this.middleName,
  });

  int? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? profilePhotoUrl;
  dynamic middleName;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => DoctorProfile(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        firstName: json["first_name"] as String? ?? '',
        lastName: json["last_name"] as String? ?? '',
        profilePhotoUrl: json["profile_photo_url"] as String? ?? '',
        middleName: json["middle_name"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "profile_photo_url": profilePhotoUrl,
        "middle_name": middleName,
      };
}

class Review {
  Review({
    this.id,
    this.userId,
    this.doctorId,
    this.bookingId,
    this.rating,
    this.review,
    this.createdAt,
    this.patientProfileData,
  });

  int? id;
  String? userId;
  String? doctorId;
  dynamic bookingId;
  String? rating;
  String? review;
  DateTime? createdAt;
  DoctorProfile? patientProfileData;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        doctorId: json["doctor_id"] as String? ?? '',
        bookingId: json["booking_id"] as String? ?? '',
        rating: json["rating"] as String? ?? '',
        review: json["review"] as String? ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        patientProfileData:
            DoctorProfile.fromJson(json["patient_profile_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "booking_id": bookingId,
        "rating": rating,
        "review": review,
        "created_at": createdAt!.toIso8601String(),
        "patient_profile_data": patientProfileData!.toJson(),
      };
}
