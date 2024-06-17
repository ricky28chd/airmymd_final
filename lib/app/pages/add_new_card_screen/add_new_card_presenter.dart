import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/save_card_response.dart';

class AddNewCardPresenter{
  AddNewCardPresenter(this.authCases);
  final AuthCases authCases;

  Future<SaveCardResponse> saveCardDetails({
    required String cardNumber,
    required String cardName,
    required String expMonth,
    required String expYear,
    required String cardCvv,
    bool isLoading = false,
  }) async =>
      authCases.saveCardDetails(
        cardNumber: cardNumber,
        cardName: cardName,
        expMonth: expMonth,
        expYear: expYear,
        cardCvv: cardCvv,
        isLoading: isLoading,
      );
}