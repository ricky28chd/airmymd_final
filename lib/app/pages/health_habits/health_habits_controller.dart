// ignore_for_file: avoid_print, unused_local_variable

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../domain/repositories/localstorage_keys.dart';

class HealthHabitController extends GetxController {
  HealthHabitController(this._healthHabitsPresenter);
  final HealthHabitsPresenter _healthHabitsPresenter;

  var navigateFrom = Get.arguments['NavigateFrom'];

  ///This is the list in which value of checkbox will gonna store
  ///and if the value will more than 2 that it will
  ///automatically replace first one, in
  ///simple means it will toggle.
  var selectedHealthHabit = [];

  ///This Method is responsible for selecting one item from
  ///that checkbox list and store the value
  ///in above instantiated variable.
  void selectHealthHabit(String value) {
    if (selectedHealthHabit.isNotEmpty) {
      selectedHealthHabit.clear();
      selectedHealthHabit.add(value);
    } else {
      selectedHealthHabit.add(value);
    }
    print(
        selectedHealthHabit.toString().replaceAll('[', '').replaceAll(']', ''));
    update();
  }

  Future<void> onSaveButtonClicked() async {
    if (selectedHealthHabit.isNotEmpty) {
      var response = await _healthHabitsPresenter.healthHabitUserModel(
        healthHabit: selectedHealthHabit.join(',').toString(),
      );
      if (response.data != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage(
            'Health habit updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToGeneralHealthScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        var response = await _healthHabitsPresenter.healthHabitUserModel(
          healthHabit: selectedHealthHabit.join(',').toString(),
        );
        Get.back();
        Utility.showMessage(
          'Health habit updated successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        Utility.showMessage(
          'Please skip if you have no health habit',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  var healthHabitsResponse =
      Get.find<Repository>().getStringValue(LocalKeys.habits);

  @override
  void onInit() {
    super.onInit();
    if (healthHabitsResponse.isNotEmpty) {
      final habitList = healthHabitsResponse.split(',');
      for (var val in habitList) {
        selectedHealthHabit.add(val.toString());
      }
    }
  }
}
