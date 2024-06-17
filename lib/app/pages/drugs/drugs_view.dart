import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile_controller.dart';

class DrugsScreen extends StatelessWidget {
  const DrugsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrugsController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            PageConstants.kDrugs,
            style: AppTextStyle.appBarHeading,
          ),
          actions: [
            controller.navigateFrom == 'Setting Screen'
                ? Container()
                : TextButton(
                    onPressed: () {
                      NavigateTo.goToHealthDashboard();
                      Get.find<AllProfileController>()
                          .getUserProfile(isLoading: false);
                      // NavigateTo.goToAddInsuranceScreen(
                      //     id: "0", navigateFrom: 'DrugScreen');
                      Get.delete<AllProfileController>();
                      Get.delete<BuildProfileController>();
                      Get.delete<SurgeriesController>();
                      Get.delete<MedicalHistoryController>();
                      Get.delete<AllergiesController>();

                      Get.delete<MedicationController>();

                      Get.delete<SexualHealthController>();

                      Get.delete<HealthHabitController>();

                      Get.delete<GeneralHealthController>();
                      Get.delete<TobaccoController>();
                      Get.delete<AlcoholController>();
                      Get.delete<DrugsController>();
                    },
                    child: const Text(
                      'Skip All',
                      style: TextStyles.whiteBold15,
                    ))
          ],
        ),
        body: const DrugsWidget(),
      );
    });
  }
}
