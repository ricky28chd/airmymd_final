import 'package:airmymd/app/app.dart';

class AllergiesWidget extends StatelessWidget {
  const AllergiesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AllergiesController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: AppPadding.outerScreenPadding,
            child: controller.isLoading == true
                ? Container()
                : Column(
                    children: [
                      AppSizeBox.height_4,
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          PageConstants.kReactionsToMedications,
                          style: AppTextStyle.mainHeading,
                        ),
                      ),
                      ListView.builder(
                        primary: false,
                        itemCount: controller.reactionList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              controller.reactionList[index],
                              AppSizeBox.height_1,
                              Visibility(
                                visible: controller.reactionList.length > 1
                                    ? true
                                    : false,
                                child: GestureDetector(
                                    onTap: () {
                                      controller.removeReaction(index);
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
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          onPressed: () {
                            controller.reactionList
                                .add(controller.addReaction());
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
                      AppSizeBox.height_2,
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          PageConstants.kFoodAllergies,
                          style: AppTextStyle.mainHeading,
                        ),
                      ),
                      ListView.builder(
                          primary: false,
                          itemCount: controller.foodAllergyList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                controller.foodAllergyList[index],
                                AppSizeBox.height_1,
                                Visibility(
                                  visible: controller.foodAllergyList.length > 1
                                      ? true
                                      : false,
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.removeFoodAllergy(index);
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
                            controller.foodAllergyList
                                .add(controller.addFoodAllergies());
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
                      allergiesButton(),
                      AppSizeBox.height_2,
                      controller.navigateFrom == 'Setting Screen'
                          ? Container()
                          : GlobalButtons().primaryButton(
                              text: 'Skip',
                              onTap: NavigateTo.goToMedicalHistoryScreen)
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
