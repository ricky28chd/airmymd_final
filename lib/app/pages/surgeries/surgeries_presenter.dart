import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/surgeries_response.dart';

class SurgeriesPresenter {
  SurgeriesPresenter(this.authCases);
  final AuthCases authCases;

  Future<SurgeriesResponse> surgeryUserModel({
    required String surgery,
    required String year,
    required String age,
  }) =>
      authCases.surgeriesUserModel(
        surgery: surgery,
        year: year,
        age: age,
      );
}
