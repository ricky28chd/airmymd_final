import 'package:airmymd/app/app.dart';

Widget doctorProfileButton() {
  return GetBuilder<DoctorProfileController>(builder: (controller) {
    return Align(
      alignment: Alignment.center,
      child: GlobalButtons().primaryButton(
        text: 'Book Appointment',
        onTap: () {
          if (controller.isRategivenID == 0) {
            controller.onBookAppointmentButtonClick();
          } else {
            Utility.showInfoAndNavigateDialogue(
              'Before moving forward, Please give your valuable rating for your last booking',
              () {
                Get.back();
                appointmentId = controller.isRategivenID;
                Get.bottomSheet(BottomSheet(
                    constraints: BoxConstraints(maxHeight: Get.height / 2.0),
                    backgroundColor: Colors.transparent,
                    onClosing: () {},
                    builder: (context) {
                      return addForceRatingWidget(onTap: () {
                        if (controller.rating != null) {
                          controller.addRating(
                              doctorId: controller.doctorDetail.profile!.userId
                                  .toString());
                          Get.back();
                        } else {
                          Utility.showDialogue(
                            'Please select one star as rating '
                            'if you dont\'t like the services',
                          );
                        }
                      });
                    }));
              },
            );
          }
        },
      ),
    );
  });
}
