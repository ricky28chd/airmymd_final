import 'package:airmymd/app/app.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics:PageScrollPhysics(),
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_loginLogo(), _bottomFormField(context)],
        ),
      ),
    );
  }
}

Widget _loginLogo() {
  return Container(
    height: Get.height / 2.4,
    alignment: Alignment.center,
    child: Image.asset(
      AppImages.logo,
      height: Get.height * 0.15,
    ),
  );
}

Widget _bottomFormField(context) {
  return Expanded(
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            PageConstants.kLogin,
            style: AppTextStyle.authenticationHeading,
          ),
          const Text(
            PageConstants.kLetsGetStarted,
            style: AppTextStyle.authenticationSubHeading,
          ),
          AppSizeBox.height_7,
          loginField(),
          // AppSizeBox.height_1,
          // passwordField(),
          AppSizeBox.height_7,
          loginFormButton(context),
        ],
      ),
    ),
  );
}
