import 'package:airmymd/app/app.dart';

class SurgeriesWidget extends StatelessWidget {
  const SurgeriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SurgeriesController>(builder: (controller) {
      return SingleChildScrollView(
        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kIncludeYearOrAgeAtTimeOfSurgery,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              surgeriesField(),
              AppSizeBox.height_5,
              const Text(
                'Surgery details',
                style: AppTextStyle.checkBoxTitle,
              ),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                        child: GlobalTextField().withIcon(
                      context: context,
                      image: AppImages.calenderIcon,
                      imageTap: () {
                        controller.selectDate();
                      },
                      hintText: 'Year',
                      onChanged: controller.enterYear,
                      keyBoardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: controller.yearController,
                      errorText: controller.yearError.value == ''
                          ? null
                          : controller.yearError.value,
                    )),
                    AppSizeBox.width_8,
                    Expanded(
                        child: GlobalTextField().withoutIcon(
                      context: context,
                      hintText: 'Age',
                      onChanged: controller.enterAge,
                      keyBoardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: controller.ageController,
                      errorText: controller.ageError.value == ''
                          ? null
                          : controller.ageError.value,
                    ))
                  ],
                ),
              ),
              AppSizeBox.height_10,
              surgeriesButton(),
               AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToMedicationScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
