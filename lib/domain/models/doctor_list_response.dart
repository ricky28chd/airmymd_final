// To parse this JSON data, do
//
//     final doctorListResponse = doctorListResponseFromJson(jsonString);

import 'dart:convert';

DoctorListResponse doctorListResponseFromJson(String str) =>
    DoctorListResponse.fromJson(json.decode(str));

String doctorListResponseToJson(DoctorListResponse data) =>
    json.encode(data.toJson());

class DoctorListResponse {
  DoctorListResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory DoctorListResponse.fromJson(Map<String, dynamic> json) =>
      DoctorListResponse(
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
    this.data,
    this.total,
  });

  List<Datum>? data;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.phone,
    this.countryCode,
    this.email,
    this.status,
    this.emailVerifiedAt,
    this.userType,
    this.pushNotification,
    this.emailNotification,
    this.twoFactorConfirmedAt,
    this.currentTeamId,
    this.profilePhotoPath,
    this.stripeCustomer,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
    this.averageRating,
    this.reviews,
    this.profile,
  });

  int? id;
  dynamic name;
  dynamic phone;
  dynamic countryCode;
  String? email;
  String? status;
  dynamic emailVerifiedAt;
  String? userType;
  String? pushNotification;
  String? emailNotification;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  String? profilePhotoPath;
  dynamic stripeCustomer;
  dynamic deviceToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profilePhotoUrl;
  String? averageRating;
  List<Review>? reviews;
  Profile? profile;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"] as String? ?? '',
        phone: json["phone"] as String? ?? '',
        countryCode: json["country_code"] as String? ?? '',
        email: json["email"] as String? ?? '',
        status: json["status"] as String? ?? '',
        emailVerifiedAt: json["email_verified_at"] as String? ?? '',
        userType: json["user_type"] as String? ?? '',
        pushNotification: json["push_notification"] as String? ?? '',
        emailNotification: json["email_notification"] as String? ?? '',
        twoFactorConfirmedAt: json["two_factor_confirmed_at"] as String? ?? '',
        currentTeamId: json["current_team_id"] as String? ?? '',
        profilePhotoPath: json["profile_photo_path"] as String? ?? '',
        stripeCustomer: json["stripe_customer"] as String? ?? '',
        deviceToken: json["device_token"] as String? ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profilePhotoUrl: json["profile_photo_url"] as String? ?? '',
        averageRating: json["average_rating"] as String? ?? '',
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "country_code": countryCode,
        "email": email,
        "status": status,
        "email_verified_at": emailVerifiedAt,
        "user_type": userType,
        "push_notification": pushNotification,
        "email_notification": emailNotification,
        "two_factor_confirmed_at": twoFactorConfirmedAt,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "stripe_customer": stripeCustomer,
        "device_token": deviceToken,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "profile_photo_url": profilePhotoUrl,
        "average_rating": averageRating,
        "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "profile": profile!.toJson(),
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
    this.telemedicine,
    this.insurance,
    this.tags,
    this.latitude,
    this.longitude,
    this.fees,
    this.profilePhotoUrl,
  });

  int? id;
  String? userId;
  dynamic firstName;
  dynamic lastName;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic zipcode;
  String? bio;
  String? specialization;
  String? telemedicine;
  String? insurance;
  String? tags;
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
        telemedicine: json["telemedicine"] as String? ?? '',
        insurance: json["insurance"] as String? ?? '',
        tags: json["tags"] as String? ?? '',
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
        "telemedicine": telemedicine,
        "insurance": insurance,
        "tags": tags,
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
    this.rating,
    this.review,
    this.createdAt,
  });

  int? id;
  String? userId;
  String? doctorId;
  String? rating;
  String? review;
  DateTime? createdAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        doctorId: json["doctor_id"],
        rating: json["rating"],
        review: json["review"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "rating": rating,
        "review": review,
        "created_at": createdAt!.toIso8601String(),
      };
}
