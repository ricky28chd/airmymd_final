import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/alcohol_response.dart';

class AlcoholPresenter {
  AlcoholPresenter(this.authCases);
  final AuthCases authCases;

  Future<AlcoholResponse> alcoholUserModel({
    required String drinkAlcohol,
    required String howMany,
    required String inADay,
    required String cutDown,
    required String feltGuilty,
    required String morningDrink,
  }) async =>
      authCases.alcoholUserModel(
        drinkAlcohol: drinkAlcohol,
        howMany: howMany,
        inADay: inADay,
        cutDown: cutDown,
        feltGuilty: feltGuilty,
        morningDrink: morningDrink,
      );
}
