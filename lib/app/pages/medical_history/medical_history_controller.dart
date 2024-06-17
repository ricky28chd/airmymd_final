import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';

import '../../../domain/entities/enums.dart';
import '../../../domain/repositories/localstorage_keys.dart';
import '../../../domain/repositories/repository.dart';

class MedicalHistoryController extends GetxController {
  MedicalHistoryController(this._medicalHistoryPresenter);
  final MedicalHistoryPresenter _medicalHistoryPresenter;

  var navigateFrom = Get.arguments == null ? '' : Get.arguments['NavigateFrom'];

  var medicalHistoryList = [];

  void addHistory(value) {
    if (medicalHistoryList.contains(value)) {
      medicalHistoryList.remove(value);
    } else {
      medicalHistoryList.add(value);
    }
    update();
  }

  onSaveButtonClicked() async {
    if (medicalHistoryList.isNotEmpty) {
      var response = await _medicalHistoryPresenter.medicalHistoryUserModel(
          medicalHistory: medicalHistoryList.join(",").toString());
      if (response.data != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Utility.closeLoader();
          Get.back();
          Utility.showMessage(
            'Medical history updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToSurgeriesScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _medicalHistoryPresenter.medicalHistoryUserModel(
            medicalHistory: medicalHistoryList.join(",").toString());
        Get.back();
        Utility.showMessage(
          'Medical history updated successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        Utility.showMessage(
          'Please skip if you have no medical history',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  void getMediCalHistory() {
    medicalHistoryList.clear();

    var medicalHistoryResponse =
        Get.find<Repository>().getStringValue(LocalKeys.medicalHistory);
    print('medical history -========---====$medicalHistoryResponse');
    if (medicalHistoryResponse.isNotEmpty) {
      final medList = medicalHistoryResponse.split(',');
      for (var val in medList) {
        medicalHistoryList.add(val.toString());
      }
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getMediCalHistory();
  }
}
