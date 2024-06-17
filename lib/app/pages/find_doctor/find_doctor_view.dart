import 'package:airmymd/app/app.dart';

class FindDoctorScreen extends StatelessWidget {
  const FindDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindDoctorController>(builder: (controller) {
      return SafeArea(
        top: false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationPage(
            ///Need to change this image for bottom navigation bar color change.
            image1: AppImages.searchActive,
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onTap: () {
                NavigateTo.goToSetLocationScreen(navigateFrom: 'findDoctor');
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.locationIcon,
                    scale: 4,
                  ),
                  AppSizeBox.width_2,
                  Container(
                    width: Get.width * 0.60,
                    child: Text(
                      controller.userDefaultLocation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.whiteBold15,
                    ),
                  )
                ],
              ),
            ),
            titleSpacing: 5,
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
          body: const FindDoctorWidget(),
        ),
      );
    });
  }
}
