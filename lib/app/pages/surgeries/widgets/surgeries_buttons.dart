import 'package:airmymd/app/app.dart';

Widget surgeriesButton() {
  return GetBuilder<SurgeriesController>(builder: (controller) {
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
