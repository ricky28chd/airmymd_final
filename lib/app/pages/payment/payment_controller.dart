// ignore_for_file: depend_on_referenced_packages
import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:intl/intl.dart';
import '../../../domain/models/get_card_list_response.dart' as card;
import 'dart:async';
import '../../../domain/models/get_insurance_list_response.dart'
    as insurance_card;
import '../../../domain/repositories/localstorage_keys.dart';

class PaymentController extends GetxController {
  PaymentController(this._paymentPresenter);
  final PaymentPresenter _paymentPresenter;

  var cardNameController = TextEditingController();

  var doctorFees = Get.arguments['fees'];

  String paymentType = '';

  ///[selectCard]===============================================================

  ///Variable will store card index.
  var selectedCard = [];

  ///Method to select a card from multiple options, In simple means toggle.
  void selectCard(index) {
    selectedInsuranceCard.clear();
    if (selectedCard.isNotEmpty) {
      selectedCard.clear();
      selectedCard.add(index);
    } else {
      selectedCard.add(index);
    }
    update();
  }

  ///[selectInsuranceCard]======================================================

  ///Variable will store insurance card index.
  var selectedInsuranceCard = [];

  ///Method to select a insurance card from multiple options, In simple means toggle.
  void selectInsuranceCard(index) {
    selectedCard.clear();
    if (selectedInsuranceCard.isNotEmpty) {
      selectedInsuranceCard.clear();
      selectedInsuranceCard.add(index);
    } else {
      selectedInsuranceCard.add(index);
    }
    update();
  }

  ///variable will save user first naMe=========================================
  var firstName = Get.find<Repository>().getStringValue(LocalKeys.firstName);

  ///variable will hold the insurance id========================================
  var sourceNumber = '';
  Future<void> bookingWithInsuranceModel() async {
    if (selectedInsuranceCard.isNotEmpty) {
      var doctorId = await Get.arguments['doctorId'];
      var bookingDate = await Get.arguments['bookingDate'];
      var bookingTime = await Get.arguments['bookingTime'];
      var reason = await Get.arguments['reason'];
      var response = await _paymentPresenter.bookingWithInsuranceModel(
        doctorId: doctorId,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        paymentType: paymentType,
        reason: reason,
        sourceId: selectedInsuranceCard.join(',').toString(),
        sourceName: firstName,
        isLoading: true,
      );
      if (response.data != null) {
        confirmationDialogue(
            doctorFirstName: response.data!.doctorFirstname.toString(),
            doctorLastName: response.data!.doctorLastName.toString(),
            bookingDate: DateFormat("yMMMd")
                .format(DateTime.parse(response.data!.bookingDate.toString())),
            bookingTime: response.data!.bookingTime.toString());
      }
    } else {
      Utility.showMessage(
        'Please select payment method first',
        MessageType.information,
        () => Utility.closeSnackBar,
        'Okay',
      );
    }
  }

  Future<void> none() async {
    var doctorId = await Get.arguments['doctorId'];
    var bookingDate = await Get.arguments['bookingDate'];
    var bookingTime = await Get.arguments['bookingTime'];
    var reason = await Get.arguments['reason'];
    var response = await _paymentPresenter.bookingWithInsuranceModel(
      doctorId: doctorId,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      paymentType: 'no_payment',
      reason: reason,
      sourceId: selectedInsuranceCard.join(',').toString(),
      sourceName: firstName,
      isLoading: true,
    );
    if (response.data != null) {
      confirmationDialogue(
          doctorFirstName: response.data!.doctorFirstname.toString(),
          doctorLastName: response.data!.doctorLastName.toString(),
          bookingDate: DateFormat("yMMMd")
              .format(DateTime.parse(response.data!.bookingDate.toString())),
          bookingTime: response.data!.bookingTime.toString());
    }
  }

  Future<void> bookAppointmentWithCard() async {
    if (selectedCard.isNotEmpty && paymentType == 'card') {
      var doctorId = await Get.arguments['doctorId'];
      var bookingDate = await Get.arguments['bookingDate'];
      var bookingTime = await Get.arguments['bookingTime'];
      var reason = await Get.arguments['reason'];
      var response = await _paymentPresenter.bookAppointmentWithCard(
          doctorId: doctorId,
          bookingDate: bookingDate,
          bookingTime: bookingTime,
          paymentType: paymentType,
          reason: reason,
          cardToken: selectedCard.join(','),
          isLoading: true);
      if (response.data != null) {
        confirmationDialogue(
            doctorFirstName: response.data!.doctorFirstname.toString(),
            doctorLastName: response.data!.doctorLastName.toString(),
            bookingDate: DateFormat("yMMMd")
                .format(DateTime.parse(response.data!.bookingDate.toString())),
            bookingTime: response.data!.bookingTime.toString());
      }
    } else {
      Utility.showMessage(
        'Please select payment method first',
        MessageType.information,
        () => Utility.closeSnackBar,
        'Okay',
      );
    }
  }

  List<insurance_card.Datum> allInsuranceList = [];

  Future<void> getInsuranceList() async {
    try {
      var response = await _paymentPresenter.getInsuranceList(
        isLoading: true,
      );
      if (response.data != null) {
        allInsuranceList = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  List<card.Datum> allCardList = [];

  Future<void> getAllCards() async {
    try {
      allCardList.clear();
      var response = await _paymentPresenter.getAllCards(
        isLoading: true,
      );
      if (response.data != null) {
        allCardList = response.data!;
      }
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  @override
  void onInit() {
    getInsuranceList();
    getAllCards();
    super.onInit();
  }
}
