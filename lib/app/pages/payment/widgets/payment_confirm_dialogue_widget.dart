import 'package:airmymd/app/app.dart';

Future confirmationDialogue(
    {required String doctorFirstName,
    required String doctorLastName,
    required String bookingDate,
    required String bookingTime}) {
  return Get.defaultDialog(
      barrierDismissible: false,
      radius: 10.0,
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(AppImages.thankYouIcon),
            AppSizeBox.height_3,
            const Text(
              PageConstants.kThanksForBooking,
              textAlign: TextAlign.center,
              style: TextStyles.mediumDark25,
            ),
            AppSizeBox.height_3,
            const Text(
              PageConstants.kYouBookedAnAppointmentWith,
              style: TextStyles.plainDark15,
            ),
            AppSizeBox.height_1,
            Text(
              'Dr. $doctorFirstName $doctorLastName',
              style: TextStyles.darkBlack15,
            ),
            AppSizeBox.height_1,
            Text(
              '$bookingDate at $bookingTime',
              style: TextStyles.darkBlack15,
            ),
            AppSizeBox.height_5,
            GlobalButtons().primaryButton(
                text: 'Ok',
                onTap: () {
                  NavigateTo.goToAppointmentListScreen();
                })
          ],
        ),
      ));
}
