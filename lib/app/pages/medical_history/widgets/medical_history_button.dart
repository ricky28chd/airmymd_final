import 'package:airmymd/app/app.dart';

Widget medicalHistoryButton() {
  return Align(
      alignment: Alignment.center,
      child: GetBuilder<MedicalHistoryController>(builder: (controller) {
        return GlobalButtons().primaryButton(
            text: controller.navigateFrom == 'Setting Screen'
                ? 'Update'
                : PageConstants.kSave,
            onTap: controller.onSaveButtonClicked);
      }));
}
