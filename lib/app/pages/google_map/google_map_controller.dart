import 'dart:async';
import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import '../../../domain/models/doctor_list_response.dart';
import 'dart:convert';
import 'package:marker_icon/marker_icon.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../../domain/repositories/localstorage_keys.dart';

class GoogleScreenController extends GetxController
    with GetTickerProviderStateMixin {
  GoogleScreenController(this._googleScreenPresenter);

  ///Variable holds the default location of user
  var userDefaultLocation = '';

  ///Method to get that default location from hive box
  ///[key]identifier for the value stored in hive box
  ///[value]needed data saved in it
  void getUserDefaultLocation() {
    userDefaultLocation =
        Get.find<Repository>().getStringValue(LocalKeys.location);
    userCurrentLocation.text = userDefaultLocation;
  }

  var defaultLat = Get.find<Repository>().getStringValue(LocalKeys.latitude);

  var defaultLong = Get.find<Repository>().getStringValue(LocalKeys.longitude);

  final GoogleScreenPresenter _googleScreenPresenter;

  ///This one is the List of markers for google map.
  final Map<String, Marker> markers = {};

  ///variable holds the current value of user
  var userCurrentLocation = TextEditingController();

  GoogleMapController? googleMapController;

  ///This function helps to show markers on the map and also open
  ///Bottom sheet when click any marker.
  Future<void> onMapCreated(
    googleMapController, {
    String latitude = '',
    String longitude = '',
  }) async {
    await getDoctorList(
      latitude: defaultLatitude,
      longitude: defaultLongitude,
      isLoading: false,
    );

    markers.clear();
    for (int i = 0; i < doctorList.length; i++) {
      if (doctorList[i].profile!.latitude != null &&
          doctorList[i].profile!.longitude != null) {
        final marker = Marker(
          icon: await MarkerIcon.downloadResizePictureCircle(
              doctorList[i].profilePhotoUrl.toString(),
              size: 120,
              addBorder: true,
              borderColor: Colors.white,
              borderSize: 10),
          markerId: MarkerId(doctorList[i].profile!.id.toString()),
          position: LatLng(
              double.parse(doctorList[i].profile!.latitude.toString()),
              double.parse(doctorList[i].profile!.longitude.toString())),
          onTap: () {
            update();
            Get.bottomSheet(BottomSheet(
                constraints: BoxConstraints(maxHeight: Get.height / 2.6),
                backgroundColor: Colors.transparent,
                onClosing: () {},
                builder: (context) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: mapBottomView(
                        initialRating: (doctorList[i].averageRating!.isNotEmpty)
                            ? double.parse(doctorList[i].averageRating!)
                            : 0.0,
                        doctorName:
                            'Dr. ${doctorList[i].profile!.firstName} ${doctorList[i].profile!.lastName}',
                        address:
                            '${doctorList[i].profile!.address} ${doctorList[i].profile!.city} '
                            '${doctorList[i].profile!.state} ${doctorList[i].profile!.zipcode}',
                        decorationImage: doctorList[i].profilePhotoUrl == null
                            ? const DecorationImage(
                                scale: 2,
                                image: AssetImage(AppImages.profileIcon),
                              )
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    '${doctorList[i].profilePhotoUrl}'),
                              ),
                        doctorFee: doctorList[i].profile!.fees.toString(),
                        onTap: () {
                          Get.back();
                          NavigateTo.goToDoctorProfileScreen(
                            doctorId: doctorList[i].id.toString(),
                            specialization: specialization,
                          );
                        },
                        averageRating: doctorList[i].reviews!.length.toString(),
                        onRateTap: () {
                          // NavigateTo.goToReviewsListScreen(
                          //     doctorId: doctorList[i].profile!.id.toString());
                        }),
                  );
                }));
          },
        );
    
        markers[doctorList[i].id.toString()] = marker;
      }
    }
    update();
  }

  ///This is the status of visibility of map and doctorsList screen.
  var doctorLisVisible = true.obs;
  var showMapView = false.obs;

  void showDoctorsList() {
    if (doctorLisVisible.value == false) {
      doctorLisVisible.value = true;
      showMapView.value = false;
    } else {
      doctorLisVisible.value = false;
      showMapView.value = true;
    }
    update();
  }

  ///location search by hitting api=============================================

  ///Variable stores users current city.
  var city = '';

  ///Variable stores users place name.
  var place = '';

  ///Variable stores users current country.
  var country = '';

  ///Variable stores users longitude.
  var defaultLongitude =
      Get.find<Repository>().getStringValue(LocalKeys.longitude);

  ///Variable stores users latitude.
  var defaultLatitude =
      Get.find<Repository>().getStringValue(LocalKeys.latitude);

  List<AutocompletePrediction> predictionList = [];

  ///Method to get user current location after clicking the current location icon
  // Future<void> fetchCurrentLocation() async {
  //   Utility.closeSnackBar();
  //   Utility.showLoader();
  //   try {
  //     var getLocation = await Utility.getCurrentLocation();
  //     city = getLocation.area;
  //     place = getLocation.placeName;
  //     country = getLocation.country;
  //     defaultLongitude = getLocation.longitude.toString();
  //     defaultLatitude = getLocation.latitude.toString();
  //     userCurrentLocation.text = '$place, $city,  $country';

  //     onMapCreated(
  //       googleMapController,
  //       longitude: defaultLongitude,
  //       latitude: defaultLatitude,
  //     );

  //     update();
  //   } finally {
  //     Utility.closeLoader();
  //   }
  // }

  /// Check all kind of permission for location
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utility.showMessage(
          'Location services are disabled. Please enable the services',
          MessageType.information,
          () => Get.back(),
          'Okay');

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
      defaultLongitude = position.longitude.toString();
      defaultLatitude = position.latitude.toString();

      userCurrentLocation.text = '$city, $place, $country';
      onMapCreated(
        googleMapController,
        longitude: defaultLongitude,
        latitude: defaultLatitude,
      );
      update();
    } catch (e) {
    } finally {
      Utility.closeLoader();
    }
  }

  ///This list will hold the value of doctor profile
  List<Datum> doctorList = [];

  var totalCount;

  ///Variable will hold the value specialization selected by user.
  var specialization = Get.arguments['specialization'];

  ///Method ot get doctor list from api hit=====================================
  Future<void> getDoctorList({
    required String latitude,
    required String longitude,
    bool isLoading = true,
  }) async {
    try {
      var response = await _googleScreenPresenter.doctorListUserModel(
        latitude: latitude,
        longitude: longitude,
        specialization: specialization,
        isLoading: isLoading,
      );
      if (response.data != null && response.data != null) {
        totalCount = response.data!.total;
        doctorList = response.data!.data!;
      }
    } catch (e) {
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
        userCurrentLocation.text = details.result!.formattedAddress!;
        defaultLatitude = details.result!.geometry!.location!.lat.toString();
        defaultLongitude = details.result!.geometry!.location!.lng.toString();
        onMapCreated(
          googleMapController,
          latitude: details.result!.geometry!.location!.lat.toString(),
          longitude: details.result!.geometry!.location!.lng.toString(),
        );
        predictionList = [];
        Get.back();
        update();
      }
    }
  }

  Future<void> autoCompleteSubmit() async {
    if (userCurrentLocation.text.isNotEmpty) {
      await getLatLongThroughAdress(address: userCurrentLocation.text);

      onMapCreated(
        googleMapController,
        latitude: defaultLatitude,
        longitude: defaultLongitude,
      );
    } else {
      onMapCreated(
        googleMapController,
        latitude: '',
        longitude: '',
      );
    }
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

  ///This method will call only one time and at very first time.
  @override
  void onInit() async {
    super.onInit();
    getUserDefaultLocation();
    getDoctorList(
      latitude: defaultLatitude,
      longitude: defaultLongitude,
    );
    autoLocationFocusNode = FocusNode();
    googlePlace = GooglePlace(PageConstants.googleApiKey);
  }

  Future<void> onRefreshList() async => getDoctorList(
        latitude: defaultLatitude,
        longitude: defaultLongitude,
        isLoading: false,
      );

  @override
  void dispose() {
    super.dispose();
    autoLocationFocusNode.dispose();
  }

  Future getLatLongThroughAdress({required String address}) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://maps.google.com/maps/api/geocode/json?sensor=false&address=${address}&key=${PageConstants.googleApiKey}"),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          }).timeout(const Duration(seconds: 60));

      var respnseData = jsonDecode(response.body);
      var resultsArr = respnseData["results"];

      for (var obj in resultsArr) {
        defaultLatitude = obj["geometry"]["location"]["lat"]
            .toString(); //String(obj["geometry"]["location"]["lat"].double!)
        defaultLongitude = obj["geometry"]["location"]["lng"]
            .toString(); //String(obj["geometry"]["location"]["lng"].double!)
      }

      Utility.closeLoader();
    } on TimeoutException catch (_) {
      Utility.closeDialog();
    }
  }
}
