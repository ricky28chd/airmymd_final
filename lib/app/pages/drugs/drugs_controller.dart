import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../domain/repositories/localstorage_keys.dart';

class DrugsController extends GetxController {
  DrugsController(this._drugsPresenter);
  final DrugsPresenter _drugsPresenter;

  var navigateFrom = Get.arguments['NavigateFrom'];

  var selectedStreetDrugsList = [];

  void selectStreetDrugs(String value) {
    if (selectedStreetDrugsList.isNotEmpty) {
      selectedStreetDrugsList.clear();
      selectedStreetDrugsList.add(value);
    } else {
      selectedStreetDrugsList.add(value);
    }
    update();
  }

  var selectedNeedleDrugsList = [];

  void selectNeedleDrugs(String value) {
    if (selectedNeedleDrugsList.isNotEmpty) {
      selectedNeedleDrugsList.clear();
      selectedNeedleDrugsList.add(value);
    } else {
      selectedNeedleDrugsList.add(value);
    }
    update();
  }

  Future<void> onSaveButtonClicked() async {
    if (selectedNeedleDrugsList.isNotEmpty ||
        selectedStreetDrugsList.isNotEmpty) {
      var response = await _drugsPresenter.drugUserModel(
        streetDrug: selectedStreetDrugsList.join(',').toString(),
        needleDrug: selectedNeedleDrugsList.join(',').toString(),
      );
      if (response.data != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage(
            'Drug record updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToAddInsuranceScreen(
              id: "0", navigateFrom: 'DrugScreen');
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _drugsPresenter.drugUserModel(
          streetDrug: selectedStreetDrugsList.join(',').toString(),
          needleDrug: selectedNeedleDrugsList.join(',').toString(),
        );
        Get.back();
        Utility.showMessage(
          'Drug record updated successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        Utility.showMessage(
          'Please skip if you haven\'t used drugs',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  var streetDrugsResponse =
      Get.find<Repository>().getStringValue(LocalKeys.streetDrug);

  var needleDrugsResponse =
      Get.find<Repository>().getStringValue(LocalKeys.needleDrug);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (streetDrugsResponse.isNotEmpty) {
      selectedStreetDrugsList.add(streetDrugsResponse);
    }
    if (needleDrugsResponse.isNotEmpty) {
      selectedNeedleDrugsList.add(streetDrugsResponse);
    }
  }
}
