import 'package:airmymd/app/app.dart';

class InsuranceListScreen extends StatelessWidget {
  const InsuranceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<InsuranceListController>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text(
              'Insurance',
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
          body: const InsuranceListWidget(),
        );
      }),
    );
  }
}
