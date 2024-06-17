import 'package:airmymd/app/app.dart';
import 'package:flutter/services.dart';

Widget addCardWidget() {
  return GetBuilder<AddNewCardController>(builder: (controller) {
    return Container(
      height: Get.height / 2.5,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => GlobalTextField().withIcon(
              errorText: controller.cardNumberError.value == ''
                  ? null
                  : controller.cardNumberError.value,
              textInputAction: TextInputAction.next,
              controller: controller.cardNumberController,
              keyBoardType: TextInputType.number,
              hintText: '**** **** **** ****',
              image: controller.cardImage,
              inputFormat: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(19),
                CardNumberInputFormatter()
              ],
              onChanged: controller.enterCardNumber,
            ),
          ),
          AppSizeBox.height_1,
          Obx(
            () => GlobalTextField().withIcon(
              errorText: controller.expError.value == ''
                  ? null
                  : controller.expError.value,
              textInputAction: TextInputAction.next,
              controller: controller.expController,
              hintText: 'MM/YY',
              onChanged: controller.enterExp,
              image: AppImages.calenderIcon,
              inputFormat: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
                CardMonthInputFormatter()
              ],
              keyBoardType: TextInputType.number,
            ),
          ),
          Obx(
            () => GlobalTextField().withIcon(
              obscureText: true,
              errorText: controller.cvvError.value == ''
                  ? null
                  : controller.cvvError.value,
              textInputAction: TextInputAction.done,
              controller: controller.cvvController,
              onChanged: controller.enterCvv,
              hintText: 'CVV',
              inputFormat: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              keyBoardType: TextInputType.number,
              image: AppImages.cvvImage,
            ),
          ),
          AppSizeBox.height_5,
          GlobalButtons().primaryButton(
            text: 'Add Card',
            onTap: controller.addNewCard,
          ),
          AppSizeBox.height_4,
        ],
      ),
    );
  });
}
