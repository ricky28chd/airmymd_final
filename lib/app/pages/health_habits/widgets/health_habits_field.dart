import 'package:flutter/material.dart';
import 'package:airmymd/app/app.dart';
import 'package:get/get.dart';


///This List of data stored titles for Medical history page which
///will be user in medicalHistoryField function.
List<String> healthHabitTitle = <String>[
  PageConstants.kNoExercise,
  PageConstants.kMildExercise,
  PageConstants.kRegularExercise,
];

///This is the List of all Medical History parameters.
Widget healthHabitField() {
  return GetBuilder<HealthHabitController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectHealthHabit(healthHabitTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedHealthHabit
                          .contains(healthHabitTitle[index])

                      ///This condition will check if
                      ///index is present in empty list or not
                      ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    healthHabitTitle[index],
                    style: AppTextStyle.checkBoxTitle,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return AppSizeBox.height_3;
        },
        itemCount: healthHabitTitle.length);
  });
}
