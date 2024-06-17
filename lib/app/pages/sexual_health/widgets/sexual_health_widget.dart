import 'package:airmymd/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SexualHealthWidget extends StatelessWidget {
  const SexualHealthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SexualHealthController>(builder: (controller) {
      return SingleChildScrollView(

        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kOnlySelectOne,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              sexualHealthField(),
              AppSizeBox.height_10,
              sexualHealthButton(),
              AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToHealthHabitsScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
