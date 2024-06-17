// To parse this JSON data, do
//
//     final loginOtpVerificationResponse = loginOtpVerificationResponseFromJson(jsonString);

import 'dart:convert';

LoginOtpVerificationResponse loginOtpVerificationResponseFromJson(String str) =>
    LoginOtpVerificationResponse.fromJson(json.decode(str));

String loginOtpVerificationResponseToJson(LoginOtpVerificationResponse data) =>
    json.encode(data.toJson());

class LoginOtpVerificationResponse {
  LoginOtpVerificationResponse({
    this.returnCode,
    this.data,
    this.returnMessage,
  });

  int? returnCode;
  Data? data;
  String? returnMessage;

  factory LoginOtpVerificationResponse.fromJson(Map<String, dynamic> json) =>
      LoginOtpVerificationResponse(
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
    this.token,
    this.userData,
  });

  String? token;
  List<UserDatum>? userData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userData: List<UserDatum>.from(
            json["userData"].map((x) => UserDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userData": List<dynamic>.from(userData!.map((x) => x.toJson())),
      };
}

class UserDatum {
  UserDatum({
    this.id,
    this.name,
    this.phone,
    this.countryCode,
    this.email,
    this.userType,
    this.pushNotification,
    this.emailNotification,
    this.profilePhotoPath,
    this.stripeCustomer,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoUrl,
    this.averageRating,
    this.patientProfile,
  });

  int? id;
  dynamic name;
  String? phone;
  dynamic countryCode;
  String? email;
  String? userType;
  String? pushNotification;
  String? emailNotification;
  String? profilePhotoPath;
  dynamic stripeCustomer;
  dynamic deviceToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? profilePhotoUrl;
  String? averageRating;
  PatientProfile? patientProfile;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        countryCode: json["country_code"],
        email: json["email"],
        userType: json["user_type"],
        pushNotification: json["push_notification"],
        emailNotification: json["email_notification"],
        profilePhotoPath: json["profile_photo_path"],
        stripeCustomer: json["stripe_customer"],
        deviceToken: json["device_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profilePhotoUrl: json["profile_photo_url"],
        averageRating: json["average_rating"],
        patientProfile: PatientProfile.fromJson(json["patient_profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "country_code": countryCode,
        "email": email,
        "user_type": userType,
        "push_notification": pushNotification,
        "email_notification": emailNotification,
        "profile_photo_path": profilePhotoPath,
        "stripe_customer": stripeCustomer,
        "device_token": deviceToken,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "profile_photo_url": profilePhotoUrl,
        "average_rating": averageRating,
        "patient_profile": patientProfile!.toJson(),
      };
}

class PatientProfile {
  PatientProfile({
    this.id,
    this.userId,
    this.location,
    this.latitude,
    this.longitude,
    this.firstName,
    this.middleName,
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
    this.medicalHistory,
    this.surgeries,
    this.year,
    this.age,
    this.sexualHealth,
    this.habits,
    this.general,
    this.skin,
    this.eyes,
    this.cigarette,
    this.tobacco,
    this.streetDrug,
    this.needleDrug,
    this.drinkAlcohol,
    this.howMany,
    this.drinksInDay,
    this.cutDown,
    this.feltGuilty,
    this.morningDrink,
  });

  int? id;
  String? userId;
  String? location;
  String? latitude;
  String? longitude;
  String? firstName;
  String? middleName;
  String? lastName;
  String? city;
  String? state;
  String? zip;
  String? height;
  String? weight;
  String? gender;
  String? ethnicity;
  String? dob;
  String? maritalStatus;
  String? medicalHistory;
  dynamic surgeries;
  dynamic year;
  dynamic age;
  String? sexualHealth;
  String? habits;
  String? general;
  dynamic skin;
  dynamic eyes;
  String? cigarette;
  String? tobacco;
  String? streetDrug;
  String? needleDrug;
  String? drinkAlcohol;
  dynamic howMany;
  dynamic drinksInDay;
  dynamic cutDown;
  dynamic feltGuilty;
  dynamic morningDrink;

  factory PatientProfile.fromJson(Map<String, dynamic> json) => PatientProfile(
        id: json["id"] as int? ?? 0,
        userId: json["user_id"] as String? ?? '',
        location: json["location"] as String? ?? '',
        latitude: json["latitude"] as String? ?? '',
        longitude: json["longitude"] as String? ?? '',
        firstName: json["first_name"] as String? ?? '',
        middleName: json["middle_name"] as String? ?? '',
        lastName: json["last_name"] as String? ?? '',
        city: json["city"] as String? ?? '',
        state: json["state"] as String? ?? '',
        zip: json["zip"] as String? ?? '',
        height: json["height"] as String? ?? '',
        weight: json["weight"] as String? ?? '',
        gender: json["gender"] as String? ?? '',
        ethnicity: json["ethnicity"] as String? ?? '',
        dob: json["dob"] as String? ?? '',
        maritalStatus: json["marital_status"] as String? ?? '',
        medicalHistory: json["medical_history"] as String? ?? '',
        surgeries: json["surgeries"] as String? ?? '',
        year: json["year"] as String? ?? '',
        age: json["age"] as String? ?? '',
        sexualHealth: json["sexual_health"] as String? ?? '',
        habits: json["habits"] as String? ?? '',
        general: json["general"] as String? ?? '',
        skin: json["skin"] as String? ?? '',
        eyes: json["eyes"] as String? ?? '',
        cigarette: json["cigarette"] as String? ?? '',
        tobacco: json["tobacco"] as String? ?? '',
        streetDrug: json["street_drug"] as String? ?? '',
        needleDrug: json["needle_drug"] as String? ?? '',
        drinkAlcohol: json["drink_alcohol"] as String? ?? '',
        howMany: json["how_many"] as String? ?? '',
        drinksInDay: json["drinks_in_day"] as String? ?? '',
        cutDown: json["cut_down"] as String? ?? '',
        feltGuilty: json["felt_guilty"] as String? ?? '',
        morningDrink: json["morning_drink"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "city": city,
        "state": state,
        "zip": zip,
        "height": height,
        "weight": weight,
        "gender": gender,
        "ethnicity": ethnicity,
        "dob": dob,
        "marital_status": maritalStatus,
        "medical_history": medicalHistory,
        "surgeries": surgeries,
        "year": year,
        "age": age,
        "sexual_health": sexualHealth,
        "habits": habits,
        "general": general,
        "skin": skin,
        "eyes": eyes,
        "cigarette": cigarette,
        "tobacco": tobacco,
        "street_drug": streetDrug,
        "needle_drug": needleDrug,
        "drink_alcohol": drinkAlcohol,
        "how_many": howMany,
        "drinks_in_day": drinksInDay,
        "cut_down": cutDown,
        "felt_guilty": feltGuilty,
        "morning_drink": morningDrink,
      };
}
