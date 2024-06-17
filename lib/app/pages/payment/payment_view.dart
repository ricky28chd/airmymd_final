import 'package:airmymd/app/app.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.containerBackground,
        appBar: AppBar(
          title: const Text(
            'Payment',
            style: AppTextStyle.appBarHeading,
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '\$${controller.doctorFees}',
                style: TextStyles.boldYellow15,
              ),
            ),
            AppSizeBox.width_10,
          ],
        ),
        body: const PaymentWidget(),
      );
    });
  }
}
