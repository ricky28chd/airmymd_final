import 'package:airmymd/app/app.dart';

class MedicationWidget extends StatelessWidget {
  const MedicationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MedicationController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: AppPadding.outerScreenPadding,
            child: controller.isLoading == true
                ? Container()
                : Column(
                    children: [
                      AppSizeBox.height_2,
                      const Text(
                        PageConstants
                            .kListPrescribedAndOverTheCounterMedications,
                        style: AppTextStyle.mainHeading,
                      ),
                      AppSizeBox.height_1,
                      ListView.builder(
                          primary: false,
                          itemCount: controller.medicationList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                controller.medicationList[index],
                                AppSizeBox.height_1,
                                Visibility(
                                  visible: controller.medicationList.length > 1
                                      ? true
                                      : false,
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.removeMedication(index);
                                      },
                                      child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Remove',
                                            style: TextStyles.extraBoldRed13,
                                          ))),
                                ),
                              ],
                            );
                          }),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          onPressed: () {
                            if (controller.drugNameControllerList[0].text !=
                                    '' &&
                                controller.commentControllerList[0].text !=
                                    '') {
                              controller.medicationList
                                  .add(controller.addMoreMedication());
                              controller.drugNameControllerListError.value = '';
                              controller.commentControllerListError.value = '';
                            } else {
                              controller.drugNameControllerListError.value =
                                  'This field can\'t be empty';
                              controller.commentControllerListError.value =
                                  'This field can\'t be empty';
                            }

                            controller.update();
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          label: const Text(
                            'Add More',
                            style: TextStyles.extraBoldBlue13,
                          ),
                        ),
                      ),
                      AppSizeBox.height_10,
                      medicationButton(),
                      AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap: NavigateTo.goToSexualHealthScreen),
                    ),
              AppSizeBox.height_5,
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
