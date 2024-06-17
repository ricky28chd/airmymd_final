import 'package:airmymd/app/app.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_registerLogo(), _bottomFormField(context)],
        ),
      ),
    );
  }
}

Widget _registerLogo() {
  return Container(
    height: Get.height / 2.4,
    alignment: Alignment.center,
    child: Image.asset(
      AppImages.logo,
      height: Get.height * 0.15,
    ),
  );
}

Widget _bottomFormField(BuildContext context) {
  return Expanded(
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            PageConstants.kRegister,
            style: AppTextStyle.authenticationHeading,
          ),
          AppSizeBox.height_1,
          const Text(
            PageConstants.kFillTheInformationToJoinUs,
            style: AppTextStyle.authenticationSubHeading,
          ),
          AppSizeBox.height_3,
          
          registerField(context),
          AppSizeBox.height_3,
          registerFormButton(context),
        ],
      ),
    ),
  );
}
