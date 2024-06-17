import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/archived/archived.dart';
import 'package:airmymd/app/pages/profile_setting_screen/widget/inviattions.dart';
import 'package:airmymd/app/pages/setting_screen/widget/health_detail_dashboard.dart';
import 'package:airmymd/web_view_page.dart';
import 'package:flutter/cupertino.dart';

import 'log_out_tile_widget.dart';

class UserSettingWidget extends StatelessWidget {
  const UserSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserSettingController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  NavigateTo.goToNotesScreen();
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.only(right: 10),
                    title: Text(
                      'Notes',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ViewInvitations()));
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.only(right: 10),
                    title: Text(
                      'Invitations',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const ArchivedScreen()));
                  },
                  contentPadding: const EdgeInsets.only(right: 10),
                  title: const Text(
                    'Archived',
                    style: TextStyles.mediumDark15,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black,
                  )),
              const ListTile(
                  onTap: NavigateTo.goToPaymentCardListScreen,
                  contentPadding: EdgeInsets.only(right: 10),
                  title: Text(
                    'Payment Methods',
                    style: TextStyles.mediumDark15,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black,
                  )),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Push Notifications',
                  style: TextStyles.mediumDark15,
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                      activeColor: AppColors.primaryColor,
                      value: controller.pushNotification,
                      onChanged: (bool value) {
                        controller.pushNotification = value;
                        controller.pushNotificationStatusChange();
                        controller.update();
                      }),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Email Notifications',
                  style: TextStyles.mediumDark15,
                ),
                trailing: Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    activeColor: AppColors.primaryColor,
                    value: controller.emailNotification,
                    onChanged: (bool value) {
                      controller.emailNotification = value;
                      controller.emailNotificationStatusChange();
                      controller.update();
                    },
                  ),
                ),
              ),
              ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AirmymdWebViewWidget(
                                  url:
                                      'https://login.airmymd.com/privacy-policy',
                                )));
                    // const url =
                    //     'http://airmymd.smallbizplace.com/privacy-policy';
                    // controller.navigateToUrl(
                    //   url: url,
                    //   inApp: true,
                    // );
                  },
                  contentPadding: const EdgeInsets.only(right: 10),
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyles.mediumDark15,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black,
                  )),
              ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AirmymdWebViewWidget(
                                  url: 'https://login.airmymd.com/terms',
                                )));
                  },
                  contentPadding: const EdgeInsets.only(right: 10),
                  title: const Text(
                    'Terms and Conditions',
                    style: TextStyles.mediumDark15,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black,
                  )),
              ListTile(
                  onTap: () {
                    Get.to(() => const HealthDetailDashboard());
                  },
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    'Health Detail',
                    style: TextStyles.mediumDark15,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black,
                  )),
              // ListTile(
              //     onTap: () {
              //       controller.epicLogin();
              //     },
              //     contentPadding: const EdgeInsets.only(right: 10),
              //     title: const Text(
              //       'EHR',
              //       style: TextStyles.mediumDark15,
              //     ),
              //     trailing: const Icon(
              //       Icons.arrow_forward_ios,
              //       size: 18,
              //       color: Colors.black,
              //     )),
              ListTile(
                  onTap: () {
                    NavigateTo.goTosupportScreen();
                  },
                  contentPadding: const EdgeInsets.only(right: 10),
                  title: const Text(
                    'Help',
                    style: TextStyles.mediumDark15,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black,
                  )),
              logOutTileWidget(context),
            ],
          ),
        ),
      );
    });
  }
}
