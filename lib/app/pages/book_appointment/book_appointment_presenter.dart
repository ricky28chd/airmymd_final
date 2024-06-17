import 'package:airmymd/domain/models/get_user_profile_response.dart';

import '../../../domain/models/slot_time_response.dart';
import '../../../domain/usecases/authcases.dart';

class BookAppointmentPresenter {
  BookAppointmentPresenter(this.authCases);
  final AuthCases authCases;

  /// get time slots api call
  Future<SlotTimeResponse> getTimeSlot({
    required String doctorId,
    required String bookingDate,
    bool isLoading = false,
  }) async =>
      authCases.getTimeSlot(
        doctorId: doctorId,
        bookingDate: bookingDate,
        isLoading: isLoading,
      );

  Future<GetUserProfileResponse> getUserProfile({
    required bool isLoading,
  }) =>
      authCases.getUserProfile(isLoading: isLoading);
}
