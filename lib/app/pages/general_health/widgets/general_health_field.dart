import 'package:airmymd/app/app.dart';

///This List of data stored titles for Medical history page which
///will be user in medicalHistoryField function.
List<String> generalHealthTitle = <String>[
  PageConstants.kFatigue,
  PageConstants.kFever,
  PageConstants.kWeightGainGreater10lbs,
  PageConstants.kWeightGainSmaller10lbs,
];

List<String> skinTitle = <String>[
  PageConstants.kRash,
  PageConstants.kNailChanges,
  PageConstants.kNewChangingSkinLesion,
  PageConstants.kHairLoss,
];

List<String> eyeNoseThroatTitle = <String>[
  PageConstants.kVisionChanges,
  PageConstants.kDecreasedHearing,
  PageConstants.kEarPain,
  PageConstants.kRingingInEars,
  PageConstants.kNasalCongestion,
  PageConstants.kNoseBleeds,
  PageConstants.kHoarseVoice,
  PageConstants.kSoreThroat,
  PageConstants.kSneezing,
  PageConstants.kSinusProblem,
  PageConstants.kLumpInNeck,
];

///This is the List of all Medical History parameters.
Widget generalHealthField() {
  return GetBuilder<GeneralHealthController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectGeneralHealth(generalHealthTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedGeneralHealth
                              .contains(generalHealthTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    generalHealthTitle[index],
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
        itemCount: generalHealthTitle.length);
  });
}

Widget selectSkinField() {
  return GetBuilder<GeneralHealthController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectSkin(skinTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectSkinList
                              .contains(skinTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    skinTitle[index],
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
        itemCount: skinTitle.length);
  });
}

Widget selectEyeThroatField() {
  return GetBuilder<GeneralHealthController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectEyeThroat(eyeNoseThroatTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectEyeThroatList
                              .contains(eyeNoseThroatTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    eyeNoseThroatTitle[index],
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
        itemCount: eyeNoseThroatTitle.length);
  });
}
