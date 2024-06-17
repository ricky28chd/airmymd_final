// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:airmymd/app/app.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

class AddNewCardController extends GetxController {
  AddNewCardController(this._addNewCardPresenter);
  final AddNewCardPresenter _addNewCardPresenter;

  var navigateFrom = Get.arguments['navigateFrom'];

  ///This is the controller which validates the card number and return it types=
  CreditCardValidator ccValidator = CreditCardValidator();

  ///Variable will carry the card number of user
  var cardNumberController = TextEditingController();

  ///variable will empty if the card number will be valid
  var cardNumberError = ''.obs;

  var cardImage = AppImages.otherCard;

  enterCardNumber(String value) {
    if (value.isNotEmpty) {
      if (ccValidator.validateCCNum(value).isPotentiallyValid) {
        cardType = ccValidator.validateCCNum(cardNumberController.text);
        getFinalCardType();
        if (finalCardType == 'visa') {
          cardImage = AppImages.visaCard;
        } else if (finalCardType == 'mastercard') {
          cardImage = AppImages.masterCard;
        } else if (finalCardType == 'maestro') {
          cardImage = AppImages.maestroCard;
        } else if (finalCardType == 'dinersclub') {
          cardImage = AppImages.dinnersCard;
        } else if (finalCardType == 'amex') {
          cardImage = AppImages.americanCard;
        } else if (finalCardType == 'discover') {
          cardImage = AppImages.discoverCard;
        } else if (finalCardType == 'jcb') {
          cardImage = AppImages.jcbCard;
        } else if (finalCardType == 'unionpay') {
          cardImage = AppImages.otherCard;
        } else if (finalCardType == 'mir') {
          cardImage = AppImages.otherCard;
        } else if (finalCardType == 'elo') {
          cardImage = AppImages.otherCard;
        } else if (finalCardType == 'hipercard') {
          cardImage = AppImages.otherCard;
        } else {
          cardImage = AppImages.otherCard;
        }
        cardNumberError.value = '';
      } else {
        cardNumberError.value = 'Invalid card number';
      }
    } else {
      cardImage = AppImages.otherCard;
      cardNumberError.value = 'This field can\'t be empty';
    }
    update();
  }

  ///Variable will carry the exp date of the card of the user
  var expController = TextEditingController();

  ///variable will empty if the exp date will be valid
  var expError = ''.obs;

  void enterExp(String value) {
    if (value.isNotEmpty) {
      if (ccValidator.validateExpDate(expController.text).isValid) {
        expError.value = '';
      } else {
        expError.value = 'Invalid date';
      }
    } else {
      expError.value = 'This field can\'t be empty';
    }
  }

  ///Variable will carry the exp month of the card of the user
  var expMonth = 0;

  ///Variable will carry the exp year of the card of the user
  var expYear = 0;

  ///Variable will carry the cvv of the card of the user
  var cvvController = TextEditingController();

  var cvvError = ''.obs;

  void enterCvv(String value) {
    if (value.isNotEmpty) {
      if (ccValidator
          .validateCVV(cvvController.text, cardType.ccType)
          .isValid) {
        cvvError.value = '';
      } else {
        cvvError.value = 'Invalid cvv';
      }
    } else {
      cvvError.value = 'This field can\'t be empty';
    }
  }

  ///Variable will carry the card type.
  var cardType;

  ///method to split the exp date.
  getMonthYear() {
    if (expController.text.contains(RegExp(r'(/)'))) {
      var split = expController.text.split(RegExp(r'(/)'));
      expMonth = int.parse(split[0]);
      expYear = int.parse(split[1]);
    }
  }

  var finalCardType = '';

  getFinalCardType() {
    try{
    var item = cardType.ccType.toString();
    var finalItem = item.split('.');
    finalCardType = finalItem[1];
    } catch(e){
      print('what is the exception $e');
    }
  }

  ///Add new card===============================================================

  // validateCreditCardInfo() {
  // var ccNumResults = ccValidator.validateCCNum(numberController.text);
  // var expDateResults = ccValidator.validateExpDate(expController.text);
  // var cvvResults = ccValidator.validateCVV(cvvController.text, ccNumResults.ccType);
  //
  //
  // if(ccNumResults.isPotentiallyValid) {
  //
  // }
  // }

  Future<void> addNewCard() async {
    if (ccValidator
            .validateCCNum(cardNumberController.text)
            .isPotentiallyValid &&
        cardNumberController.text.isNotEmpty) {
      if (ccValidator.validateExpDate(expController.text).isValid &&
          expController.text.isNotEmpty) {
        if (ccValidator
                .validateCVV(cvvController.text,
                    ccValidator.validateCCNum(cardNumberController.text).ccType)
                .isValid &&
            cvvController.text.isNotEmpty) {
          getMonthYear();
          getFinalCardType();
          var response = await _addNewCardPresenter.saveCardDetails(
            cardNumber: cardNumberController.text,
            cardName: finalCardType,
            expMonth: expMonth.toString(),
            expYear: expYear.toString(),
            cardCvv: cvvController.text,
            isLoading: true,
          );
          if (response.data != null) {
            if (navigateFrom == 'payment') {
              Get.find<PaymentController>().getAllCards();
            } else {
              Get.find<PaymentCardListController>().getAllCards();
            }
            Get.back();
          }
        } else {
          if (cvvController.text.isEmpty) {
            cvvError.value = 'Please fill Cvv here';
          } else {
            cvvError.value = 'Invalid Cvv';
          }
        }
      } else {
        if (expController.text.isEmpty) {
          expError.value = 'Please fill expiration date here';
        } else {
          expError.value = 'Invalid expiration date';
        }
      }
    } else {
      if (cardNumberController.text.isEmpty) {
        cardNumberError.value = 'Please fill Card number here';
      } else {
        cardNumberError.value = 'Invalid card number';
      }
    }
  }
}
