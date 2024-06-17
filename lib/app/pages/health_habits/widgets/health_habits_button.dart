import 'package:airmymd/app/app.dart';

Widget healthHabitButton() {
  return GetBuilder<HealthHabitController>(builder: (controller) {
    return Align(
        alignment: Alignment.center,
        child: GlobalButtons().primaryButton(
          text: controller.navigateFrom == 'Setting Screen'
              ? 'Update'
              : PageConstants.kSave,
          onTap: controller.onSaveButtonClicked,
        ));
  });
}
