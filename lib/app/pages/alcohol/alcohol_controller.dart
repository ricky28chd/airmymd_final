import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../domain/repositories/localstorage_keys.dart';

class AlcoholController extends GetxController {
  AlcoholController(this._alcoholPresenter);

  var navigateFrom = Get.arguments['NavigateFrom'];

  final AlcoholPresenter _alcoholPresenter;

  ///This is the list in which value of checkbox will gonna store
  ///and if the value will more than 2 that it will
  ///automatically replace first one, in
  ///simple means it will toggle.
  ///
  /// [selectedAlcoholList] Variable will hold the status of user that
  /// he drinks or not.=========================================================
  var selectedAlcoholList = [];

  ///Variable will empty if the value input will be valid.
  var selectedAlcoholListError = '';

  ///This Method is responsible for selecting one item from
  ///that checkbox list and store the value
  ///in above instantiated variable.

  void selectAlcohol(String value) {
    if (selectedAlcoholList.isNotEmpty) {
      selectedAlcoholList.clear();
      selectedAlcoholList.add(value);
    } else {
      selectedAlcoholList.add(value);
    }
    update();
  }

  ///These variables will hold the values of different types of
  ///drink user used to drink in a week.
  ///[beerController] will hold the value for drinking beer.
  var beerController = TextEditingController();

  ///[beerControllerError] will be empty if the value will be valid.
  var beerControllerError = ''.obs;

  ///Method will check if the value of drinking beer will empty or not,
  ///if value will empty [beerControllerError] will not empty.
  void enterBeerValue(String value) {
    if (value.isNotEmpty ||
        wineController.text.isNotEmpty ||
        mixedController.text.isNotEmpty) {
      beerControllerError.value = '';
      wineControllerError.value = '';
      mixedControllerError.value = '';
    } else {
      beerControllerError.value = '   ';
      wineControllerError.value = '   ';
      mixedControllerError.value = 'The value can\'t be empty';
    }
  }

  ///[wineController] will hold the value for drinking wine.
  var wineController = TextEditingController();

  ///[wineControllerError] will be empty if the value will be valid.
  var wineControllerError = ''.obs;

  ///Method will check if the value of drinking wine will empty or not,
  ///if value will empty [wineControllerError] will not empty.
  void enterWineValue(String value) {
    if (value.isNotEmpty ||
        beerController.text.isNotEmpty ||
        mixedController.text.isNotEmpty) {
      wineControllerError.value = '';
      beerControllerError.value = '';
      mixedControllerError.value = '';
    } else {
      beerControllerError.value = '   ';
      wineControllerError.value = '   ';
      mixedControllerError.value = 'The value can\'t be empty';
    }
  }

  ///[mixedController] will hold the value for drinking mixed drinks.
  var mixedController = TextEditingController();

  ///[mixedControllerError] will be empty if the value will be valid.
  var mixedControllerError = ''.obs;

  ///Method will check if the value of drinking mixed will empty or not,
  ///if value will empty [mixedControllerError] will not empty.
  void enterMixedValue(String value) {
    if (value.isNotEmpty ||
        beerController.text.isNotEmpty ||
        wineController.text.isNotEmpty) {
      mixedControllerError.value = '';
      beerControllerError.value = '';
      wineControllerError.value = '';
    } else {
      beerControllerError.value = '   ';
      wineControllerError.value = '   ';
      mixedControllerError.value = 'The value can\'t be empty';
    }
  }

  ///Variable hold the amount of alcohol if user drunk more than 4 drink in one day
  ///for this reason the field is not mandatory, It might be possible that user will not
  ///drink more than 4 drinks in a day.
  var inADayController = TextEditingController();

  var selectedCutDownList = [];

  void selectCutDown(String value) {
    if (selectedCutDownList.isNotEmpty) {
      selectedCutDownList.clear();
      selectedCutDownList.add(value);
    } else {
      selectedCutDownList.add(value);
    }
    update();
  }

  var selectedGuiltyList = [];

  void selectGuilty(String value) {
    if (selectedGuiltyList.isNotEmpty) {
      selectedGuiltyList.clear();
      selectedGuiltyList.add(value);
    } else {
      selectedGuiltyList.add(value);
    }
    update();
  }

  var selectedMorningDrinkList = [];

  void selectMorningDrink(String value) {
    if (selectedMorningDrinkList.isNotEmpty) {
      selectedMorningDrinkList.clear();
      selectedMorningDrinkList.add(value);
    } else {
      selectedMorningDrinkList.add(value);
    }
    update();
  }

