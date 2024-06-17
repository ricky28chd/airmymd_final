import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/delete_card_response.dart';
import '../../../domain/models/get_card_list_response.dart';

class PaymentCardListPresenter {
  PaymentCardListPresenter(this.authCases);
  final AuthCases authCases;

  Future<GetCardListResponse> getAllCards({
    bool isLoading = false,
  }) async =>
      authCases.getAllCards(
        isLoading: isLoading,
      );

  Future<DeleteBankCardResponse> deleteCard({
    required String cardId,
    bool isLoading = false,
  }) async =>
      authCases.deleteBankCard(
        cardId: cardId,
        isLoading:isLoading,
      );
}
