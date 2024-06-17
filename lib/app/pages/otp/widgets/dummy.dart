import 'dart:convert';

import '../../../../device/repositories/device_repositories.dart';
import '../../../../domain/repositories/localstorage_keys.dart';
import '../../../../main.dart';
import '../../../app.dart';
import 'package:http/http.dart' as http;

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

Widget bottomFormField2() {
  return GetBuilder<BuildProfileController>(builder: (controller) {
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
            Text(
              '${box.get('emailCMesage')}',
              style: AppTextStyle.authenticationSubHeading,
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Obx(
                  () => GlobalTextField().withLabel(
                    hintText: 'OTP',
                    label: 'OTP',
                    onChanged: (value) {},
                    errorText: controller.otpError.value == ''
                        ? null
                        : controller.otpError.value,
                    controller: controller.otpController,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    Utility.showLoader();
                    try {
                      var headers = {
                        'Authorization':
                            'Bearer ${Get.find<DeviceRepository>().getStringValue(LocalKeys.authToken)}',
                        'Content-Type': 'application/json'
                      };
                      var request = await http.post(
                          Uri.parse('https://dev.airmymd.com/api/send-otp'),
                          body: json.encode({
                            "email": controller.emailController.text,
                            "phone": controller.phoneController.text,
                          }),
                          headers: headers);
                      var response = json.decode(request.body);
                      print(response);
                      if (response['returnCode'] == 1) {
                        box.put('otp', response['data']['otp_number']);
                        Utility.closeLoader();
                        box.put('emailCMesage', response['returnMessage']);
                        Get.rawSnackbar(
                            messageText: Text(
                              response['returnMessage'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: AppColors.primaryColor,
                            margin: const EdgeInsets.all(15.0),
                            borderRadius: 15,
                            snackStyle: SnackStyle.FLOATING,
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    } catch (e) {
                      Utility.closeDialog();
                    }
                  },
                  child: const Text(
                    'Resend',
                    style: AppTextStyle.authenticationBold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
                onTap: () {
                  print('djkdjdj');
                  if (box.get('otp').toString() ==
                      controller.otpController.text) {
                    print('djkdjdj23');
                    controller.onSaveButtonClicked();
                  } else {
                    if (controller.otpController.text.isEmpty) {
                      controller.otpError.value = 'Otp fileld con\'t be empty';
                    } else {
                      controller.otpError.value = 'Invalid otp';
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  //padding: const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Verify',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.buttonText,
                  ),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  });
}
