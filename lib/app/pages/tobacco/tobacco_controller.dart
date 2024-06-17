import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:intl/intl.dart';

class TobaccoController extends GetxController {
  TobaccoController(this._tobaccoPresenter);
  final TobaccoPresenter _tobaccoPresenter;

  ///variable will hold the date/pack of the user
  var datePackController = TextEditingController();

  var datePackControllerError = ''.obs;

  void enterDatePack(String value) {
    if (value.isNotEmpty || datePackController.text.trim().isNotEmpty) {
      datePackControllerError.value = '';
    }
  }

  ///Calender Method============================================================
  ///variable stores default date shown in calender
  var initialDate = DateTime.now();
  void selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryColor,
                  onPrimary: AppColors.whiteColor,
                  onSurface: AppColors.blackColor,
                ),
              ),
              child: child!);
        });
    if (selected != null) {
      datePackControllerError.value = '';
      initialDate = selected;
      datePackController.text = DateFormat('yyyy-MM-dd').format(selected);
      update();
    }
  }

  ///variable will hold the date/pack of the user
  var ageYearController = TextEditingController();

  var ageYearControllerError = ''.obs;

  void enterAge(String value) {
    if (value.isNotEmpty) {
      ageYearControllerError.value = '';
    }
  }

  ///variable will carry the previous path of user from which page user came.
  var navigateFrom = Get.arguments['NavigateFrom'];

  ///This is the list in which value of checkbox will gonna store
  ///and if the value will more than 2 that it will
  ///automatically replace first one, in
  ///simple means it will toggle.
  var selectedTobacco = [];

  ///This Method is responsible for selecting one item from
  ///that checkbox list and store the value
  ///in above instantiated variable.
  void selectTobacco(String value) {
    datePackController.clear();
    ageYearController.clear();
    if (selectedTobacco.isNotEmpty) {
      selectedTobacco.clear();
      selectedTobacco.add(value);
    } else {
      selectedTobacco.add(value);
    }
    print(selectedTobacco);
    update();
  }

  var selectOtherTobaccoList = [];

  void selectOtherTobacco(String value) {
    if (selectOtherTobaccoList.contains(value)) {
      selectOtherTobaccoList.remove(value);
    } else {
      selectOtherTobaccoList.add(value);
    }
    print(selectOtherTobaccoList);
    update();
  }

  Future<void> onSaveButtonClicked() async {
    if (selectedTobacco.contains('Quit') ||
        selectedTobacco.contains('Current Smoker')) {
      if (datePackController.text.isNotEmpty &&
          ageYearController.text.isNotEmpty) {
        var response = await _tobaccoPresenter.saveTobacco(
          cigarette: {
            "selection": selectedTobacco.join(',').toString(),
            "date/packs": datePackController.text.toString(),
            "age/years": ageYearController.text.toString(),
            "packs": "",
            "years": ""
          },
          tobacco: selectOtherTobaccoList.join(',').toString(),
          isLoading: true,
        );
        if (response.data != null) {
          Get.find<AllProfileController>().getUserProfile(isLoading: false);
          if (navigateFrom == 'Setting Screen') {
            Get.back();
            Utility.showMessage(
              'Tobacco details updated successfully',
              MessageType.success,  
              () => Utility.closeSnackBar(),
              'Okay',
            );
          } else {
            NavigateTo.goToAlcoholScreen();
          }
        }
      } else {
        if (datePackController.text.isEmpty) {
          datePackControllerError.value = 'Required';
        }
        if (ageYearController.text.isEmpty) {
          ageYearControllerError.value = 'Required';
        }
      }
    } else if (selectedTobacco.isNotEmpty ||
        selectOtherTobaccoList.isNotEmpty) {
      var response = await _tobaccoPresenter.saveTobacco(
        cigarette: {
          "selection": selectedTobacco.join(',').toString(),
          "date/packs": datePackController.text.toString(),
          "age/years": ageYearController.text.toString(),
          "packs": "",
          "years": ""
        },
        tobacco: selectOtherTobaccoList.join(',').toString(),
        isLoading: true,
      );
      if (response.data != null) {
        if (navigateFrom == 'Setting Screen') {
          Get.back();
          Utility.showMessage(
            'Tobacco details updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {
          NavigateTo.goToAlcoholScreen();
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _tobaccoPresenter.saveTobacco(
          cigarette: {
            "selection": selectedTobacco.join(',').toString(),
            "date/packs": datePackController.text.toString(),
            "age/years": ageYearController.text.toString(),
            "packs": "",
            "years": ""
          },
          tobacco: selectOtherTobaccoList.join(',').toString(),
          isLoading: true,
        );
      } else {
        Utility.showMessage(
          'Please skip if you haven\'t used tobacco',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  Future<void> getCigarette() async {
    var response = await _tobaccoPresenter.getCigarette(
      isLoading: true,
    );
    if (response.data != null) {
      Utility.closeDialog();
      selectedTobacco.add(response.data!.cigarette!.selection.toString());
      datePackController.text = response.data!.cigarette!.datePacks.toString();
      ageYearController.text = response.data!.cigarette!.ageYears.toString();
      var othersTobacco = response.data!.tobacco.toString().split(',');
      for (var val in othersTobacco) {
        selectOtherTobaccoList.add(val);
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    if (navigateFrom == 'Setting Screen') {
      getCigarette();
    }
  }
}
