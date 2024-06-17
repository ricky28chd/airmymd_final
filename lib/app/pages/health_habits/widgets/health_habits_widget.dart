import 'package:airmymd/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthHabitWidget extends StatelessWidget {
  const HealthHabitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HealthHabitController>(builder: (controller) {
      return SingleChildScrollView(

        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kExercise,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              healthHabitField(),
              AppSizeBox.height_10,
              healthHabitButton(),
               AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToGeneralHealthScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
