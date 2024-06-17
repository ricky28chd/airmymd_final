import 'package:airmymd/app/app.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (controller) {
      return Padding(
        padding: AppPadding.padding_20,
        child: Column(
          children: [
            AppSizeBox.height_3,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.textFieldHintText)),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.onPastButtonSelected,
                        child: Container(
                          margin: const EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: controller.selectedButton == 'My Notes'
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'My Notes',
                            style: controller.selectedButton == 'My Notes'
                                ? TextStyles.whiteBold15
                                : TextStyles.greyPlain15,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: controller.onUpcomingButtonSelected,
                        child: Container(
                          margin: const EdgeInsets.all(3.0),
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: controller.selectedButton == 'Shared Notes'
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Shared Notes',
                            style: controller.selectedButton == 'Shared Notes'
                                ? TextStyles.whiteBold15
                                : TextStyles.greyPlain15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSizeBox.height_3,

            /// Shared Notes==============
            controller.selectedButton == 'My Notes'
                ? const SharedNotesWidget()
                : const MyNotesWidget(),
            AppSizeBox.height_3,
          ],
        ),
      );
    });
  }
}

List colorsList = [
  0xffFE99FF,
  0xffFE9E9F,
  0xff92F48F,
  0xffFFF599,
  0xff9FFFFE,
  0xff00B894,
  0xffFDB461,
  0xffC2C2B4,
];
