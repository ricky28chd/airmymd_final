import 'package:airmymd/app/app.dart';

Widget loginField() {
  return GetBuilder<LoginController>(builder: (controller) {
    return Padding(
        padding: AppPadding.outerScreenPadding,
        child: Obx(() => GlobalTextField().withIcon(
              image: AppImages.emailIcon,
              hintText: 'name@email.com',
              controller: controller.emailController,
              onChanged: controller.enterEmail,
              errorText: controller.emailError.value == ''
                  ? null
                  : controller.emailError.value,
            )));
  });
}


Widget passwordField() {
  return GetBuilder<LoginController>(builder: (controller) {
    return Padding(
        padding: AppPadding.outerScreenPadding,
        child: Obx(() => GlobalTextField().withoutIcon(
              hintText: 'Password',
              controller: controller.passwordController,
              onChanged: controller.enterPassword,
              errorText: controller.passwordError.value == ''
                  ? null
                  : controller.passwordError.value,
            )));
  });
}