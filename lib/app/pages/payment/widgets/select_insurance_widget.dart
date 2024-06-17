import 'package:airmymd/app/app.dart';

///Method for user to select insurance for the payment.

Widget selectInsuranceWidget() {
  return GetBuilder<PaymentController>(builder: (controller) {
    return controller.allInsuranceList.isEmpty
        ? Container(
            width: Get.width * 1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.whiteColor),
            child: TextButton.icon(
                onPressed: () {
                  NavigateTo.goToAddInsuranceScreen(
                      id: "0", navigateFrom: 'paymentScreen');
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                ),
                label: const Text(
                  'Add New Insurance',
                  style: TextStyles.extraBoldBlue13,
                )),
          )
        : ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  controller.selectInsuranceCard(
                      controller.allInsuranceList[index].id);
                  controller.paymentType = 'insurance';
                  controller.update();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Wrap(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Text(
                            controller.allInsuranceList[index].phone.toString(),
                            style: AppTextStyle.authenticationPlain,
                          ),
                          Text(
                            controller.allInsuranceList[index].provider
                                .toString(),
                            style: AppTextStyle.authenticationPlain,
                          )
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.selectInsuranceCard(
                                controller.allInsuranceList[index].id);
                            controller.paymentType = 'insurance';
                            controller.update();
                          },
                          child: controller.selectedInsuranceCard.contains(
                                  controller.allInsuranceList[index].id)
                              ? const Icon(
                                  Icons.radio_button_checked,
                                  size: 18,
                                  color: AppColors.primaryColor,
                                )
                              : const Icon(
                                  Icons.circle_outlined,
                                  size: 18,
                                  color: AppColors.primaryColor,
                                )),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return AppSizeBox.height_2;
            },
            itemCount: controller.allInsuranceList.length);
  });
}
