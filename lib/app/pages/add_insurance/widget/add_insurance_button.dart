import 'package:airmymd/app/app.dart';

Widget addInsuranceButton() {
  return GetBuilder<AddInsuranceController>(builder: (controller) {
    return Align(
        alignment: Alignment.center,
        child: GlobalButtons().primaryButton(
          text: PageConstants.kAdd,
          onTap: controller.onSaveButtonClicked,
        ));
  });
}
