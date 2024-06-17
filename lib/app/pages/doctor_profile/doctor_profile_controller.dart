import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/entities/enums.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/models/last_booking_response.dart';

import '../../../domain/models/doctor_detail_response.dart' as docdetail;

class DoctorProfileController extends GetxController {
  DoctorProfileController(this._doctorProfilePresenter);
  final DoctorProfilePresenter _doctorProfilePresenter;

  ///variable holds the doctorId, whose profile user want to see
  var doctorId = Get.arguments['doctorId'];

  var specialization = Get.arguments['specialization'];

  ///variable will carry all response data come from get doctor detail
  docdetail.Data doctorDetail = docdetail.Data();

  Future<void> getDoctorDetail() async {
    try {
      var response = await _doctorProfilePresenter.getDoctorDetails(
        doctorId: doctorId,
        isLoading: true,
      );
      if (response.data != null) {
        doctorDetail = response.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

  void onBookAppointmentButtonClick() {
    NavigateTo.goToBookAppointmentScreen(
      doctorId: int.parse(doctorId),
      fees: doctorDetail.profile!.fees.toString(),
    );
  }

  // void setCustomMarker() async {
  //   mapMarker = await BitmapDescriptor.fromAssetImage(
  //       const ImageConfiguration(size: Size.fromHeight(10)),
  //       AppImages.circleLocationIcon);
  // }

  Set<Marker> marker = {};

  void onMapCreated(GoogleMapController controller) {
    marker.add(
      Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(double.parse(doctorDetail.profile!.latitude!),
              double.parse(doctorDetail.profile!.longitude!)),
          icon: BitmapDescriptor.defaultMarker),
    );
    update();
  }

  var isRategivenID = 0;
  var reviewController = TextEditingController();

  Data lastBookingData = Data();

  Future<void> lastBookingStatus() async {
    var response = await _doctorProfilePresenter.lastBookingStatus(
      isLoading: true,
    );
    if (response.data != null) {
      if (response.data!.reviewed!.id == 0) {
        isRategivenID = 0;
      } else {
        isRategivenID = response.data!.reviewed!.id!;
        lastBookingData = response.data!;
      }
    }
    update();
  }

  int? rating;
  Future<void> addRating({
    required String doctorId,
  }) async {
    if (rating != null) {
      var response = await _doctorProfilePresenter.addReview(
        doctorId: doctorId,
        rating: rating.toString().trim(),
        comment: reviewController.text,
        isLoading: true,
      );
      if (response.data != null) {
        isRategivenID = 0;
        update();
        Utility.showMessage('Review added successfully', MessageType.success,
            () => Utility.closeDialog(), 'Okay');
        reviewController.clear();
      }
    } else {}
  }

  @override
  void onInit() {
    super.onInit();
    getDoctorDetail();
    lastBookingStatus();
    //setCustomMarker();
  }
}
