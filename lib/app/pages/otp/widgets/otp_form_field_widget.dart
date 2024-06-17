import 'package:airmymd/app/app.dart';

Widget otpField() {
  return GetBuilder<OtpController>(builder: (controller) {
    return Padding(
      padding: AppPadding.outerScreenPadding,
      child: Column(
        children: [
          Obx(() => GlobalTextField().withIcon(
                //image: AppImages.phoneIcon,
                keyBoardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                hintText: 'Verification code',
                onChanged: controller.enterOtp,
                controller: controller.otpController,
                errorText: controller.otpError.value == ''
                    ? null
                    : controller.otpError.value,
              )),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed:
                      controller.navigatedFrom[0] == 'navigateFromRegister'
                          ? controller.onRegisterResendButtonClicked
                          : controller.onLoginResendButtonClicked,
                  child: const Text(
                    'Resend',
                    style: TextStyles.extraBoldBlue13,
                  )))
        ],
      ),
    );
  });
}
