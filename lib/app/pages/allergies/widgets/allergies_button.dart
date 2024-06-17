import 'package:airmymd/app/app.dart';

Widget allergiesButton() {
  return GetBuilder<AllergiesController>(builder: (controller) {
    return FittedBox(
        child: GlobalButtons().primaryButton(
            text: controller.navigateFrom == 'Setting Screen'
                ? 'Update'
                : PageConstants.kSave,
            onTap: controller.onSaveButtonClicked));
  });
}
