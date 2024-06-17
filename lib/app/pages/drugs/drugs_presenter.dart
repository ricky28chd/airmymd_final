import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/drug_response.dart';

class DrugsPresenter {
  DrugsPresenter(this.authCases);
  final AuthCases authCases;

  Future<DrugResponse> drugUserModel({
    required String streetDrug,
    required String needleDrug,
  }) async =>
      await authCases.drugUserModel(
        streetDrug: streetDrug,
        needleDrug: needleDrug,
      );
}
