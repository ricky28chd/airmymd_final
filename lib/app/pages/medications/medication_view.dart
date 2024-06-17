import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile_controller.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicationController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          shadowColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            PageConstants.kMedications,
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
        body: const MedicationWidget(),
      );
    });
  }
}
