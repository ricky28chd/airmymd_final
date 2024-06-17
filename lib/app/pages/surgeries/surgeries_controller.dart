import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:get/get.dart';

import '../../../domain/repositories/localstorage_keys.dart';

class SurgeriesController extends GetxController {
  SurgeriesController(this._surgeriesPresenter);
  final SurgeriesPresenter _surgeriesPresenter;

  ///Calender Method============================================================
  ///variable stores default date shown in calender
  var initialDate = DateTime.now();

  selectDate() {
    Get.defaultDialog(
      title: '',
      content: Container(
        // Need to use container to add size constraint.
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 100, 1),
          lastDate: DateTime(DateTime.now().year),
          initialDate: DateTime.now(),
          // save the selected date to _selectedDate DateTime variable.
          // It's used to set the previous selected date when
          // re-showing the dialog.
          selectedDate: initialDate,
          onChanged: (DateTime dateTime) {
            Get.back();
            yearController.text = DateTime(dateTime.year).year.toString();
            initialDate = dateTime;
          },
        ),
      ),
    );
  }

  selectYear(DateTime year) {}

  ///Variable will hold the year in which surgery of user happened.
  var yearController = TextEditingController();

  ///[yearError] will empty if the value will be valid, wanna it will give the
  ///error that field is required
  var yearError = ''.obs;

  void enterYear(String value) {
    if (value.isNotEmpty) {
      yearError.value = '';
    } else {
      yearError.value = 'Year can\'t be empty';
    }
  }

  ///Variable will hold the age on which surgery of user happened.
  var ageController = TextEditingController();

  ///[ageError] will empty if the value will be valid, wanna it will give the
  ///error that field is required
  var ageError = ''.obs;

  void enterAge(String value) {
    if (value.isNotEmpty) {
      ageError.value = '';
    } else {
      ageError.value = 'Age can\'t be empty';
    }
  }

  var surgeriesList = [];

  void addSurgeries(value) {
    if (surgeriesList.contains(value)) {
      surgeriesList.remove(value);
    } else {
      surgeriesList.add(value);
    }
    print(surgeriesList);
    update();
  }

  var navigateFrom = Get.arguments['NavigateFrom'];

  void onSaveButtonClicked() async {
    if (surgeriesList.isNotEmpty &&
        yearController.text.isNotEmpty &&
        ageController.text.isNotEmpty) {
      var response = await _surgeriesPresenter.surgeryUserModel(
        surgery: surgeriesList.join(",").toString(),
        year: yearController.text,
        age: ageController.text,
      );
      if (response.data != null) {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage('Surgeries updated successfully',
              MessageType.success, () => Utility.closeSnackBar(), 'Okay');
        } else {
          NavigateTo.goToMedicationScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        if (surgeriesList.isEmpty &&
            yearController.text.isEmpty &&
            ageController.text.isEmpty) {
          await _surgeriesPresenter.surgeryUserModel(
            surgery: surgeriesList.join(",").toString(),
            year: yearController.text,
            age: ageController.text,
          );
          Get.back();
          Utility.showMessage('Surgeries updated successfully',
              MessageType.success, () => Utility.closeSnackBar(), 'Okay');
        } else {
          if (surgeriesList.isNotEmpty) {
            if (yearController.text.isEmpty) {
              yearError.value = 'Year is required';
            }
            if (ageController.text.isEmpty) {
              ageError.value = 'Age is required';
            }
          } else {
            if (surgeriesList.isEmpty) {
              Utility.showMessage(
                'Please skip if you don\'t have any surgery',
                MessageType.information,
                () => Utility.closeSnackBar(),
                'Okay',
              );
            }
          }
        }
      } else {
        if (surgeriesList.isNotEmpty) {
          if (yearController.text.isEmpty) {
            yearError.value = 'Year is required';
          }
          if (ageController.text.isEmpty) {
            ageError.value = 'Age is required';
          }
        } else {
          if (surgeriesList.isEmpty) {
            Utility.showMessage(
              'Please skip if you don\'t have any surgery',
              MessageType.information,
              () => Utility.closeSnackBar(),
              'Okay',
            );
          }
        }
      }
    }
  }

  var surgeriesResponse =
      Get.find<Repository>().getStringValue(LocalKeys.surgeries);

  var surgeryYear = Get.find<Repository>().getStringValue(LocalKeys.year);

  var surgeryAge = Get.find<Repository>().getStringValue(LocalKeys.age);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (surgeriesResponse.isNotEmpty) {
      final surgList = surgeriesResponse.split(',');
      for (var val in surgList) {
        surgeriesList.add(val.toString());
      }
      if (surgeryYear.isNotEmpty) {
        yearController.text = surgeryYear;
      }
      if (surgeryAge.isNotEmpty) {
        ageController.text = surgeryAge;
      }
    }
  }
}
