import 'package:airmymd/app/app.dart';
import 'package:get/get.dart';
import 'app_pages.dart';

///These function are used to navigate pages.
abstract class NavigateTo {
  ///This function will navigate to walkThrough Screen.
  static void goToWalkThroughScreen() {
    Get.offAllNamed(Routes.walkthrough);
  }

  ///This function will navigate to Login Screen.
  static void goToLoginScreen() {
    Get.offAllNamed(Routes.login);
  }

  ///This function will navigate to Otp Verification Screen.
  static void goToOtpScreen({required dynamic routeFrom}) {
    Get.toNamed(Routes.otp, arguments: routeFrom);
  }

  ///This function will navigate to Register Screen.
  static void goToRegisterScreen() {
    Get.toNamed(Routes.register);
  }

  ///This function will navigate to set location Screen.
  static void goToSetLocationScreen({String? navigateFrom}) {
    Get.offNamed(Routes.setLocation, arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to User profile Screen.
  static void goToBuildProfileScreen({String? navigateFrom}) {
    Get.toNamed(Routes.buildProfile, arguments: {
      'NavigateFrom': navigateFrom,
    });
  }

  ///This function will navigate to User profile Screen.
  static void goToOffNamedBuildProfileScreen({String? navigateFrom}) {
    Get.offNamed(Routes.buildProfile,
        arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to the multiple choice allergy Screen.
  static void goToAllergiesScreen({
    String? navigateFrom,
  }) {
    Get.toNamed(Routes.allergies, arguments: {
      'NavigateFrom': navigateFrom,
    });
  }

  ///This function will navigate to the medical history Screen.
  static void goToMedicalHistoryScreen({String? navigateFrom}) {
    Get.toNamed(Routes.medicalHistory,
        arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to the medication Screen.
  static void goToMedicationScreen({
    String? navigateFrom,
  }) {
    Get.toNamed(Routes.medication, arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to surgery chosen Screen.
  static void goToSurgeriesScreen({
    String? navigateFrom,
  }) {
    Get.toNamed(Routes.surgeries, arguments: {
      'NavigateFrom': navigateFrom,
    });
  }

  ///This function will navigate sexual health Screen.
  static void goToSexualHealthScreen({String? navigateFrom}) {
    Get.toNamed(Routes.sexualHealth, arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to health habit Screen.
  static void goToHealthHabitsScreen({String? navigateFrom}) {
    Get.toNamed(Routes.healthHabits, arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate general health Screen.
  static void goToGeneralHealthScreen({String? navigateFrom}) {
    Get.toNamed(Routes.generalHealth,
        arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to tobacco chosen Screen.
  static void goToTobaccoScreen({String? navigateFrom}) {
    Get.toNamed(Routes.tobacco, arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to alcohol Screen.
  static void goToAlcoholScreen({String? navigateFrom}) {
    Get.toNamed(Routes.alcohol, arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to drugs Screen.
  static void goToDrugScreen({String? navigateFrom}) {
    Get.toNamed(Routes.drugs, arguments: {'NavigateFrom': navigateFrom});
  }

  ///This function will navigate to add insurance Screen.
  static void goToAddInsuranceScreen({
    String? id,
    String? navigateFrom,
    String? memberId,
    String? groupNumber,
    String? providerName,
    String? image,
  }) {
    Get.toNamed(Routes.addInsurance, arguments: {
      'id': id,
      'navigateFrom': navigateFrom,
      'memberId': memberId,
      'groupNumber': groupNumber,
      'providerName': providerName,
      'image': image,
    });
  }

  ///This function will navigate to map screen where user can find doctor according to location Screen.
  static void goToFindDoctorScreen() {
    Get.offAllNamed(Routes.home);
  }

  ///This function will navigate to a doctor list screen found by user on basis of location.
  static void goToDoctorListScreen() {
    Get.toNamed(Routes.listView);
  }

  ///This function will navigate to set location Screen.
  static void goToDoctorProfileScreen(
      {required String doctorId, required String specialization}) {
    Get.toNamed(Routes.doctorProfile, arguments: {
      'doctorId': doctorId,
      'specialization': specialization,
    });
  }

  ///This function will navigate to set location Screen.
  static void goToGoogleMapScreen({
    required String specialization,
    required String longitude,
    required String latitude,
  }) {
    Get.toNamed(Routes.googleMap, arguments: {
      'specialization': specialization,
      'longitude': longitude,
      'latitude': latitude,
    });
  }

  ///This function will navigate to set location Screen.
  static void goToPaymentScreen({
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String reason,
    required String fees,
  }) {
    Get.toNamed(Routes.payment, arguments: {
      'doctorId': doctorId,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'reason': reason,
      'fees': fees,
    });
  }

  ///This function will navigate to set location Screen.
  static void goToBookAppointmentScreen({
    required int doctorId,
    required String fees,
  }) {
    Get.toNamed(Routes.bookAppointment, arguments: {
      'doctorId': doctorId,
      'fees': fees,
    });
  }

  ///This function will navigate to set location Screen.
  static void goToAppointmentListScreen() {
    Get.toNamed(Routes.appointmentList);
  }

  ///This function will navigate to set location Screen.
  static void goToSearchDialogue() {
    Get.toNamed(Routes.searchDialogue);
  }

  ///This function will navigate to set location Screen.
  static void goToUserSettingScreen() {
    Get.toNamed(Routes.userSetting);
  }

  ///This function will navigate to set location Screen.
  static void goToInsuranceListScreen() {
    Get.toNamed(Routes.insuranceList);
  }

  ///This function will navigate to set location Screen.
  static void goToProfileSettingScreen() {
    Get.toNamed(Routes.profileSetting);
  }

  ///This function will navigate to set location Screen.
  static void goToAllProfileScreen() {
    Get.toNamed(Routes.allProfileScreen);
  }

  ///This function will navigate to all profile screen.
  static void goToallProfilePage() {
    Get.toNamed(Routes.allProfileScreen);
  }

  ///This function will navigate to set location Screen.
  static void goToPaymentCardListScreen() {
    Get.toNamed(Routes.paymentCardList);
  }

  ///This function will navigate to set location Screen.
  static void goToAddNewCardScreen({String? navigateFrom}) {
    Get.toNamed(Routes.addNewCardScreen,
        arguments: {'navigateFrom': navigateFrom});
  }

  ///This function will navigate to set location Screen.
  static void goToChatScreen({
    String? navigateFrom,
    required String userdId,
    required String image,
    required String doctorName,
  }) {
    Get.toNamed(Routes.chatScreen, arguments: {
      'NavigateFrom': navigateFrom,
      'userId': userdId,
      'doctorImage': image,
      'doctorName': doctorName,
    });
  }

  ///This function will navigate to set location Screen.
  static void goToChatListScreen() {
    Get.toNamed(Routes.chatList);
  }

  ///This function will navigate to set location Screen.
  static void goToReviewsListScreen({
    required String doctorId,
  }) {
    Get.toNamed(Routes.reviewsList, arguments: {
      'doctorId': doctorId,
    });
  }

  ///This function will navigate to set location Screen.
  static void goToNotificationListScreen() {
    Get.toNamed(Routes.notificationList);
  }

  ///This function will navigate to support Screen.
  static void goTosupportScreen() {
    Get.toNamed(Routes.support);
  }

  ///This function will navigate to notes Screen.
  static void goToNotesScreen() {
    Get.toNamed(Routes.notes);
  }

  static void goToPrimaryCare() {
    Get.toNamed(Routes.primaryCare);
  }

  static void goToAddVisit() {
    Get.toNamed(Routes.addVisit);
  }

  static void goToVisit() {
    Get.toNamed(Routes.vist);
  }

  static void goToAddDoctor() {
    Get.toNamed(Routes.addDoctor);
  }

  static void goToHealthDashboard() {
    Get.toNamed(Routes.healthDashboard);
  }
}
