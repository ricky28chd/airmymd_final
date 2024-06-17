import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/register/register_presenter.dart';
import 'dart:async';
import 'package:airmymd/domain/domain.dart';
import 'package:url_launcher/url_launcher.dart';

///This is the controller page where we define all the methods for ui page,
///It will separate our logics from view page
///controllers are defined here, validations are applied and at the end [onContinueButtonClicked] method
///will do all the rest work like api hit.

class RegisterController extends GetxController {
  RegisterController(this._registerPresenter);
  final RegisterPresenter _registerPresenter;

  ///Variable stores email of user.
  var emailController = TextEditingController();

  ///Variable stores phone number of user.
  var phoneNumberController = TextEditingController();

  var passwordController = TextEditingController();
  

  ///Variable stores phone number of user.
  var countryCodeController = TextEditingController();

  ///Email======================================================================

  ///[emailError] will null if [emailController] is valid.
  /// [emailError.value] text will shown when the user try to pass empty value in field.
  /// [debugPrint] to print step by step.
  var emailError = ''.obs;
  var passwordError = ''.obs;


  ///Method to validate email of user.
  void enterEmail(String value) {
    if (value.isNotEmpty) {
      emailError.value = '';
    } else {
      emailError.value = "Email can't be empty";
    }

    debugPrint('email ${emailController.text}');
  }

void enterPassword(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      passwordError.value = 'Password can\'t be empty';
    } else if(value.length < 8){
      passwordError.value = 'Password must be greater than 8 characters';
    }
    else {
      passwordError.value = '';
    }
    debugPrint(passwordController.text);
  }

  ///phoneNumber================================================================

  ///[phoneNumberError] will null if [phoneNumberController] is valid.
  ///  /// [emailError.value] text will shown when the user try to pass empty value in field.
  ///   [debugPrint] to print step by step.
  var phoneNumberError = ''.obs;

  ///Method to validate phoneNumber of user.
  void enterPhoneNumber(String value) {
    if (value.isNotEmpty) {
      phoneNumberError.value = '';
    } else {
      phoneNumberError.value = "Phone number can't be empty";
    }
    debugPrint('phoneNumber ${phoneNumberController.text}');
  }

  // ///countryCode================================================================

  // ///[countryCodeError] will null if [countryCodeController] is valid.
  // ///  /// [countryCodeError.value] text will shown when the user try to pass empty value in field.
  // ///   [debugPrint] to print step by step.
  // var countryCodeError = ''.obs;

  // ///Method to validate phoneNumber of user.
  // void enterCountryCode(String value) {
  //   if (value.isNotEmpty) {
  //     countryCodeError.value = '';
  //   } else {
  //     countryCodeError.value = "Required";
  //   }
  //   debugPrint('countryCode ${countryCodeController.text}');
  // }

  ///Method will gonna reset all the values.
  void resetAllValues() {
    emailController.clear();
    phoneNumberController.clear();
    countryCodeController.clear();
    passwordController.clear();
    update();
  }

  ///on clicking the continue button api will gonna hit with both the data email
  /// and phone number,
  ///If the data will not null it will navigate to the another page, else it
  ///will show the error message
  ///coming from message parameter in api return.
  ///That response error will check and display on [Repository] class.....for
  ///server error message go to [Repository]page.

  Future<void> onContinueButtonClicked() async {
    if (emailController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty ) {
      var response = await _registerPresenter.signUpUserModel(
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        password: passwordController.text
      );
      if (response.data != null) {
        NavigateTo.goToOtpScreen(routeFrom: [
          'navigateFromRegister',
          response.data.code,
          emailController.text,
          phoneNumberController.text,
          passwordController.text,
        ]);
        Utility.showMessage(
            'Otp has been sent successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay');
        resetAllValues();
      }
    } else {
      emailController.text.isEmpty
          ? emailError.value = 'Enter your email'
          : null;
      phoneNumberController.text.isEmpty
          ? phoneNumberError.value = 'Enter your phone number'
          : null;
          // passwordController.text.isEmpty
          // ? passwordError.value = 'Enter your password'
          // : null;
    }
  }

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
