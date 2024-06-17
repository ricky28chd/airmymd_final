// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
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
    this.firstName,
    this.lastName,
    this.city,
    this.state,
    this.zip,
    this.height,
    this.weight,
    this.gender,
    this.ethnicity,
    this.dob,
    this.maritalStatus,
    this.middleName,
    this.profilePhotoPath,
    this.email,
    this.phone,
    this.newChildId,
  });

  String? firstName;
  String? lastName;
  String? city;
  String? state;
  String? zip;
  String? height;
  String? weight;
  String? gender;
  String? ethnicity;
  String? email;
  String? phone;
  DateTime? dob;
  String? maritalStatus;
  String? middleName;
  String? profilePhotoPath;
  int? newChildId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"] as String? ?? '',
        lastName: json["last_name"] as String? ?? '',
        city: json["city"] as String? ?? '',
        state: json["state"] as String? ?? '',
        zip: json["zip"] as String? ?? '',
        height: json["height"] as String? ?? '',
        weight: json["weight"] as String? ?? '',
        gender: json["gender"] as String? ?? '',
        email: json["email"] as String? ?? '',
        phone: json["phone"] as String? ?? '',
        ethnicity: json["ethnicity"] as String? ?? '',
        dob: DateTime.parse(json["dob"]),
        maritalStatus: json["marital_status"] as String? ?? '',
        middleName: json["middle_name"] as String? ?? '',
        profilePhotoPath: json["profile_photo_path"] as String? ?? '',
        newChildId: json["new_child_id"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "city": city,
        "state": state,
        "zip": zip,
        "height": height,
        "weight": weight,
        "gender": gender,
        "ethnicity": ethnicity,
        "email": email,
        "phone": phone,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "marital_status": maritalStatus,
        "middle_name": middleName,
        "profile_photo_path": profilePhotoPath,
      };
}
