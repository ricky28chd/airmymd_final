import 'package:airmymd/app/app.dart';

///This List of data stored titles for Medical history page which
///will be user in medicalHistoryField function.
List<String> tobaccoTitle = <String>[
  PageConstants.kNever,
  PageConstants.kFormerSmoker,
  PageConstants.kQuit,
  PageConstants.kCurrentSmoker,
];

List<String> otherTobaccoTitle = <String>[
  PageConstants.kPipe,
  PageConstants.kCigars,
  PageConstants.kChewingTobacco,
];

///This is the List of all Medical History parameters.
Widget tobaccoField() {
  return GetBuilder<TobaccoController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectTobacco(tobaccoTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: Get.height * 0.02),
                          child: Image.asset(controller.selectedTobacco
                                  .contains(tobaccoTitle[index])

                              ///This condition will check if
                              ///index is present in empty list or not
                              ///if present then change widget according to those index
                              ? AppImages.checkBox
                              : AppImages.unCheckBox)),
                      AppSizeBox.width_2,
                      Text(
                        tobaccoTitle[index],
                        style: AppTextStyle.checkBoxTitle,
                      )
                    ],
                  ),
                  index == 2 || index == 3
                      ? controller.selectedTobacco.contains(tobaccoTitle[index])
                          ? Container(
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: index == 2
                                          ? Obx(() =>
                                              GlobalTextField().withoutIcon(
                                                errorText: controller
                                                            .datePackControllerError
                                                            .value ==
                                                        ''
                                                    ? null
                                                    : controller
                                                        .datePackControllerError
                                                        .value,
                                                onChanged:
                                                    controller.enterDatePack,
                                                onTap: () {
                                                  controller
                                                      .selectDate(context);
                                                },
                                                hintText: 'Date',
                                                controller: controller
                                                    .datePackController,
                                              ))
                                          : Obx(() =>
                                              GlobalTextField().withoutIcon(
                                                keyBoardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.next,
                                                errorText: controller
                                                            .datePackControllerError
                                                            .value ==
                                                        ''
                                                    ? null
                                                    : controller
                                                        .datePackControllerError
                                                        .value,
                                                onChanged:
                                                    controller.enterDatePack,
                                                hintText: 'Packs/Day',
                                                controller: controller
                                                    .datePackController,
                                              ))),
                                  AppSizeBox.width_5,
                                  Expanded(
                                      child: Obx(() =>
                                          GlobalTextField().withoutIcon(
                                            keyBoardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            errorText: controller
                                                        .ageYearControllerError
                                                        .value ==
                                                    ''
                                                ? null
                                                : controller
                                                    .ageYearControllerError
                                                    .value,
                                            onChanged: controller.enterAge,
                                            hintText:
                                                index == 2 ? 'Age' : 'Years',
                                            controller:
                                                controller.ageYearController,
                                          ))),
                                ],
                              ),
                            )
                          : Container()
                      : Container()
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return AppSizeBox.height_3;
        },
        itemCount: tobaccoTitle.length);
  });
}

Widget otherTobaccoField() {
  return GetBuilder<TobaccoController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectOtherTobacco(otherTobaccoTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectOtherTobaccoList
                              .contains(otherTobaccoTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    otherTobaccoTitle[index],
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
        itemCount: otherTobaccoTitle.length);
  });
}
