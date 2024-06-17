import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/add_review.dart';
import 'package:airmymd/domain/models/last_booking_response.dart';

import '../../../domain/models/doctor_detail_response.dart';

class DoctorProfilePresenter {
  DoctorProfilePresenter(this.authCases);
  final AuthCases authCases;

  Future<DoctorDetailResponse> getDoctorDetails({
    required String doctorId,
    bool isLoading = false,
  }) async =>
      authCases.getDoctorDetail(
        doctorId: doctorId,
        isLoading: isLoading,
      );

  Future<LastBookingResponse> lastBookingStatus({
    required bool isLoading,
  }) async =>
      authCases.lastBookingStatus(
        isLoading: isLoading,
      );

  Future<AddReview> addReview({
    required String doctorId,
    required String rating,
    required String comment,
    bool isLoading = false,
  }) async =>
      authCases.addReview(
        doctorId: doctorId,
        rating: rating,
        comment: comment,
        isLoading: isLoading,
      );
}
