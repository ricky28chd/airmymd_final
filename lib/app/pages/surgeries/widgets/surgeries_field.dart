import 'package:airmymd/app/app.dart';

///This List of data stored titles for Medical history page which
///will be user in medicalHistoryField function.
List<String> surgeriesTitle = <String>[
  PageConstants.kAppendectomy,
  PageConstants.kTonsillectomy,
  PageConstants.kCardiacBypassCABG,
  PageConstants.kHerniaRepairE,
  PageConstants.kHysterectomyTotal,
  PageConstants.kHysterectomyPartia,
  PageConstants.kGallbladderLaparoscopicTubeLigation,
  PageConstants.kVasectomy,
  PageConstants.kNeuropathy,
  PageConstants.kGallbladderOpen,
  PageConstants.kCataractSurgeryRight,
  PageConstants.kProstateSurgery,
];

///This is the List of all Medical History parameters.
Widget surgeriesField() {
  return GetBuilder<SurgeriesController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          surgeriesTitle
              .sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
          return GestureDetector(
            onTap: () {
              controller.addSurgeries(surgeriesTitle[index]);
            },
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.surgeriesList
                              .contains(surgeriesTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    surgeriesTitle[index],
                    style: AppTextStyle.checkBoxTitle,
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return AppSizeBox.height_3;
        },
        itemCount: surgeriesTitle.length);
  });
}
