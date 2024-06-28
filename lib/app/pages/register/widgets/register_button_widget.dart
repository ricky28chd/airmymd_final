import 'package:airmymd/app/app.dart';
import 'package:airmymd/web_view_page.dart';

///This is the button for login page and the bottom content of login page.
Widget registerFormButton(context) {
  return GetBuilder<RegisterController>(builder: (controller) {
    return Column(
      children: [
        GlobalButtons().primaryButton(
            text: PageConstants.kContinue,
            onTap: () {
              Utility.closeDialog();
              Utility.closeLoader();
              Utility.closeSnackBar();
              controller.onContinueButtonClicked();
            }),
        AppSizeBox.height_2,
        Wrap(
          direction: Axis.horizontal,
          children: [
            const Text(
              PageConstants.kAlreadyJoined,
              style: AppTextStyle.authenticationPlain,
            ),
            GestureDetector(
              onTap: () {
                NavigateTo.goToLoginScreen();
              },
              child: const Text(
                PageConstants.kLogin,
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
                  text: PageConstants.kByRegisterYouAcceptOur,
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
