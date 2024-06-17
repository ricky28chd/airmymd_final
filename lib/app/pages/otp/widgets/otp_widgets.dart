import 'package:airmymd/app/app.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [otpLogo(), bottomFormField()],
        ),
      ),
    );
  }
}

Widget otpLogo() {
  return Expanded(
    child: Container(
      height: Get.height / 2,
      alignment: Alignment.center,
      child: Image.asset(
        AppImages.logo,
        height: Get.height * 0.15,
      ),
    ),
  );
}

Widget bottomFormField() {
  return Expanded(
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            PageConstants.kVerificationCode,
            style: AppTextStyle.authenticationHeading,
          ),
          AppSizeBox.height_1,
          const Text(
            PageConstants.kWeHaveSentTheCodeToYourMobileAndEmail,
            style: AppTextStyle.authenticationSubHeading,
          ),
          const Spacer(),
          otpField(),
          const Spacer(),
          otpFormButton(),
        ],
      ),
    ),
  );
}
