import 'package:airmymd/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralHealthWidget extends StatelessWidget {
  const GeneralHealthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralHealthController>(builder: (controller) {
      return SingleChildScrollView(
        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kGeneral,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              generalHealthField(),
              AppSizeBox.height_3,
              const Text(
                PageConstants.kSkin,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_3,
              selectSkinField(),
              AppSizeBox.height_3,
              const Text(
                PageConstants.kEyeEarsNoseThroat,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_3,
              selectEyeThroatField(),
              AppSizeBox.height_10,
              generalHealthButton(),
               AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToTobaccoScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
