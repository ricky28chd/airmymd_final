import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/get_cigarette_response.dart';
import '../../../domain/models/save_tobacco_response.dart';

class TobaccoPresenter {
  TobaccoPresenter(this.authCases);
  final AuthCases authCases;

  Future<SaveTobaccoCard> saveTobacco({
    required Map<String, dynamic> cigarette,
    required String tobacco,
    bool isLoading = false,
  }) async =>
      authCases.saveTobacco(
        cigarette: cigarette,
        tobacco: tobacco,
        isLoading: isLoading,
      );

  Future<GetCigaretteResponse> getCigarette({
    bool isLoading = false,
  }) async =>
      authCases.getCigarette(
        isLoading: isLoading,
      );
}
