import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/build_profile_response.dart';

class BuildProfilePresenter {
  BuildProfilePresenter(this.authCases);
  final AuthCases authCases;

  ///Build Profile Api call
  Future<ProfileResponse> profileUserModel({
    required String parentId,
    required String childId,
    required String profileImage,
    required String firstName,
    required String middleName,
    required String lastName,
    required String city,
    required String state,
    required String zip,
    required String height,
    required String weight,
    required String gender,
    required String ethnicity,
    required String dob,
    required String email,
    required String phone,
    required String maritalStatus,
  }) async =>
      authCases.profileUserModel(
        parentId: parentId,
        childId: childId,
        profileImage: profileImage,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        city: city,
        state: state,
        zip: zip,
        height: height,
        weight: weight,
        gender: gender,
        ethnicity: ethnicity,
        dob: dob,
        email: email,
        pass: phone,
        maritalStatus: maritalStatus,
      );
}
