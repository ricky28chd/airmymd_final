import 'package:airmymd/app/app.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserSettingController>(builder: (controller) {
      return SafeArea(
        top: false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationPage(
            image5: AppImages.settingActive,
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Settings',
              style: AppTextStyle.appBarHeading,
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    NavigateTo.goToNotificationListScreen();
                    controller.readNotification();
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
              AppSizeBox.width_3
            ],
          ),
          body: const UserSettingWidget(),
        ),
      );
    });
  }
}
