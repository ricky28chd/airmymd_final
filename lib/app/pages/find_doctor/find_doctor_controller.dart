import 'dart:async';
import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/models/specialization_list_response.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';

import '../../../domain/repositories/localstorage_keys.dart';
import '../../../domain/repositories/repository.dart';

class FindDoctorController extends GetxController {
  FindDoctorController(this._findDoctorPresenter);
  final FindDoctorPresenter _findDoctorPresenter;

  var userDefaultLocation =
      Get.find<Repository>().getStringValue(LocalKeys.location);

  var defaultLat = Get.find<Repository>().getStringValue(LocalKeys.latitude);

  var defaultLong = Get.find<Repository>().getStringValue(LocalKeys.longitude);

  List<Datum> specializationList = [];
  List<Datum> serverSpecializationList = [];

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  var searchByLocationController = TextEditingController();

  ///Variable stores users current city.
  var city = '';

  ///Variable stores users place Name.
  var place = '';

  ///Variable stores users current country.
  var country = '';

  ///Variable stores users longitude.
  var longitude = '';

  ///Variable stores users latitude.
  var latitude = '';

  List<AutocompletePrediction> predictionList = [];

  ///Method to get user current location after clicking the current location icon
  void fetchCurrentLocation() async {
    Utility.closeSnackBar();
    Utility.showLoader();
    try {
      var getLocation = await Utility.getCurrentLocation();

      city = getLocation.area;
      place = getLocation.placeName;
      country = getLocation.country;
      longitude = getLocation.longitude.toString();
      latitude = getLocation.latitude.toString();
      searchByLocationController.text = '$place, $city,  $country';
      getSpecializationList(latitude: latitude, longitude: longitude);
      update();
    } finally {
      Utility.closeLoader();
    }
  }

  ///Method to get lat and long of any address object
  Future<void> getLatAndLong(String address) async {
    var location = await locationFromAddress(address);
    print(location[0].latitude);
    longitude = location[0].longitude.toString();
    latitude = location[0].latitude.toString();
  }

  var searchFeildController = TextEditingController();
  var emptyResult = '';

// This function is called whenever the text field changes
  void runFilter(String enteredKeyword) {
    List<Datum> results = [];
    if (enteredKeyword.isEmpty) {
      emptyResult = '';
      // if the search field is empty or only contains white-space, we'll display all users
      results = serverSpecializationList;
      if (results.isNotEmpty) {
        emptyResult = '';
      } else {
        emptyResult =
            'No specialist available at this location please try some other location';
      }
    } else {
      results = serverSpecializationList
          .where((user) => user.name
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      if (results.isNotEmpty) {
        emptyResult = '';
      } else {
        emptyResult =
            'No specialist available at this location please try some other location';

        update();
      }
      // we use the toLowerCase() method to make it case-insensitive
    }
    specializationList = results;
    update();
  }

  // void searchByName(String query) {
  //   var suggestions=specializationList.where((specialist) {
  //     final specializationName=specialist.name.toString().toLowerCase();
  //     final input=query.toLowerCase();
  //     return specializationName.contains(input);
  //   }).toList();
  //   specializationList=suggestions;
  //   update();
  // }

  /// isLoading
  bool isLoading = true;

  ///variable will store the string to show when there is no specialist available
  var specialistError = '';

  Future<void> getSpecializationList({
    required String latitude,
    required String longitude,
  }) async {
    try {
      specializationList.clear();
      var response = await _findDoctorPresenter.specializationUserModel(
        latitude: latitude,
        longitude: longitude,
        isLoading: false,
      );
      if (response.data != null) {
        for (var val in response.data!) {
          if (val.count! > 0) {
            specialistError = '';
            specializationList.add(val);
          } else {
            emptyResult =
                'No specialist available at this location please try some other location';
          }
        }
        serverSpecializationList = specializationList;
      }
    } catch (e) {
      isLoading = true;
      debugPrint(e.toString());
    }

    update();
  }

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
        searchByLocationController.text = details.result!.formattedAddress!;
        latitude = details.result!.geometry!.location!.lat.toString();
        longitude = details.result!.geometry!.location!.lng.toString();
        getSpecializationList(
          latitude: details.result!.geometry!.location!.lat.toString(),
          longitude: details.result!.geometry!.location!.lng.toString(),
        );
        userDefaultLocation = searchByLocationController.text;
        predictionList = [];
        Get.back();
        update();
      }
    }
  }

  Future<void> autoCompleteSubmit() async {
    if (searchByLocationController.text.isNotEmpty) {
      await getLatAndLong(searchByLocationController.text);
      await getSpecializationList(
        latitude: latitude,
        longitude: longitude,
      );
      userDefaultLocation = searchByLocationController.text;
    } else {
      await getSpecializationList(
        latitude: '',
        longitude: '',
      );
    }
    Get.back();
  }

  ///Onchange method so for auto complete textField for location.
  void autoCompleteOnchange(String value) {
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

  Future<void> onRefresh() async {
    searchFeildController.clear();
    getSpecializationList(
      latitude: defaultLat,
      longitude: defaultLong,
    );
    update();
  }

  Future<void> readNotification() async {
    var response = await _findDoctorPresenter.readNotification(
      isLoading: true,
    );
    if (response.data != null) {
      notificationCount = 0;
      update();
    }
  }

  Future<void> readMessages() async {
    var response = await _findDoctorPresenter.readMessages(
      isLoadig: true,
    );
    if (response.data != null) {
      unreadMessage = 0;
      update();
    }
  }

  Future<void> unreadMessages() async {
    var response = await _findDoctorPresenter.unreadMessages(
      isLoading: true,
    );
    if (response.data != null) {
      unreadMessage = response.data!;
    }
    update();
  }

  Future<void> getNotificationList() async {
    var response = await _findDoctorPresenter.getNotificationList(
      isLoading: false,
    );
    if (response.data != null) {
      notificationCount = response.data!.unreadCount!;
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();

    autoLocationFocusNode = FocusNode();
    googlePlace = GooglePlace(PageConstants.googleApiKey);
    getSpecializationList(
      latitude: defaultLat,
      longitude: defaultLong,
    );
    getNotificationList();
    unreadMessages();
    update();
  }

  @override
  void dispose() {
    super.dispose();
    autoLocationFocusNode.dispose();
  }
}
