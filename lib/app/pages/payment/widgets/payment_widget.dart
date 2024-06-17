import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/payment/widgets/select_insurance_widget.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      var totalAmount = double.parse(controller.doctorFees) +
          double.parse(controller.doctorFees) * 3 / 100;
      return SingleChildScrollView(
        child: Padding(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppSizeBox.height_2,
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Booking Amount',
                          style: TextStyles.darkBlack15,
                        ),
                        Text(
                          '\$${controller.doctorFees}',
                          style: TextStyles.black_13_400,
                        )
                      ],
                    ),
                    AppSizeBox.height_1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Service Fee',
                          style: TextStyles.darkBlack15,
                        ),
                        Text(
                          totalAmount > 0 ? '3%' : '0%',
                          style: TextStyles.black_13_400,
                        )
                      ],
                    ),
                    AppSizeBox.height_1,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyles.darkBlack15,
                        ),
                        Text(
                          '\$${totalAmount.toStringAsFixed(2)}',
                          style: TextStyles.black_13_400,
                        )
                      ],
                    )
                  ],
                ),
              ),
              if (totalAmount > 0) AppSizeBox.height_2,
              if (totalAmount > 0)
                const Text(
                  PageConstants.kSelectCard,
                  style: TextStyles.greyMainHeading,
                ),
              AppSizeBox.height_3,
              if (totalAmount > 0) selectCardWidget(),
              Visibility(
                visible: controller.allCardList.isNotEmpty ? true : false,
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () {
                      NavigateTo.goToAddNewCardScreen(navigateFrom: 'payment');
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                    label: const Text(
                      'Add More',
                      style: TextStyles.extraBoldBlue13,
                    )),
              ),
              AppSizeBox.height_2,
              if (totalAmount > 0)
                totalAmount > 0
                    ? const Text(
                        PageConstants.kOrSelectInsurance,
                        style: TextStyles.greyMainHeading,
                      )
                    : const Text(
                        'Select Insurance',
                        style: TextStyles.greyMainHeading,
                      ),
              AppSizeBox.height_3,
              if (totalAmount > 0) selectInsuranceWidget(),
              if (totalAmount > 0)
                Visibility(
                  visible:
                      controller.allInsuranceList.isNotEmpty ? true : false,
                  child: TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        NavigateTo.goToAddInsuranceScreen(
                            id: "0", navigateFrom: 'paymentScreen');
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                      label: const Text(
                        'Add More',
                        style: TextStyles.extraBoldBlue13,
                      )),
                ),
              AppSizeBox.height_5,
              totalAmount > 0 ? paymentButton() : nonePayment(),
              AppSizeBox.height_10
            ],
          ),
        ),
      );
    });
  }
}
