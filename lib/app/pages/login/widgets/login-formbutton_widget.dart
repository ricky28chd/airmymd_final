import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/login/widgets/forgot_password.dart';
import 'package:airmymd/web_view_page.dart';

///This is the button for login page and the bottom content of login page.
Widget loginFormButton(BuildContext context) {
  return GetBuilder<LoginController>(builder: (controller) {
    return Column(
      children: [
        GlobalButtons().primaryButton(
          text: PageConstants.kContinue,
          onTap: () {
            Utility.closeDialog();
            Utility.closeLoader();
            Utility.closeSnackBar();
            controller.onContinueButtonClicked();
          },
        ),
        AppSizeBox.height_1,
        // GestureDetector(
        //   onTap: () {
        //     Get.to(const ForgotPasswordScreen());
        //   },
        //   child: const Text(PageConstants.kforgotPassword,
        //        style: TextStyles.extraBoldBlue13,),
        // ),
        AppSizeBox.height_1,
        Wrap(
          direction: Axis.horizontal,
          children: [
            const Text(
              PageConstants.knewToAirMyMd,
              style: AppTextStyle.authenticationPlain,
            ),
            GestureDetector(
              onTap: () {
                NavigateTo.goToRegisterScreen();
              },
              child: const Text(
                PageConstants.kRegister,
                style: TextStyles.extraBoldBlue13,
              ),
            ),
          ],
        ),
        AppSizeBox.height_5,
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AirmymdWebViewWidget(
                          url: 'https://dev.airmymd.com/terms',
                        )));
          },
          child: RichText(
              text: const TextSpan(
                  text: PageConstants.kByLoginYouAcceptOur,
                  style: AppTextStyle.authenticationPlain,
                  children: <TextSpan>[
                TextSpan(
                    text: PageConstants.kTAndD,
                    style: AppTextStyle.authenticationBold)
              ])),
        ),
        AppSizeBox.height_5,
      ],
    );
  });
}
