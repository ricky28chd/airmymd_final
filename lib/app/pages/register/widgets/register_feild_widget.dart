import 'package:airmymd/app/app.dart';
import 'package:country_picker/country_picker.dart';

Widget registerField(BuildContext context) {
  return GetBuilder<RegisterController>(builder: (controller) {
    return Padding(
      padding: AppPadding.outerScreenPadding,
      child: Column(
        children: [
          Obx(() => GlobalTextField().withIcon(
              controller: controller.emailController,
              image: AppImages.emailIcon,
              errorText: controller.emailError.value == ''
                  ? null
                  : controller.emailError.value,
              hintText: 'name@email.com',
              onChanged: controller.enterEmail)),
          Row(
            children: [
              Obx(
                () => Expanded(
                  flex: 4,
                  child: GlobalTextField().withoutIcon(
                      controller: controller.phoneNumberController,
                      errorText: controller.phoneNumberError.value == ''
                          ? null
                          : controller.phoneNumberError.value,
                      hintText: 'Phone Number',
                      onChanged: controller.enterPhoneNumber),
                ),
              )
            ],
          ),
          //  Row(
          //   children: [
          //     Obx(
          //       () => Expanded(
          //         flex: 4,
          //         child: GlobalTextField().withoutIcon(
          //             controller: controller.passwordController,
          //             errorText: controller.passwordError.value == ''
          //                 ? null
          //                 : controller.passwordError.value,
          //             hintText: 'Password',
          //             onChanged: controller.enterPhoneNumber),
          //       ),
          //     ),
          //   ],
          // ),
           
        ],
      ),
    );
  });
}
