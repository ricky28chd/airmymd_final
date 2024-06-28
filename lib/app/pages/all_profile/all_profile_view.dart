import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../domain/repositories/localstorage_keys.dart';
import '../../../domain/repositories/repository.dart';

class AllProfileScreen extends StatelessWidget {
  const AllProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<AllProfileController>(builder: (controller) {
        return Scaffold(
          bottomNavigationBar: const BottomNavigationPage(
            image2: AppImages.profileActive,
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: AppTextStyle.appBarHeading,
            ),
            actions: [
              const SizedBox(
                width: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    NavigateTo.goToNotificationListScreen();
                    controller.readNotification();
                    // var status = await Permission.notification.status;
                    // if (status.isGranted) {
                    //   NavigateTo.goToNotificationListScreen();
                    //   controller.readNotification();
                    // } else if (status.isDenied) {
                    //   // ignore: use_build_context_synchronously
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       title: const Text('Notification permission'),
                    //       content: const Text(
                    //           'Please grant permission to receive notifications.'),
                    //       actions: <Widget>[
                    //         TextButton(
                    //           child: const Text('Cancel'),
                    //           onPressed: () => Navigator.of(context).pop(),
                    //         ),
                    //         TextButton(
                    //           child: const Text('OK'),
                    //           onPressed: () => openAppSettings(),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    //   // Notification permission denied
                    // } else if (status.isPermanentlyDenied) {
                    //   // Notification permission permanently denied, open app settings
                    //   OpenSettings.openNotificationSetting();
                    // }
                  },
                  child: Image.asset(
                    notificationCount == 0
                        ? AppImages.notificationIcon
                        : AppImages.notificationActiveIcon,
                    scale: 4,
                  ),
                ),
              ),
              AppSizeBox.width_5,
              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.readMessages();
                    NavigateTo.goToChatListScreen();
                  },
                  child: Image.asset(
                    unreadMessage == 0
                        ? AppImages.messgeImage
                        : AppImages.unreadChatIcon,
                    scale: 3,
                  ),
                ),
              ),
              AppSizeBox.width_5,
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                      backgroundColor: Colors.white,
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                GlobalTextField().withLabel(
                                    maxLines: 3,
                                    inputFormat: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'\s+'))
                                    ],
                                    controller: controller.email,
                                    onChanged: (text) {
                                      controller.emailPhoneInput = text;
                                      controller.update();
                                    },
                                    validator:
                                        controller.validateEmailPhoneInput,
                                    label:
                                        'Enter valid email separated by commas.',
                                    hintText:
                                        'Enter valid email separated by commas.'),
                                const SizedBox(
                                  height: 40,
                                ),
                                GlobalButtons().primaryButton(
                                    text: 'Share',
                                    onTap: () async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        // Processing the comma-separated email and phone numbers
                                        controller.emailPhoneList = controller
                                            .emailPhoneInput
                                            .split(',');
                                        print(
                                          controller.email.text,
                                        );
                                        controller.update();
                                        Get.back();
                                        Utility.showLoader();
                                        print(
                                            'the user id is ${Get.find<Repository>().getStringValue(LocalKeys.userId)}');
                                        try {
                                          var request = await http.post(
                                            Uri.parse(
                                                'https://dev.airmymd.com/api/share-profile/${Get.find<Repository>().getStringValue(LocalKeys.userId)}'),
                                            body: {
                                              'email': controller.email.text,
                                            },
                                            headers: {
                                              'Accept': 'application/json',
                                              'Authorization':
                                                  'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
                                            },
                                          );

                                          print('the body is ${request.body}');
                                          var response =
                                              jsonDecode(request.body);
                                          if (response['returnCode'] == 1) {
                                            Utility.closeLoader();

                                            Utility.closeLoader();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Profile info shared successfully')));
                                          } else {
                                            Utility.closeLoader();

                                            // use_build_context_synchronously
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Something went wrong')));
                                          }
                                        } catch (e) {
                                          Get.back();
                                          Utility.closeLoader();
                                          Utility.showDialogue(e.toString());

                                          print(e);
                                        }

                                        controller.email.clear();
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                      ));
                },
                child: Image.asset(
                  'assets/images/icon_share (1).png',
                  scale: 4,
                  color: Colors.white,
                ),
              ),
              AppSizeBox.width_3,
            ],
          ),
          body: const AllProfilePage(),
        );
      }),
    );
  }
}
