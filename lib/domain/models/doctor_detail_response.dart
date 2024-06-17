// To parse this JSON data, do
//
//     final doctorDetailResponse = doctorDetailResponseFromJson(jsonString);

import 'dart:convert';

DoctorDetailResponse doctorDetailResponseFromJson(String str) =>
    DoctorDetailResponse.fromJson(json.decode(str));

String doctorDetailResponseToJson(DoctorDetailResponse data) =>
    json.encode(data.toJson());

class DoctorDetailResponse {
  DoctorDetailResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory DoctorDetailResponse.fromJson(Map<String, dynamic> json) =>
      DoctorDetailResponse(
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
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
    this.averageRating,
    this.profile,
    this.reviews,
  });

  int? id;
  String? profilePhotoPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profilePhotoUrl;
  String? averageRating;
  Profile? profile;
  List<Review>? reviews;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] as int? ?? 0,
        profilePhotoPath: json["profile_photo_path"] as String? ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profilePhotoUrl: json["profile_photo_url"] as String? ?? '',
        averageRating: json["average_rating"] as String? ?? '',
        profile: Profile.fromJson(json["profile"]),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_photo_path": profilePhotoPath,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "profile_photo_url": profilePhotoUrl,
        "average_rating": averageRating,
        "profile": profile!.toJson(),
        "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Profile {
  Profile({
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
    this.insurance,
    this.latitude,
    this.longitude,
    this.fees,
    this.profilePhotoUrl,
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
  String? insurance;
  String? latitude;
  String? longitude;
  String? fees;
  String? profilePhotoUrl;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
        insurance: json["insurance"] as String? ?? '',
        latitude: json["latitude"] as String? ?? '',
        longitude: json["longitude"] as String? ?? '',
        fees: json["fees"] as String? ?? '',
        profilePhotoUrl: json["profile_photo_url"] as String? ?? '',
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
        "insurance": insurance,
        "latitude": latitude,
        "longitude": longitude,
        "fees": fees,
        "profile_photo_url": profilePhotoUrl,
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
  });

  int? id;
  String? userId;
  String? doctorId;
  dynamic bookingId;
  String? rating;
  String? review;
  DateTime? createdAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        doctorId: json["doctor_id"] as String? ?? '',
        bookingId: json["booking_id"] as String? ?? '',
        rating: json["rating"] as String? ?? '',
        review: json["review"] as String? ?? '',
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "booking_id": bookingId,
        "rating": rating,
        "review": review,
        "created_at": createdAt!.toIso8601String(),
      };
}
