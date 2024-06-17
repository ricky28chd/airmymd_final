import 'package:airmymd/app/app.dart';

///This List of data stored titles for Medical history page which
///will be user in medicalHistoryField function.
List<String> alcoholTitle = <String>[
  PageConstants.kNo,
  PageConstants.kYes,
  PageConstants.k01TimeMonth,
  PageConstants.k24TimeMonth,
  PageConstants.kEveryWeek,
];

List<String> alcoholYesN0Title = <String>[
  PageConstants.kNo,
  PageConstants.kYes,
];

///This is the List of all Medical History parameters.
Widget alcoholField() {
  return GetBuilder<AlcoholController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectAlcohol(alcoholTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedAlcoholList
                              .contains(alcoholTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    alcoholTitle[index],
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
        itemCount: alcoholTitle.length);
  });
}

Widget cutDownField() {
  return GetBuilder<AlcoholController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectCutDown(alcoholYesN0Title[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedCutDownList
                              .contains(alcoholYesN0Title[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    alcoholYesN0Title[index],
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
        itemCount: alcoholYesN0Title.length);
  });
}

Widget guiltyField() {
  return GetBuilder<AlcoholController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectGuilty(alcoholYesN0Title[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedGuiltyList
                              .contains(alcoholYesN0Title[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    alcoholYesN0Title[index],
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
        itemCount: alcoholYesN0Title.length);
  });
}

Widget morningDrinkField() {
  return GetBuilder<AlcoholController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.selectMorningDrink(alcoholYesN0Title[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.selectedMorningDrinkList
                              .contains(alcoholYesN0Title[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    alcoholYesN0Title[index],
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
        itemCount: alcoholYesN0Title.length);
  });
}

Widget alcoholTextField() {
  return GetBuilder<AlcoholController>(builder: (controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizeBox.height_4,
        const Text(
          PageConstants.kEachWeekHowMany,
          style: AppTextStyle.mainHeading,
        ),
        AppSizeBox.height_1,
        Obx(
          () => GlobalTextField().withoutIcon(
            textCapitalization: TextCapitalization.sentences,
            hintText: 'Serving Of Beer',
            controller: controller.beerController,
            onChanged: controller.enterBeerValue,
            errorText: controller.beerControllerError.value == ''
                ? null
                : controller.beerControllerError.value,
          ),
        ),
        Obx(
          () => GlobalTextField().withoutIcon(
            hintText: 'Glasses Of Wine',
            textCapitalization: TextCapitalization.sentences,
            controller: controller.wineController,
            onChanged: controller.enterWineValue,
            errorText: controller.wineControllerError.value == ''
                ? null
                : controller.wineControllerError.value,
          ),
        ),
        Obx(
          () => GlobalTextField().withoutIcon(
            hintText: 'Shots/Mixed Drinks',
            textCapitalization: TextCapitalization.sentences,
            controller: controller.mixedController,
            onChanged: controller.enterMixedValue,
            errorText: controller.mixedControllerError.value == ''
                ? null
                : controller.mixedControllerError.value,
          ),
        ),
        AppSizeBox.height_4,
        const Text(
          PageConstants.kWhenDidYouLastHaveMoreThan4DrinksInOneDay,
          style: AppTextStyle.mainHeading,
        ),
        AppSizeBox.height_1,
        GlobalTextField().withoutIcon(
          textCapitalization: TextCapitalization.sentences,
          hintText: 'Comment',
          controller: controller.inADayController,
        )
      ],
    );
  });
}
