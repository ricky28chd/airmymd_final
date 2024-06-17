// ignore_for_file: prefer_const_constructors

import 'package:airmymd/app/app.dart';

class AppointmentListWidget extends StatelessWidget {
  const AppointmentListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentListController>(builder: (controller) {
      return Padding(
        padding: AppPadding.padding_20,
        child: Column(
          children: [
            AppSizeBox.height_3,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.textFieldHintText)),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.onUpcomingButtonSelected,
                        child: Container(
                          margin: const EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: controller.selectedButton ==
                                    'Upcoming Appointments'
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Upcoming',
                            style: controller.selectedButton ==
                                    'Upcoming Appointments'
                                ? TextStyles.whiteBold15
                                : TextStyles.greyPlain15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.onPastButtonSelected,
                        child: Container(
                          margin: const EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: controller.selectedButton ==
                                    'Past Appointments'
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Past ',
                            style: controller.selectedButton ==
                                    'Past Appointments'
                                ? TextStyles.whiteBold15
                                : TextStyles.greyPlain15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSizeBox.height_2,
            SizedBox(
              height: Get.height / 1.6,
              child: SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: controller.onRefreshAppointments,
                  child: Column(
                    children: [
                      controller.selectedButton == 'Upcoming Appointments'
                          ? upcomingAppointmentWidget()
                          : pastAppointmentWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
