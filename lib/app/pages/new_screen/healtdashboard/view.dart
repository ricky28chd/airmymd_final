import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/healtdashboard/widget/health_dashboad.dart';

class HealthDashboard extends StatelessWidget {
  const HealthDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindDoctorController>(builder: (controller) {
      return SafeArea(
        top: false,
        child: Scaffold(
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
                  SizedBox(
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
              AppSizeBox.width_3
            ],
          ),
          bottomNavigationBar: const BottomNavigationPage(
            image4: AppImages.insuranceActive,
          ),
          body: const Center(child: HealthDashboardWidget()),
        ),
      );
    });
  }
}
