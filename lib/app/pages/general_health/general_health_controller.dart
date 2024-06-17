import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';

import '../../../domain/entities/enums.dart';
import '../../../domain/repositories/localstorage_keys.dart';
import '../../../domain/repositories/repository.dart';

class GeneralHealthController extends GetxController {
  GeneralHealthController(this._generalHealthPresenter);
  final GeneralHealthPresenter _generalHealthPresenter;

  var navigateFrom = Get.arguments['NavigateFrom'];

  ///This is the list in which value of checkbox will gonna store
  ///and if the value will more than 2 that it will
  ///automatically replace first one, in
  ///simple means it will toggle.
  var selectedGeneralHealth = [];

  var selectedGeneralHealthError = '';

  ///This Method is responsible for selecting one item from
  ///that checkbox list and store the value
  ///in above instantiated variable.
  void selectGeneralHealth(String value) {
    if (selectedGeneralHealth.contains(value)) {
      selectedGeneralHealth.remove(value);
    } else {
      selectedGeneralHealth.add(value);
    }
    update();
  }

  var selectSkinList = [];

  var selectSkinListError = '';

  void selectSkin(String value) {
    if (selectSkinList.contains(value)) {
      selectSkinList.remove(value);
    } else {
      selectSkinList.add(value);
    }

    update();
  }

  var selectEyeThroatList = [];

  var selectEyeThroatListError = '';

  void selectEyeThroat(String value) {
    if (selectEyeThroatList.contains(value)) {
      selectEyeThroatList.remove(value);
    } else {
      selectEyeThroatList.add(value);
    }

    update();
  }

  Future<void> onSaveButtonClicked() async {
    if (selectedGeneralHealth.isNotEmpty ||
        selectSkinList.isNotEmpty ||
        selectEyeThroatList.isNotEmpty) {
      var response = await _generalHealthPresenter.generalHealthUserModel(
        general: selectedGeneralHealth.join(',').toString(),
        skinProblem: selectSkinList.join(',').toString(),
        eyeEarProblem: selectEyeThroatList.join(',').toString(),
      );
      if (response.returnCode != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage(
            'General Health Updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToTobaccoScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _generalHealthPresenter.generalHealthUserModel(
          general: selectedGeneralHealth.join(',').toString(),
          skinProblem: selectSkinList.join(',').toString(),
          eyeEarProblem: selectEyeThroatList.join(',').toString(),
        );
        NavigateTo.goToProfileSettingScreen();
        Utility.showMessage(
          'General Health Updated successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        Utility.showMessage(
          'Please skip if have no general health issues',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  var generalResponse =
      Get.find<Repository>().getStringValue(LocalKeys.general);

  var skinResponse = Get.find<Repository>().getStringValue(LocalKeys.skin);

  var eyesResponse = Get.find<Repository>().getStringValue(LocalKeys.eyes);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (generalResponse.isNotEmpty) {
      final generalList = generalResponse.split(',');
      for (var val in generalList) {
        selectedGeneralHealth.add(val.toString());
      }
    }
    if (skinResponse.isNotEmpty) {
      final skinList = skinResponse.split(',');
      for (var val in skinList) {
        selectSkinList.add(val.toString());
      }
    }
    if (eyesResponse.isNotEmpty) {
      final eyesList = eyesResponse.split(',');
      for (var val in eyesList) {
        selectEyeThroatList.add(val.toString());
      }
    }
  }
}
