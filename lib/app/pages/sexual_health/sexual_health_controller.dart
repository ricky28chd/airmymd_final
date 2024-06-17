import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../domain/repositories/localstorage_keys.dart';

class SexualHealthController extends GetxController {
  SexualHealthController(this._sexualHealthPresenter);
  final SexualHealthPresenter _sexualHealthPresenter;

  ///This is the list in which value of checkbox will gonna store
  ///and if the value will more than 2 that it will
  ///automatically replace first one, in
  ///simple means it will toggle.
  var selectedSexualHealth = [];

  ///This Method is responsible for selecting one item from
  ///that checkbox list and store the value
  ///in above instantiated variable.
  void selectSexualHealth(String value) {
    if (selectedSexualHealth.isNotEmpty) {
      selectedSexualHealth.clear();
      selectedSexualHealth.add(value);
    } else {
      selectedSexualHealth.add(value);
    }
    print(selectedSexualHealth);
    update();
  }

  var navigateFrom = Get.arguments['NavigateFrom'];

  Future<void> onSaveButtonClicked() async {
    if (selectedSexualHealth.isNotEmpty) {
      var response = await _sexualHealthPresenter.sexualHealthUserModel(
        sexualStatus: selectedSexualHealth.join(',').toString(),
      );
      if (response != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage(
            'Sexual health Updated Successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToHealthHabitsScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _sexualHealthPresenter.sexualHealthUserModel(
          sexualStatus: selectedSexualHealth.join(',').toString(),
        );
        Get.back();
        Utility.showMessage(
          'Sexual health Updated Successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        Utility.showMessage(
          'Please skip if you have no sexual activity',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  var sexualHealthResponse =
      Get.find<Repository>().getStringValue(LocalKeys.sexualHealth);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (sexualHealthResponse.isNotEmpty) {
      final sexualList = sexualHealthResponse.split(',');
      for (var val in sexualList) {
        selectedSexualHealth.add(val.toString());
      }
    }
  }
}
