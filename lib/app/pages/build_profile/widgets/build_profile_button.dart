import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/build_profile/widgets/change_password_screen.dart';
import 'package:airmymd/device/device.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../../domain/repositories/localstorage_keys.dart';
import '../../../../main.dart';
import '../../otp/widgets/dummy.dart';
import 'package:http/http.dart' as http;

Widget buildProfileButton(context) {
  return GetBuilder<BuildProfileController>(builder: (controller) {
    return FittedBox(
      child: GlobalButtons().primaryButton(
          text: 'Update',
          onTap: () async {
            print('lapota');
            print(Get.find<DeviceRepository>()
                .getStringValue(LocalKeys.userPhone));
            print('dddd${controller.phoneController.text}');
            print('lapota2');
            FocusScope.of(context).unfocus();
            if (controller.firstNameController.text.trim().isNotEmpty &&
                controller.lastNameController.text.trim().isNotEmpty &&
                controller.emailController.text.trim().isNotEmpty &&
                controller.phoneController.text.trim().isNotEmpty &&
                controller.cityController.text.trim().isNotEmpty &&
                controller.stateDropDownItem != null &&
                controller.zipController.text.trim().isNotEmpty &&
                controller.heightController.text.trim().isNotEmpty &&
                controller.weightController.text.trim().isNotEmpty &&
                controller.genderDropDownItem != null &&
                controller.ethnicityDropDownItem != null &&
                controller.dobController.text.isNotEmpty &&
                controller.maritalStatusDropDownItem != null) {
              print('jfkfjf');
              //   if (Get.find<DeviceRepository>()
              //               .getStringValue(LocalKeys.userEmail)
              //               .toString() !=
              //           controller.emailController.text ||
              //       Get.find<DeviceRepository>()
              //               .getStringValue(LocalKeys.userPhone)
              //               .toString() !=
              //           controller.phoneController.text) {
              //     print('here');
              //     Utility.showLoader();
              //     try {
              //       var headers = {
              //         'Authorization':
              //             'Bearer ${Get.find<DeviceRepository>().getStringValue(LocalKeys.authToken)}',
              //         'Content-Type': 'application/json'
              //       };
              //       var bodyies = json.encode({
              //         "email": controller.emailController.text,
              //         "phone": controller.phoneController.text,
              //       });
              //       print(bodyies);
              //       var request = await http.post(
              //           Uri.parse('https://dev.airmymd.com/api/send-otp'),
              //           body: bodyies,
              //           headers: headers);
              //       var response = json.decode(request.body);
              //       print(response);
              //       if (response['returnCode'] == 1) {
              //         box.put('otp', response['data']['otp_number']);
              //         Utility.closeLoader();
              //         box.put('emailCMesage', response['returnMessage']);
              //         Utility.showMessage(response['returnMessage'],
              //             MessageType.success, () => Get.back(), 'Okay');
              //         // Get.snackbar(
              //         //     'Alert', 'Otp Send your Registerd Number Or Email');
              //         Get.dialog(Scaffold(
              //           appBar: AppBar(),
              //           body: SingleChildScrollView(
              //             physics: const ClampingScrollPhysics(),
              //             child: SizedBox(
              //               height: Get.height,
              //               width: Get.width,
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.end,
              //                 children: [
              //                   Expanded(
              //                     child: Container(
              //                       height: Get.height / 2,
              //                       alignment: Alignment.center,
              //                       child: Image.asset(
              //                         AppImages.logo,
              //                         height: Get.height * 0.15,
              //                       ),
              //                     ),
              //                   ),
              //                   bottomFormField2()
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ));
              //       } else {
              //         Utility.closeLoader();
              //         Utility.showDialogue(response['returnMessage']);
              //       }
              //     } catch (e) {
              //       print(
              //         controller.phoneController.text,
              //       );
              //       print(e.toString());
              //       Utility.closeLoader();
              //       Utility.showDialogue('Server Error');
              //     }
              //     FocusManager.instance.primaryFocus!.unfocus();
              //     // NavigateTo.goToOtpScreen(routeFrom: 'Setting Screen');
              //   } else {
              //     controller.onSaveButtonClicked();
              //   }
              // } else {
              //   print('entering hee');
              //   controller.onSaveButtonClicked();
              controller.onSaveButtonClicked();
            }
          }),
    );
  });
}

// Widget buildChangePasswordButton(context) {
//   return GetBuilder<BuildProfileController>(builder: (controller) {
//     return FittedBox(
//       child: GlobalButtons().primaryButton(text: 'Change Password', onTap: () async {
        
//         Get.to(ChangePasswordScreen());
//       }),
//     );
//   });
// }

// Widget buildChangePasswordScreenButton(context) {
//   return GetBuilder<BuildProfileController>(builder: (controller) {
//     return FittedBox(
//       child: GlobalButtons().primaryButton(text: 'Change Password', onTap: () async {
//         controller.onChangePasswordButtonClicked();
//       }),
//     );
//   });
// }
