import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/get_user_profile_response.dart';

import '../../../domain/models/set_location_response.dart';

class SetLocationPresenter {
  SetLocationPresenter(this.authCases);
  final AuthCases authCases;

  Future<SetLocationResponse> locationUserModel({
    required String location,
    required String longitude,
    required String latitude,
  }) async =>
      authCases.locationUserModel(
        location: location,
        longitude: longitude,
        latitude: latitude,
      );

  Future<GetUserProfileResponse> getUserProfile({
    required bool isLoading,
  }) =>
      authCases.getUserProfile(isLoading: isLoading);
}
