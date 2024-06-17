import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/allergy_response.dart';
import '../../../domain/models/get_allergies_response.dart';

class AllergiesPresenter {
  AllergiesPresenter(this.authCase);
  final AuthCases authCase;

  Future<AllergyResponse> allergyUserModel({
    required List<Map<String, dynamic>> map,
  }) async =>
      authCase.allergyUserModel(
        map: map,
      );

  Future<GetAllergiesResponse> getAllergy({
    bool isLoading = false,
  }) =>
      authCase.getAllergies(
        isLoading: isLoading,
      );
}
