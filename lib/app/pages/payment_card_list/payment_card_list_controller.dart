import 'package:airmymd/app/app.dart';

import '../../../domain/entities/enums.dart';
import '../../../domain/models/get_card_list_response.dart';

class PaymentCardListController extends GetxController {
  PaymentCardListController(this._paymentCardListPresenter);
  final PaymentCardListPresenter _paymentCardListPresenter;

  List<Datum> allPaymentCards = [];

  var cardListError = '';

  Future<void> getAllCards() async {
    try {
      allPaymentCards.clear();
      var response = await _paymentCardListPresenter.getAllCards(
        isLoading: true,
      );
      if (response.data != null) {
        if (response.data!.isEmpty) {
          cardListError = 'Looks like you haven’t added any card yet.';
        } else {
          allPaymentCards = response.data!;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  Future<void> deleteCard({
    required String cardId,
  }) async {
    Utility.closeSnackBar();
    Utility.closeDialog();
    Utility.closeLoader();
    var response = await _paymentCardListPresenter.deleteCard(
      cardId: cardId,
      isLoading: true,
    );
    if (response.data != null) {
      await getAllCards();
      Utility.showMessage(
        'Card deleted successfully',
        MessageType.information,
        () => Utility.closeSnackBar(),
        'Okay',
      );
    }
  }

  @override
  void onInit() {
    getAllCards();
    super.onInit();
  }
}
