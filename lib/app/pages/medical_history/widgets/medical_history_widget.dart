import 'package:airmymd/app/app.dart';

class MedicalHistoryWidget extends StatelessWidget {
  const MedicalHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalHistoryController>(builder: (controller) {
      return SingleChildScrollView(
        child: Container(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kCheckAllThatApplyToYou,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_2,
              medicalHistoryField(),
              AppSizeBox.height_10,
              medicalHistoryButton(),
              AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToSurgeriesScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
