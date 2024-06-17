import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/payment_card_list/widget/payment_card_list_button.dart';

class PaymentCardListWidget extends StatelessWidget {
  const PaymentCardListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentCardListController>(builder: (controller) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: controller.allPaymentCards.isEmpty
            ? Center(
                child: SizedBox(
                    height: Get.height / 1.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.cardListError,
                          textAlign: TextAlign.center,
                        ),
                        AppSizeBox.height_3,
                        controller.cardListError == ''
                            ? Container()
                            : GlobalButtons().primaryButton(
                                text: 'Add New',
                                onTap: NavigateTo.goToAddNewCardScreen,
                              )
                      ],
                    )),
              )
            : Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  Image.asset(
                                    controller.allPaymentCards[index].cardName
                                                .toString() ==
                                            'visa'
                                        ? AppImages.visaCard
                                        : controller.allPaymentCards[index]
                                                    .cardName
                                                    .toString() ==
                                                'maestro'
                                            ? AppImages.maestroCard
                                            : controller.allPaymentCards[index]
                                                        .cardName
                                                        .toString() ==
                                                    'mastercard'
                                                ? AppImages.masterCard
                                                : controller.allPaymentCards[index].cardName
                                                            .toString() ==
                                                        'dinersclub'
                                                    ? AppImages.dinnersCard
                                                    : controller
                                                                .allPaymentCards[
                                                                    index]
                                                                .cardName
                                                                .toString() ==
                                                            'amex'
                                                        ? AppImages.americanCard
                                                        : controller
                                                                    .allPaymentCards[
                                                                        index]
                                                                    .cardName
                                                                    .toString() ==
                                                                'discover'
                                                            ? AppImages
                                                                .discoverCard
                                                            : controller.allPaymentCards[index]
                                                                        .cardName
                                                                        .toString() ==
                                                                    'jcb'
                                                                ? AppImages.jcbCard
                                                                : controller.allPaymentCards[index].cardName.toString() == 'unionpay'
                                                                    ? AppImages.otherCard
                                                                    : AppImages.otherCard,
                                    height: Get.height * 0.04,
                                  ),
                                  AppSizeBox.width_3,
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: <Widget>[
                                      Text(
                                          'XXXX XXXX XXXX ${controller.allPaymentCards[index].cardNumber.toString().substring(controller.allPaymentCards[index].cardNumber!.length - 4)}'),
                                      Text(
                                        controller.allPaymentCards[index]
                                            .cardName!.capitalizeFirst
                                            .toString(),
                                        style: AppTextStyle.authenticationPlain,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.deleteCard(
                                      cardId: controller
                                          .allPaymentCards[index].id
                                          .toString());
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyles.extraBoldRed13,
                                ),
                              )
                            ],
                          ),
                        );

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //             'XXXX XXXX XXXX ${controller.allPaymentCards[index].cardNumber.toString().substring(controller.allPaymentCards[index].cardNumber!.length - 4)}'),
                        //         Text(controller.allPaymentCards[index].cardName
                        //             .toString())
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         GestureDetector(
                        //           onTap: () {
                        //             controller.deleteCard(
                        //               cardId: controller
                        //                   .allPaymentCards[index].id
                        //                   .toString(),
                        //             );
                        //           },
                        //           child: const Text(
                        //             'Delete',
                        //             style: TextStyles.extraBoldRed13,
                        //           ),
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                          height: 30,
                        );
                      },
                      itemCount: controller.allPaymentCards.length),
                  AppSizeBox.height_10,
                  addNewCardButtonWidget(),
                  AppSizeBox.height_5,
                ],
              ),
      ));
    });
  }
}
