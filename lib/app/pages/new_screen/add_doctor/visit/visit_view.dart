import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/visit/widget/widget_view.dart';

import '../../add_visit/add_visit_controller.dart';

class VisitView extends StatelessWidget {
  const VisitView({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //GetBuilder<AddVisitController>(builder: (controller) {
        //return
        Scaffold(
      appBar: AppBar(
        title: const Text(
          'Visits',
          style: AppTextStyle.appBarHeading,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  try {
                    Get.put(AddVisitController()).storeVisitId = 0;

                    Get.put(AddVisitController()).notesController.clear();
                    Get.put(AddVisitController()).imageList.clear();
                    Get.put(AddVisitController()).controller.clear();
                    Get.put(AddVisitController()).timeController.clear();
                    Get.put(AddVisitController()).nameControllerList.clear();
                    Get.put(AddVisitController()).commentControllerList.clear();
                    Get.put(AddVisitController()).medImgList.clear();
                    Get.put(AddVisitController()).foodAllergyList.clear();
                    Get.put(AddVisitController()).foodAllergyList.clear();
                    Get.put(AddVisitController())
                        .foodAllergyList
                        .add(Get.put(AddVisitController()).addFoodAllergies());
                    Get.put(AddVisitController()).medImgList.add("");
                    Get.put(AddVisitController()).update();
                    NavigateTo.goToAddVisit();
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Icon(Icons.add_circle_outline,
                    size: 35, color: Colors.white)),
          ),
        ],
      ),
      body: const VisidWidet(),
    );
    // });
  }
}
