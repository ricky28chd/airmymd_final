import 'package:airmymd/app/app.dart';
import 'package:airmymd/data/data.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  LoginController(this._loginPresenter);
  final LoginPresenter _loginPresenter;

  ///Variable will save user email.
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  ///[emailError] will null if email will valid.
  var emailError = ''.obs;
  var passwordError = ''.obs;

  var forgotEmailController = TextEditingController();
  var otpController = TextEditingController();

  ///[emailError] will null if email will valid.
  // var emailError = ''.obs;
  var forgotEmailError = ''.obs;
  var otpError = ''.obs;

  ///Method to validate email.
  void enterEmail(String value) {
    if (value.isNotEmpty) {
      forgotEmailError.value = '';
    } else {
      forgotEmailError.value = 'Email can\'t be empty';
    }
    debugPrint(emailController.text);
  }

  void enterPassword(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      passwordError.value = 'Password can\'t be empty';
    } else if (value.length < 8) {
      passwordError.value = 'Password must be greater than 8 characters';
    } else {
      passwordError.value = '';
    }
    debugPrint(passwordController.text);
  }

  void enterForgotEmail(String value) {
    if (value.isNotEmpty) {
      emailError.value = '';
    } else {
      emailError.value = 'Email can\'t be empty ';
    }
    debugPrint(forgotEmailController.text);
  }

  void enterOtp(String value) {
    if (value.isNotEmpty) {
      otpError.value = '';
    } else {
      otpError.value = 'Enter your otp ';
    }
    debugPrint(otpController.text);
  }

  void onSendOtpButtonClicked() async {
    if (forgotEmailController.text.isEmpty) {
      forgotEmailError.value = 'Enter your email';
    } else {
      Utility.closeDialog();
      Utility.closeLoader();
      Utility.closeSnackBar();
      var data = {
        'email': forgotEmailController.text,
      };
      var responseData = await ApiWrapper().makeRequest(
        'send-password-otp',
        Request.post,
        data,
        true,
        {"Content-Type": "application/json"},
      );

      if (responseData.hasError) {
        Utility.showInfoDialog(responseData, false);
      } else {
        NavigateTo.goToLoginScreen();
        Utility.showMessage('Link has been sent successfully',
            MessageType.success, () => Utility.closeSnackBar(), 'Okay');
      }
    }
  }

  void onEnterOtpButtonClicked() {
    if (otpController.text.isEmpty) {
      otpError.value = 'Enter otp';
    }
  }

  ///Reset all values.
  void resetAllValues() {
    emailController.clear();
    passwordController.clear();
    update();
  }

  ///Method which interacts to the login Api.
  ///Passes the data to the authorises.

  Future<void> onContinueButtonClicked() async {
    if (emailController.text.isNotEmpty) {
      var response = await _loginPresenter.loginUserModel(
        email: emailController.text,
        deviceToken: deviceToken,
        password: passwordController.text,
      );
      if (response.data != null) {
        NavigateTo.goToOtpScreen(routeFrom: [
          'navigateFromLogin',
          response.data.code,
          emailController.text,
          '123',
        ]);
        Utility.showMessage('Otp has been sent successfully',
            MessageType.success, () => Utility.closeSnackBar(), 'Okay');
        resetAllValues();
      }
    } else {
      emailError.value = emailController.text.isEmpty ? 'Enter your email' : "";
      // passwordError.value = passwordController.text.isEmpty ? 'Enter your password' : "";
    }
  }

  validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      Get.defaultDialog(title: '!Invalid');
    } else {}
  }

  var firstName = Get.find<Repository>().getStringValue(LocalKeys.firstName);
  var authToken = Get.find<Repository>().getSecureValue(LocalKeys.authToken);

  navigateToUrl({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
