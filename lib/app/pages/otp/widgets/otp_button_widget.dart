import 'package:airmymd/app/app.dart';

///This is the button for login page and the bottom content of login page.
Widget otpFormButton() {
  return GetBuilder<OtpController>(builder: (controller) {
    return Column(
      children: [
        GlobalButtons().primaryButton(
            text: PageConstants.kVerify,
            onTap: () {
              Utility.closeDialog();
              Utility.closeLoader();
              Utility.closeSnackBar();

              controller.navigatedFrom[0] == 'navigateFromRegister'
                  ? controller.onRegisterVerifyButtonClicked()
                  : controller.onLoginVerifyButtonClicked();
            }),
        AppSizeBox.height_8,
      ],
    );
  });
}
