// ignore_for_file: prefer_const_constructors

import 'package:airmymd/app/app.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentListController>(builder: (controller) {
      return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
            title: const Text(
              PageConstants.kAppointments,
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
          body: const AppointmentListWidget(),
          bottomNavigationBar: BottomNavigationPage(
            image3: AppImages.calenderActive,
          ),
        ),
      );
    });
  }
}
