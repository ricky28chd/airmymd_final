import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';

import '../../../domain/entities/enums.dart';

class MedicationController extends GetxController {
  MedicationController(this._medicationPresenter);
  final MedicationPresenter _medicationPresenter;

  var navigateFrom = Get.arguments['NavigateFrom'];

  var medicationList = <Widget>[];
  var drugNameControllerList = <TextEditingController>[];
  var drugNameControllerListError = ''.obs;
  var commentControllerList = <TextEditingController>[];
  var commentControllerListError = ''.obs;

  Widget addMoreMedication({String drugName = '', String comment = ''}) {
    var drugNameController = TextEditingController();
    var commentController = TextEditingController();
    drugNameControllerList.add(drugNameController);
    commentControllerList.add(commentController);
    drugNameController.text = drugName.toString();
    commentController.text = comment.toString();
    return medicationField(
        drugNameController: drugNameController,
        commentController: commentController);
  }

  void removeMedication(index) {
    medicationList.removeAt(index);
    update();
  }

  ///This method will only hit api when [nameControllerList[index=0]] and
  /// [commentControllerList[index=0]]
  Future<void> onSaveButtonClicked() async {
    var medications = <Map<String, dynamic>>[];
    for (int i = 0; i < medicationList.length; i++) {
      var drugName = drugNameControllerList[i].text;
      var comment = commentControllerList[i].text;
      medications.add({'name': drugName, 'reason': comment});
    }

    if (drugNameControllerList[0].text != '' ||
        commentControllerList[0].text != '') {
      var response =
          await _medicationPresenter.medicationUserModel(map: medications);
      if (response.data != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage(
            'medications updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToSexualHealthScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _medicationPresenter.medicationUserModel(map: medications);
        Get.back();
      } else {
        Utility.showMessage(
          'Please skip if you have no medication',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  var isLoading = false;

  Future<void> getMedication() async {
    isLoading = true;
    try {
      var response = await _medicationPresenter.getMedication(
        isLoading: true,
      );
      if (response.data!.isNotEmpty) {
        for (var val in response.data!) {
          medicationList.add(addMoreMedication(
            drugName: val.name.toString(),
            comment: val.reason.toString(),
          ));
        }
      } else {
        medicationList.add(addMoreMedication());
      }
    } finally {
      isLoading = false;
    }
    update();
  }

  @override
  void onInit() {
    if (navigateFrom == 'Setting Screen') {
      getMedication();
    } else {
      medicationList.add(addMoreMedication());
    }

    super.onInit();
  }
}
