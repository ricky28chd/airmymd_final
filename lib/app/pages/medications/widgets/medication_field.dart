import 'package:airmymd/app/app.dart';

Widget medicationField(
    {required TextEditingController drugNameController,
    required TextEditingController commentController}) {
  return GetBuilder<MedicationController>(builder: (controller) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => GlobalTextField().withoutIcon(
                hintText: 'Drug Name',
                controller: drugNameController,
                errorText: controller.drugNameControllerListError.value == ''
                    ? null
                    : controller.drugNameControllerListError.value,
                onChanged: (value) {
                  value.isNotEmpty
                      ? controller.drugNameControllerListError.value = ''
                      : controller.drugNameControllerListError.value =
                          'Enter drug name';
                }),
          ),
          Obx(
            () => GlobalTextField().withoutIcon(
                hintText: 'Reaction/Comment',
                controller: commentController,
                errorText: controller.commentControllerListError.value == ''
                    ? null
                    : controller.commentControllerListError.value,
                onChanged: (value) {
                  value.isNotEmpty
                      ? controller.commentControllerListError.value = ''
                      : controller.commentControllerListError.value =
                          'Enter comment';
                }),
          ),
        ],
      ),
    );
  });
}
