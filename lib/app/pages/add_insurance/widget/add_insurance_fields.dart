import 'package:airmymd/app/app.dart';

import '../../../utils/list_data_for_project.dart';

/////
Widget addInsuranceField() {
  return GetBuilder<AddInsuranceController>(builder: (controller) {
    return Column(
      children: [
        Obx(
          () => GlobalDropDown(
            errorText: controller.dropDownError.value == ''
                ? null
                : controller.dropDownError.value,
            items: insuranceProviders,
            hintText: "Insurance Provider",
            dropDownItem: controller.dropDownItem,
            onChanged: controller.updateDropDownValue,
          ),
        ),
        controller.dropDownItem != 'Other'
            ? Container()
            : Obx(
                () => GlobalTextField().withoutIcon(
                  errorText:
                      controller.otherInsuranceControllerError.value == ''
                          ? null
                          : controller.otherInsuranceControllerError.value,
                  hintText: 'Other insurance name',
                  onChanged: controller.enterOtherInsurance,
                  controller: controller.otherInsuranceController,
                ),
              ),
        Obx(
          () => GlobalTextField().withLabel(
            label: 'Member ID',
            errorText: controller.memberError.value == ''
                ? null
                : controller.memberError.value,
            onChanged: controller.enterMemberId,
            hintText: 'xxxxxxxxxxxxxxx',
            controller: controller.memberNumberController,
          ),
        ),
        Obx(
          () => GlobalTextField().withLabel(
            label: 'Group Number',
            errorText: controller.groupError.value == ''
                ? null
                : controller.groupError.value,
            hintText: 'xxxxxxxxxxx',
            onChanged: controller.enterGroupNumber,
            controller: controller.groupNumberController,
          ),
        ),
        AppSizeBox.height_10,
      ],
    );
  });
}
