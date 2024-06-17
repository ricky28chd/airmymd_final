import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/doctor_list_response.dart';

class GoogleScreenPresenter {
  GoogleScreenPresenter(this.authCases);
  final AuthCases authCases;

  Future<DoctorListResponse> doctorListUserModel({
    required String latitude,
    required String longitude,
    required String specialization,
    bool isLoading = false,
  }) async =>
      authCases.doctorListUserModel(
        latitude: latitude,
        longitude: longitude,
        specialization: specialization,
        isLoading: isLoading
      );
}
