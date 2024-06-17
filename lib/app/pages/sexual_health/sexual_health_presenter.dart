import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/sexual_health_response.dart';

class SexualHealthPresenter {
  SexualHealthPresenter(this.authCases);
  final AuthCases authCases;

  Future<SexualHealthResponse> sexualHealthUserModel({
    required String sexualStatus,
  }) async =>
      authCases.sexualHealthUserModel(
        sexualStatus: sexualStatus,
      );
}
