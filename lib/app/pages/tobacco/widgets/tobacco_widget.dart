import 'package:airmymd/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TobaccoWidget extends StatelessWidget {
  const TobaccoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TobaccoController>(builder: (controller) {
      return SingleChildScrollView(
        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kCigaretteUse,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              tobaccoField(),
              AppSizeBox.height_3,
              const Text(
                PageConstants.kOtherTobaccoUse,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              otherTobaccoField(),
              AppSizeBox.height_10,
              tobaccoButton(),
              AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToAlcoholScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
