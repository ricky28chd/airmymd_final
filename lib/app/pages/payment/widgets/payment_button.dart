import 'package:airmymd/app/app.dart';

///Method of button, on which user can press to confirm the booking.
Widget paymentButton() {
  return GetBuilder<PaymentController>(builder: (controller) {
    return Align(
      alignment: Alignment.center,
      child: GlobalButtons().primaryButton(
        text: PageConstants.kMakePayment,

        ///On Tapping this button,
        ///a dialogue box opens with the confirmation of bookings, and this
        ///box also carries booking details.
        onTap: controller.paymentType == 'insurance'
            ? controller.bookingWithInsuranceModel
            : controller.bookAppointmentWithCard,
      ),
    );
  });
}

Widget nonePayment() {
  return GetBuilder<PaymentController>(builder: (controller) {
    return Align(
      alignment: Alignment.center,
      child: GlobalButtons().primaryButton(
        text: PageConstants.kMakePayment,

        ///On Tapping this button,
        ///a dialogue box opens with the confirmation of bookings, and this
        ///box also carries booking details.
        onTap: controller.none,
      ),
    );
  });
}
