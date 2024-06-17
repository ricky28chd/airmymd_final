import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:open_settings/open_settings.dart';

class SetLocationController extends GetxController {
  SetLocationController(this._setLocationPresenter);
  final SetLocationPresenter _setLocationPresenter;

  var naviagteFrom = Get.arguments['NavigateFrom'];
  var userFirstName = '';
  Future<void> getUserProfile() async {
    var response = await _setLocationPresenter.getUserProfile(isLoading: true);
    if (response.returnCode == 1) {
      Utility.closeDialog();

      userFirstName = response.patientProfile.firstName.toString();
    }
    update();
  }

  ///Variable stores user current location.
  var locationController = TextEditingController();

  ///[locationError] will null if [locationController] is valid.
  /// [locationError.value] text will shown when the user try to pass empty value in field.
  /// [debugPrint] to print step by step.

  var locationError = ''.obs;

  ///Method to validate locationField.
  void enterLocation(String value) {
    if (value.isNotEmpty) {
      locationError.value = '';
    } else {
      locationError.value = 'Location can\'t be empty';
      debugPrint('email ${locationController.text}');
    }
  }

  ///Variable stores users current city.
  var city = '';

  ///Variable stores users place name.
  var place = '';

  ///Variable stores users current country.
  var country = '';

  ///Variable stores users longitude.
  var longitude = '';

  ///Variable stores users latitude.
  var latitude = '';

  /// Check all kind of permission for location
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      OpenSettings.openLocationSourceSetting();
      // Utility.showMessage(
      //     'Location services are disabled. Please enable the services',
      //     MessageType.information,
      //     () => Get.back(),
      //     'Okay');

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utility.showMessage('Location permissions are denied',
            MessageType.information, () => Get.back(), 'Okay');

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utility.showMessage(
          'Location permissions are permanently denied, we cannot request permissions.',
          MessageType.information,
          () => Get.back(),
          'Okay');

      return false;
    }
    return true;
  }

  ///Method to get user current location after clicking the current location icon
  void fetchCurrentLocation() async {
    // Utility.showLoader();
    // print('i am herrrrerereeee in pta ni================================');
    // Future.delayed(const Duration(seconds: 20), () {
    //   Utility.closeDialog();
    // });
    try {
      Utility.showLoader();
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) return;

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      var getLocation = await Utility.getAddressThroughLatLng(
          position.latitude, position.longitude);

      city = getLocation!.street!;
      place = getLocation.administrativeArea!;
      country = getLocation.country!;
      longitude = position.longitude.toString();
      latitude = position.latitude.toString();

      locationController.text = '$city, $place, $country';
      update();
    } catch (e) {
      print('exception is =====================>>>>>>>>>>>>>> $e');
    } finally {
      print('i am herrrrerereeee in finally================================');
      Utility.closeLoader();
    }
  }

  ///Method to get lat and long of any address object
  Future<void> getLatAndLong(String address) async {
    var location = await locationFromAddress(address);

    longitude = location[0].longitude.toString();
    latitude = location[0].latitude.toString();
  }

  var query = '';
  var sessionToken;
  var apiClient;

  ///Reset all values.
  void resetAllValues() {
    locationController.clear();
    city = '';
    country = '';
  }

  var navigateFrom = Get.arguments['NavigateFrom'];

  ///set Location Api call
  void onContinueButtonClicked() async {
    if (locationController.text.isNotEmpty) {
      //await getLatAndLong(locationController.text);
      if (latitude != '') {
        Get.find<Repository>().saveValue(LocalKeys.longitude, longitude);
        Get.find<Repository>().saveValue(LocalKeys.latitude, latitude);
        var response = await _setLocationPresenter.locationUserModel(
            location: locationController.text,
            longitude: longitude,
            latitude: latitude);
        if (response.data != null) {
          if (navigateFrom == 'Setting screen') {
            NavigateTo.goToProfileSettingScreen();
            Utility.showMessage('Location Update successfully',
                MessageType.success, () => Utility.closeSnackBar(), 'Okay');
          } else {
            if (userFirstName.isEmpty) {
              NavigateTo.goToBuildProfileScreen();
            } else {
              NavigateTo.goToFindDoctorScreen();
            }
          }

          resetAllValues();
        }
      } else {
        locationError.value = 'Please select location from list';
      }
    } else {
      locationError.value = 'Enter location';
    }
  }

  final Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<AutocompletePrediction> predictionList = [];

  ///auto complete location hint==================================================
  ///
  ///variable initialize to use later, variable will give place service.
  late GooglePlace googlePlace;

  ///this is timer to control the output duration for auto location api call.
  Timer? _debounce;

  ///This is the focus node for auto complete text field.
  late FocusNode autoLocationFocusNode;

  ///onTap method for selecting tile from the list appear for auto complete location field.
  void onTapMethod(index) async {
    final placeId = predictionList[index].placeId!;
    final details = await googlePlace.details.get(placeId);
    if (details != null && details.result != null) {
      if (autoLocationFocusNode.hasFocus) {
        locationController.text = details.result!.formattedAddress!;
        latitude = details.result!.geometry!.location!.lat.toString();
        longitude = details.result!.geometry!.location!.lng.toString();
        predictionList = [];
        FocusManager.instance.primaryFocus!.unfocus();
        Get.back();
        update();
      }
    }
  }

  Future<void> autoCompleteSubmit() async {
    getLatLong(address: locationController.text);
    // await getLatAndLong(locationController.text);
    Get.back();
  }

  ///Onchange method so for auto complete textField for location.
  void typeHeadOnchange(String value) {
    enterLocation(value);
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        autoCompleteSearch(value);
      } else {
        //clear value
      }
    });
  }

  ///Method to get the list of location according to the user input value.
  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      print(result.predictions!.first.description);
      predictionList = result.predictions!;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserProfile();
    autoLocationFocusNode = FocusNode();
    googlePlace = GooglePlace(PageConstants.googleApiKey);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    autoLocationFocusNode.dispose();
  }

  Future getLatLong({required String address}) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://maps.google.com/maps/api/geocode/json?sensor=false&address=$address&key=${PageConstants.googleApiKey}"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          }).timeout(const Duration(seconds: 60));

      print(response.statusCode);
      print(response.body);

      var respnseData = jsonDecode(response.body);
      var resultsArr = respnseData["results"];

      for (var obj in resultsArr) {
        latitude = obj["geometry"]["location"]["lat"]
            .toString(); //String(obj["geometry"]["location"]["lat"].double!)
        longitude = obj["geometry"]["location"]["lng"]
            .toString(); //String(obj["geometry"]["location"]["lng"].double!)
      }

      Utility.closeLoader();
    } on TimeoutException catch (_) {
      Utility.closeDialog();
    }
  }
}
