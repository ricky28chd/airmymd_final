import 'package:airmymd/app/app.dart';

///Method for user to select card for the payment.
Widget selectCardWidget() {
  return GetBuilder<PaymentController>(builder: (controller) {
    return controller.allCardList.isEmpty
        ? Container(
            width: Get.width * 1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.whiteColor),
            child: TextButton.icon(
                onPressed: () {
                  NavigateTo.goToAddNewCardScreen(navigateFrom: 'payment');
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                ),
                label: const Text(
                  'Add New Bank Card',
                  style: TextStyles.extraBoldBlue13,
                )),
          )
        : ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  controller
                      .selectCard(controller.allCardList[index].cardToken);
                  controller.paymentType = 'card';
                  controller.update();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Wrap(
                        children: <Widget>[
                          Image.asset(
                            controller.allCardList[index].cardName.toString() ==
                                    'visa'
                                ? AppImages.visaCard
                                : controller.allCardList[index].cardName
                                            .toString() ==
                                        'maestro'
                                    ? AppImages.maestroCard
                                    : controller.allCardList[index].cardName
                                                .toString() ==
                                            'mastercard'
                                        ? AppImages.masterCard
                                        : controller.allCardList[index].cardName
                                                    .toString() ==
                                                'dinersclub'
                                            ? AppImages.dinnersCard
                                            : controller.allCardList[index]
                                                        .cardName
                                                        .toString() ==
                                                    'amex'
                                                ? AppImages.americanCard
                                                : controller.allCardList[index]
                                                            .cardName
                                                            .toString() ==
                                                        'discover'
                                                    ? AppImages.discoverCard
                                                    : controller
                                                                .allCardList[
                                                                    index]
                                                                .cardName
                                                                .toString() ==
                                                            'jcb'
                                                        ? AppImages.jcbCard
                                                        : controller
                                                                    .allCardList[
                                                                        index]
                                                                    .cardName
                                                                    .toString() ==
                                                                'unionpay'
                                                            ? AppImages
                                                                .otherCard
                                                            : AppImages
                                                                .otherCard,
                            height: Get.height * 0.04,
                          ),
                          AppSizeBox.width_3,
                          Wrap(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Text(
                                'XXXX XXXX XXXX ${controller.allCardList[index].cardNumber.toString().substring(controller.allCardList[index].cardNumber!.length - 4)}',
                                style: AppTextStyle.authenticationPlain,
                              ),
                              Text(
                                controller.allCardList[index].cardName
                                    .toString()
                                    .capitalizeFirst!,
                                style: AppTextStyle.authenticationPlain,
                              )
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.selectCard(
                                controller.allCardList[index].cardToken);
                            controller.paymentType = 'card';
                            controller.update();
                          },
                          child: controller.selectedCard.contains(
                                  controller.allCardList[index].cardToken)
                              ? const Icon(
                                  Icons.radio_button_checked,
                                  size: 18,
                                  color: AppColors.primaryColor,
                                )
                              : const Icon(
                                  Icons.circle_outlined,
                                  size: 18,
                                  color: AppColors.primaryColor,
                                ))
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return AppSizeBox.height_2;
            },
            itemCount: controller.allCardList.length);
  });
}
