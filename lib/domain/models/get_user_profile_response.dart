import 'dart:convert';

GetUserProfileResponse getUserProfileResponseFromJson(String str) =>
    GetUserProfileResponse.fromJson(json.decode(str));

class GetUserProfileResponse {
  GetUserProfileResponse({
    required this.returnCode,
    required this.patientProfile,
    required this.childUsers,
  });
  final int returnCode;
  final PatientProfile patientProfile;
  final List<ChildUsers> childUsers;

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetUserProfileResponse(
        returnCode: json['returnCode'],
        patientProfile: PatientProfile.fromJson(json['data']),
        childUsers: json['child_users'] == null
            ? []
            : List<ChildUsers>.from(
                json['child_users'].map((x) => ChildUsers.fromJson(x))),
      );
}

class PatientProfile {
  PatientProfile({
    required this.userId,
    required this.userType,
    required this.email,
    required this.phone,
    required this.pushNotification,
    required this.emailNotification,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.city,
    required this.state,
    required this.zip,
    required this.height,
    required this.weight,
    required this.gender,
    required this.ethnicity,
    required this.dob,
    required this.maritialStatus,
    required this.profilePhotoUrl,
    required this.medicalHistory,
    required this.surgeries,
    required this.year,
    required this.age,
    required this.sexualHealth,
    required this.habits,
    required this.general,
    required this.skin,
    required this.eyes,
    required this.cigarette,
    required this.tobacco,
    required this.streetDrug,
    required this.needleDrug,
    required this.drinkAlcohol,
    required this.howMany,
    required this.drinksInDay,
    required this.cutDown,
    required this.feltGuilty,
    required this.morningDrink,
  });
  final String userId;
  final String userType;
  final String email;
  final String phone;
  final String pushNotification;
  final String emailNotification;
  final String fullAddress;
  final String latitude;
  final String longitude;
  final String firstName;
  final String middleName;
  final String lastName;
  final String city;
  final String state;
  final String zip;
  final String height;
  final String weight;
  final String gender;
  final String ethnicity;
  final String dob;
  final String maritialStatus;
  final String profilePhotoUrl;
  final String medicalHistory;
  final String surgeries;
  final String year;
  final String age;
  final String sexualHealth;
  final String habits;
  final String general;
  final dynamic skin;
  final dynamic eyes;
  final String cigarette;
  final String tobacco;
  final String streetDrug;
  final String needleDrug;
  final String drinkAlcohol;
  final dynamic howMany;
  final dynamic drinksInDay;
  final dynamic cutDown;
  final dynamic feltGuilty;
  final dynamic morningDrink;

  factory PatientProfile.fromJson(Map<String, dynamic> json) {
    return PatientProfile(
      userId: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['user_id'] as String? ?? '',
      userType: json['user_type'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      pushNotification: json['push_notification'] as String? ?? '',
      emailNotification: json['email_notification'] as String? ?? '',
      fullAddress: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['location'] as String? ?? '',
      latitude: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['latitude'] as String? ?? '',
      longitude: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['longitude'] as String? ?? '',
      firstName: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['first_name'] as String? ?? '',
      middleName: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['middle_name'] as String? ?? '',
      lastName: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['last_name'] as String? ?? '',
      city: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['city'] as String? ?? '',
      state: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['state'] as String? ?? '',
      zip: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['zip'] as String? ?? '',
      height: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['height'] as String? ?? '',
      weight: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['weight'] as String? ?? '',
      gender: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['gender'] as String? ?? '',
      ethnicity: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['ethnicity'] as String? ?? '',
      dob: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['dob'] as String? ?? '',
      maritialStatus: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['marital_status'] as String? ?? '',
      profilePhotoUrl: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['profile_photo_url'] as String? ?? '',
      medicalHistory: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['medical_history'] as String? ?? '',
      surgeries: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['surgeries'] as String? ?? '',
      year: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['year'] as String? ?? '',
      age: json['patient_profile'] == null
          ? ''
          : json['patient_profile']['age'] as String? ?? '',
      sexualHealth: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["sexual_health"] as String? ?? '',
      habits: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["habits"] as String? ?? '',
      general: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["general"] as String? ?? '',
      skin: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["skin"] as String? ?? '',
      eyes: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["eyes"] as String? ?? '',
      cigarette: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["cigarette"] as String? ?? '',
      tobacco: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["tobacco"] as String? ?? '',
      streetDrug: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["street_drug"] as String? ?? '',
      needleDrug: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["needle_drug"] as String? ?? '',
      drinkAlcohol: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["drink_alcohol"] as String? ?? '',
      howMany: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["how_many"] as String? ?? '',
      drinksInDay: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["drinks_in_day"] as String? ?? '',
      cutDown: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["cut_down"] as String? ?? '',
      feltGuilty: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["felt_guilty"] as String? ?? '',
      morningDrink: json['patient_profile'] == null
          ? ''
          : json['patient_profile']["morning_drink"] as String? ?? '',
    );
  }
}

class ChildUsers {
  ChildUsers({
    required this.childId,
    required this.parentId,
    required this.userType,
    required this.email,
    required this.phone,
    required this.childPatientProfile,
  });
  final int childId;
  final String parentId;
  final String userType;
  final String email;
  final String phone;
  final PatientProfile childPatientProfile;

  factory ChildUsers.fromJson(Map<String, dynamic> json) {
    return ChildUsers(
        childId: json['id'],
        parentId: json['parent_id'] as String? ?? '',
        userType: json['user_type'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        childPatientProfile: PatientProfile.fromJson(json));
  }
}
