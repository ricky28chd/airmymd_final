import 'package:airmymd/app/app.dart';


class DrugsWidget extends StatelessWidget {
  const DrugsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrugsController>(builder: (controller) {
      return SingleChildScrollView(
        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kHaveYouUsedRecreationalOrStreetDrugsWithinTheLast2Years,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              streetDrugsField(),
              AppSizeBox.height_3,
              const Text(
                PageConstants.kHaveYouEverUsedRecreationalDrugsWithNeedle0,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              needleDrugsField(),
              AppSizeBox.height_10,
             drugsButton(),
               AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap:   NavigateTo.goToAddInsuranceScreen
                        ),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
