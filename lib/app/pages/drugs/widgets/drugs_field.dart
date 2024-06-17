import 'package:airmymd/app/app.dart';

///This List of data stored titles for Medical history page which
///will be user in medicalHistoryField function.
List<String> drugsTitle = <String>[
  PageConstants.kNo,
  PageConstants.kYes,
];

Widget streetDrugsField() {
  return GetBuilder<DrugsController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectStreetDrugs(drugsTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedStreetDrugsList
                              .contains(drugsTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    drugsTitle[index],
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
        itemCount: drugsTitle.length);
  });
}

Widget needleDrugsField() {
  return GetBuilder<DrugsController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectNeedleDrugs(drugsTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedNeedleDrugsList
                              .contains(drugsTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    drugsTitle[index],
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
        itemCount: drugsTitle.length);
  });
}
