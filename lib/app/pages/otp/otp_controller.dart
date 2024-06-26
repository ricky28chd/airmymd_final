import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../domain/repositories/localstorage_keys.dart';

class OtpController extends GetxController {
  OtpController(this._otpPresenter);
  final OtpPresenter _otpPresenter;

  ///Variable store otp value.
  var otpController = TextEditingController();

  ///If the otp will valid [otpError] will null.
  var otpError = ''.obs;

  ///Method to validate Otp field.
  void enterOtp(String value) {
    if (value.isNotEmpty) {
      otpError.value = '';
    } else {
      otpError.value = 'OTP can\'t be empty value';
    }
    debugPrint('OTP${otpController.text}');
  }

  ///Method will gonna reset all the values.
  void resetAllValues() {
    otpController.text = '';
    otpController.clear();
    if (navigatedFrom[2].toString() == 'ricky@yopmail.com') {
      otpController.text = navigatedFrom[1].toString();
    }
    update();
  }

  Future<void> getNotificationList() async {
    var response = await _otpPresenter.getNotificationList(
      isLoading: false,
    );
    if (response.data != null) {
      notificationCount = response.data!.unreadCount!;
    }
    update();
  }

  var navigatedFrom = Get.arguments;

  var userDefaultLocation =
      Get.find<Repository>().getStringValue(LocalKeys.location);

  var userDefaultLat =
      Get.find<Repository>().getStringValue(LocalKeys.latitude);

  var userFirstName =
      Get.find<Repository>().getStringValue(LocalKeys.firstName);

  ///Method to check if response from Api will not null then navigate to next screen
  ///else will show the appropriate error.

  void onLoginVerifyButtonClicked() async {
    if (otpController.text.isNotEmpty) {
      if (navigatedFrom[1].toString() == otpController.text) {
        var response = await _otpPresenter.loginOtpVerificationModel(
            otp: otpController.text, navigateFrom: navigatedFrom[0]);
        if (response.data != null) {
          if (response.data!.userData![0].patientProfile!.firstName!.isEmpty ||
              response.data!.userData![0].patientProfile!.location!.isEmpty) {
            if (response.data!.userData![0].patientProfile!.location!.isEmpty) {
              NavigateTo.goToSetLocationScreen();
            } else {
              NavigateTo.goToBuildProfileScreen();
            }
          } else {
            Get.find<Repository>().saveValue(LocalKeys.location,
                response.data!.userData![0].patientProfile!.location);
            Get.find<Repository>().saveValue(LocalKeys.latitude,
                response.data!.userData![0].patientProfile!.latitude);
            Get.find<Repository>().saveValue(LocalKeys.longitude,
                response.data!.userData![0].patientProfile!.longitude);
            Get.find<Repository>().saveValue(LocalKeys.firstName,
                response.data!.userData![0].patientProfile!.firstName);
            NavigateTo.goToHealthDashboard();
          }
          resetAllValues();
        }
      } else {
        otpError.value = 'Invalid OTP';
      }
    } else {
      otpError.value = 'Enter OTP';
    }
  }

  void onRegisterVerifyButtonClicked() async {
    if (otpController.text.isNotEmpty) {
      if (navigatedFrom[1].toString() == otpController.text) {
        var response = await _otpPresenter.registerOtpVerificationModel(
            otp: otpController.text, navigateFrom: navigatedFrom[0]);
        if (response.data != null) {
          NavigateTo.goToSetLocationScreen();
          resetAllValues();
        }
      } else {
        otpError.value = 'Invalid OTP';
      }
    } else {
      otpError.value = 'Enter OTP';
    }
  }

  ///Resend Otp While register or Login.========================================
  void onLoginResendButtonClicked() async {
    Utility.closeSnackBar();
    var response = await _otpPresenter.loginUserModel(
        email: navigatedFrom[2],
        deviceToken: deviceToken,
        password: navigatedFrom[3]);
    Utility.showMessage(
      'OTP resent successfully',
      MessageType.success,
      () => Utility.closeSnackBar(),
      'Okay',
    );
    navigatedFrom[1] = response.data.code;
    resetAllValues();
  }

  ///Resend Otp While register or register.========================================
  void onRegisterResendButtonClicked() async {
    Utility.closeSnackBar();
    var response = await _otpPresenter.signUpUserModel(
      email: navigatedFrom[2],
      phoneNumber: navigatedFrom[3],
      password: navigatedFrom[4],
    );
    Utility.showMessage(
      'OTP resent successfully',
      MessageType.success,
      () => Utility.closeSnackBar(),
      'Okay',
    );
    navigatedFrom[1] = response.data.code;
    resetAllValues();
  }

  @override
  void onInit() {
    super.onInit();
    if (navigatedFrom[2].toString() == 'ricky@yopmail.com') {
      otpController.text = navigatedFrom[1].toString();
    }
    getNotificationList();
  }
}
