import 'package:airmymd/app/app.dart';

Widget bookAppointmentButton() {
  return GetBuilder<BookAppointmentController>(builder: (controller) {
    return Align(
        alignment: Alignment.center,
        child: GlobalButtons().primaryButton(
          text: PageConstants.kContinue,
          onTap: controller.onContinueButtonClicked,
        ));
  });
}
