import 'package:airmymd/domain/domain.dart';
import '../../../domain/models/general_health_response.dart';

class GeneralHealthPresenter {
  GeneralHealthPresenter(this.authCases);
  final AuthCases authCases;

  Future<GeneralHealthResponse> generalHealthUserModel({
    required String general,
    required String skinProblem,
    required String eyeEarProblem,
  }) async =>
      authCases.generalHealthUserModel(
        general: general,
        skinProblem: skinProblem,
        eyeEarProblem: eyeEarProblem,
      );
}
