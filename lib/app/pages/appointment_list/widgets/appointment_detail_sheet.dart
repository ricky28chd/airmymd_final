import 'package:airmymd/app/app.dart';

// ignore: non_constant_identifier_names
Widget AppointmentDetailSheet(
    {required String doctorName,
    required String bookingTimeDate,
    required Widget bookingStatus,
    required String appointmentReason,
    required String appointmentFor,
    required Widget chatButtonWidget,
    required Widget cancelButtonWidget,
    DecorationImage? decorationImage}) {
  return GetBuilder<AppointmentListController>(builder: (controller) {
    return Stack(
      children: [
        Container(
          height: Get.height / 2.1,
          width: Get.width * 1,
          color: Colors.transparent,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            height: Get.height / 2.5,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        doctorName,
                        style: AppTextStyle.doctorNameTitle,
                      ),
                      AppSizeBox.height_1,
                      Text(
                        bookingTimeDate,
                        style: TextStyles.darkPlain14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AppSizeBox.height_1,
                      bookingStatus,
                      AppSizeBox.height_1,
                      const Text('Appointment Reason',
                          style: TextStyles.darkMedium12),
                      AppSizeBox.height_005,
                      Text(
                        appointmentReason,
                        style: TextStyles.plainDark15,
                      ),
                      AppSizeBox.height_1,
                      appointmentFor == 'null'
                          ? SizedBox()
                          : const Text('Appointment For',
                              style: TextStyles.darkMedium12),
                      AppSizeBox.height_005,
                      appointmentFor == 'null'
                          ? SizedBox()
                          : Text(
                              appointmentFor,
                              style: TextStyles.plainDark15,
                            ),
                      AppSizeBox.height_1,
                      chatButtonWidget,
                      AppSizeBox.height_1,
                      cancelButtonWidget,
                      AppSizeBox.height_3,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            left: 140,
            right: 140,
            child: Container(
              height: Get.height * 0.12,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5.0),
                  image: decorationImage),
            )),
      ],
    );
  });
}
