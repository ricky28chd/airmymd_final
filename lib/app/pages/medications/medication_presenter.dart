import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/get_medication_response.dart';
import '../../../domain/models/medication_response.dart';

class MedicationPresenter {
  MedicationPresenter(this.authCases);
  final AuthCases authCases;

  Future<MedicationResponse> medicationUserModel({
    required List<Map<String, dynamic>> map,
  }) async =>
      authCases.medicationUserModel(
        map: map,
      );

  Future<GetMedicationResponse> getMedication({
    bool isLoading = false,
  }) async =>
      authCases.getMedication(
        isLoading: isLoading,
      );
}
