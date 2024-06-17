import 'package:airmymd/app/app.dart';

///This is the button for login page and the bottom content of login page.
Widget setLocationFormButton() {
  return GetBuilder<SetLocationController>(builder: (controller) {
    return Column(
      children: [
        GlobalButtons().primaryButton(
            text: PageConstants.kContinue,
            onTap: controller.onContinueButtonClicked),
        AppSizeBox.height_8,
      ],
    );
  });
}
