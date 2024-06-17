import 'package:airmymd/app/app.dart';

class AlcoholWidget extends StatelessWidget {
  const AlcoholWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlcoholController>(builder: (controller) {
      return SingleChildScrollView(
        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kDoYouDrinkAlcohol,
                style: AppTextStyle.mainHeading,
              ),

              AppSizeBox.height_2,
              alcoholField(),
              controller.selectedAlcoholList.toString() == ['No'].toString()||controller.selectedAlcoholList.isEmpty?
              Container():
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  alcoholTextField(),
                  AppSizeBox.height_3,
                  const Text(
                    PageConstants.kDoYouFeelYouShouldCutDownOnDrinking,
                    style: AppTextStyle.mainHeading,
                  ),
                  AppSizeBox.height_2,
                  cutDownField(),
                  AppSizeBox.height_3,
                  const Text(
                    PageConstants.kHaveYouEverFeltGuiltyAboutDrinking,
                    style: AppTextStyle.mainHeading,
                  ),
                  AppSizeBox.height_2,
                  guiltyField(),
                  AppSizeBox.height_3,
                  const Text(
                    PageConstants.kHaveYouEverHadAMorningDrinkToSteadyYourNerves,
                    style: AppTextStyle.mainHeading,
                  ),
                  AppSizeBox.height_2,
                  morningDrinkField(),
                ],
              ),
              AppSizeBox.height_10,
              alcoholButton(),
              AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToDrugScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
