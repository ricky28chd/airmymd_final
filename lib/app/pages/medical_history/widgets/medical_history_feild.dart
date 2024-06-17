import 'package:flutter/material.dart';
import 'package:airmymd/app/app.dart';
import 'package:get/get.dart';

// class MedicalHistory {
//   MedicalHistory({required this.title, required this.historyId});
//   final int historyId;
//   final String title;
//   static List<MedicalHistory> getData() {
//     return <MedicalHistory>[
//       MedicalHistory(title: PageConstants.kAlcoholDrugProblem, historyId: 1),
//       MedicalHistory(title: PageConstants.kEmphysemaCOPD, historyId: 2),
//       MedicalHistory(title: PageConstants.kLiverDisease, historyId: 3),
//       MedicalHistory(title: PageConstants.kBloodClots, historyId: 3),
//       MedicalHistory(title: PageConstants.kAnemia, historyId: 4),
//       MedicalHistory(title: PageConstants.kHeartAttack, historyId: 4)
//     ];
//   }
// }
///This List of data stored titles for Medical history page which
///will be user in medicalHistoryField function.
List<String> medicalHistoryTitle = <String>[
  PageConstants.kAlcoholDrugProblem,
  PageConstants.kEmphysemaCOPD,
  PageConstants.kLiverDisease,
  PageConstants.kBloodClots,
  PageConstants.kAnemia,
  PageConstants.kHeartAttack,
  PageConstants.kAnxiety,
  PageConstants.kOsteoporosis,
  PageConstants.kNeuropathy,
  PageConstants.kArthritis,
  PageConstants.kAsthma,
  PageConstants.kHighBloodPressure,
  PageConstants.kHeartMurmur,
  PageConstants.kSeizureDisorder,
  PageConstants.kAtrialFibrillation,
  PageConstants.kMigraines,
  PageConstants.kHepatitis,
  PageConstants.kDementia,
  PageConstants.kDiabetes,
  PageConstants.kDivertiulosis,
  PageConstants.kCancer,
  PageConstants.kColonPolyps,
  PageConstants.kKidneyDisease,
  PageConstants.kHypothyroidismLow,
  PageConstants.kPositiveTB,
  PageConstants.kStroke,
  PageConstants.kAbnormalPapTest,
  PageConstants.kHighCholesterol,
];

///This is the List of all Medical History parameters.
Widget medicalHistoryField() {
  return GetBuilder<MedicalHistoryController>(builder: (controller) {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          medicalHistoryTitle
              .sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
          return Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                controller.addHistory(medicalHistoryTitle[index]);
              },
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Get.height * 0.02),
                      child: Image.asset(controller.medicalHistoryList
                              .contains(medicalHistoryTitle[index])

                          ///This condition will check if
                          ///index is present in empty list or not
                          ///if present then change widget according to those index
                          ? AppImages.checkBox
                          : AppImages.unCheckBox)),
                  AppSizeBox.width_2,
                  Text(
                    medicalHistoryTitle[index],
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
        itemCount: medicalHistoryTitle.length);
  });
}