  Future<void> onSaveButtonClicked() async {
    if (selectedAlcoholList.isNotEmpty) {
      if (selectedAlcoholList[0] != 'No') {
        if (beerController.text.isNotEmpty ||
            wineController.text.isNotEmpty ||
            mixedController.text.isNotEmpty &&
                selectedCutDownList.isNotEmpty &&
                selectedGuiltyList.isNotEmpty &&
                selectedMorningDrinkList.isNotEmpty) {
          var response = await _alcoholPresenter.alcoholUserModel(
            drinkAlcohol: selectedAlcoholList.join(',').toString(),
            howMany:
                '${beerController.text},${wineController.text},${mixedController.text}',
            inADay: inADayController.text,
            cutDown: selectedCutDownList.join(',').toString(),
            feltGuilty: selectedGuiltyList.join(',').toString(),
            morningDrink: selectedMorningDrinkList.join(',').toString(),
          );
          if (response.data != null) {
            Get.find<AllProfileController>().getUserProfile(isLoading: false);
            if (navigateFrom == 'Setting Screen') {
              Get.back();
              Utility.showMessage(
                'Alcohol record updated successfully',
                MessageType.success,
                () => Utility.closeSnackBar(),
                'Okay',
              );
            } else {
              NavigateTo.goToDrugScreen();
            }
          }
        } else {
          if (mixedController.text.isEmpty) {
            beerControllerError.value = '      ';
          }
          if (mixedController.text.isEmpty) {
            wineControllerError.value = '       ';
          }
          if (mixedController.text.isEmpty) {
            mixedControllerError.value =
                'Please enter the value in one of these fields';
          }
          if (selectedCutDownList.isEmpty &&
              selectedGuiltyList.isEmpty &&
              selectedMorningDrinkList.isEmpty) {
            Utility.showMessage(
              'Please select one option from each field',
              MessageType.information,
              () => Utility.closeSnackBar(),
              'Okay',
            );
          }
        }
      } else {
        var response = await _alcoholPresenter.alcoholUserModel(
          drinkAlcohol: selectedAlcoholList.join(',').toString(),
          howMany: '',
          inADay: '',
          cutDown: '',
          feltGuilty: '',
          morningDrink: '',
        );
        if (response.data != null) {
          if (navigateFrom == 'Setting Screen') {
            Get.back();
            Utility.showMessage(
              'Alcohol record updated successfully',
              MessageType.success,
              () => Utility.closeSnackBar(),
              'Okay',
            );
          } else {
            NavigateTo.goToDrugScreen();
          }
        }
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        await _alcoholPresenter.alcoholUserModel(
          drinkAlcohol: selectedAlcoholList.join(',').toString(),
          howMany:
              '${beerController.text},${wineController.text},${mixedController.text}',
          inADay: inADayController.text,
          cutDown: selectedCutDownList.join(',').toString(),
          feltGuilty: selectedGuiltyList.join(',').toString(),
          morningDrink: selectedMorningDrinkList.join(',').toString(),
        );
        Get.back();
        Utility.showMessage(
          'Alcohol record updated successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        Utility.showMessage(
          'Please skip if you don\'t drink alcohol',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
    }
  }

  var alcoholResponse =
      Get.find<Repository>().getStringValue(LocalKeys.drinkAlcohol);

  var howManyResponse =
      Get.find<Repository>().getStringValue(LocalKeys.howMany);

  var inADayResponse =
      Get.find<Repository>().getStringValue(LocalKeys.drinksInDay);

  var cutDownResponse =
      Get.find<Repository>().getStringValue(LocalKeys.cutDown);

  var feltGuiltyResponse =
      Get.find<Repository>().getStringValue(LocalKeys.feltGuilty);

  var morningDrinkResponse =
      Get.find<Repository>().getStringValue(LocalKeys.morningDrink);

  @override
  void onInit() {
    super.onInit();
    if (alcoholResponse.isNotEmpty) {
      final alcoholList = alcoholResponse.split(',');
      for (var val in alcoholList) {
        selectedAlcoholList.add(val.toString());
      }
    }
    if (howManyResponse.isNotEmpty) {
      final howManyList = howManyResponse.split(',');
      beerController.text = howManyList[0].toString();
      wineController.text = howManyList[1].toString();
      mixedController.text = howManyList[2].toString();
    }
    if (inADayResponse.isNotEmpty) {
      inADayController.text = inADayResponse;
    }
    if (cutDownResponse.isNotEmpty) {
      selectedCutDownList.add(cutDownResponse);
    }
    if (feltGuiltyResponse.isNotEmpty) {
      selectedGuiltyList.add(feltGuiltyResponse);
    }
    if (morningDrinkResponse.isNotEmpty) {
      selectedMorningDrinkList.add(morningDrinkResponse);
    }
  }
}
