import 'package:airmymd/app/app.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Forgot Password',
            style: AppTextStyle.appBarHeading,
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: AppPadding.outerScreenPadding,
            child: Column(
              children: [
                AppSizeBox.height_5,
                Obx(() => GlobalTextField().withIcon(
                      image: AppImages.emailIcon,
                      hintText: 'Email',
                      controller: controller.forgotEmailController,
                      onChanged: controller.enterForgotEmail,
                      errorText: controller.forgotEmailError.value == ''
                          ? null
                          : controller.forgotEmailError.value,
                    )),
                AppSizeBox.height_5,
                GlobalButtons().primaryButton(
                  text: 'Submit',
                  onTap: () {
                    controller.onSendOtpButtonClicked();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
