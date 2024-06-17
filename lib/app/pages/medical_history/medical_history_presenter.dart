import '../../../domain/models/medical_history_response.dart';
import '../../../domain/usecases/authcases.dart';

class MedicalHistoryPresenter {
  MedicalHistoryPresenter(this.authCases);
  final AuthCases authCases;

  Future<MedicalHistoryResponse> medicalHistoryUserModel({
    required String medicalHistory,
  }) async =>
      authCases.medicalHistoryUserModel(
        medicalHistory: medicalHistory,
      );
}
