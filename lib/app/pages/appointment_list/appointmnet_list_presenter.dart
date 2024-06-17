import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/add_review.dart';
import 'package:airmymd/domain/models/notification_list_response.dart';
import 'package:airmymd/domain/models/read_messages_response.dart';
import 'package:airmymd/domain/models/read_notification_response.dart';
import 'package:airmymd/domain/models/release_payment_response.dart';
import 'package:airmymd/domain/models/unread_messages_response.dart';

import '../../../domain/models/booking_reject_response.dart';
import '../../../domain/models/get_appointments_response.dart';

class AppointmentListPresenter {
  AppointmentListPresenter(this.authCases);
  final AuthCases authCases;

  Future<AppointmentsResponse> getAllAppointments({
    bool isLoading = false,
  }) async =>
      authCases.getAllAppointments(
        isLoading: isLoading,
      );

  Future<BookingRejectResponse> deleteAppointmentUserModel({
    required int appointmentId,
    bool isLoading = false,
  }) async =>
      authCases.deleteAppointmentsUserModel(
        appointmentId: appointmentId,
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

  Future<ReadNotificationResponse> readNotification(
          {bool isLoading = false}) async =>
      authCases.readNotification(
        isLoading: isLoading,
      );

  Future<ReadMessagesResponse> readMessages({
    bool isLoadig = false,
  }) async =>
      authCases.readMessages(
        isLoading: isLoadig,
      );

  Future<PaymentReleaseResponse> paymentRelease({
    required String bookingId,
    required bool isLoading,
  }) async =>
      authCases.paymentRelease(
        bookingId: bookingId,
        isLoading: isLoading,
      );

  Future<GetNotificationList> getNotificationList({
    bool isLoading = false,
  }) async =>
      authCases.getNotificationList(
        isLoading: isLoading,
      );

  Future<UnreadMessagesResponse> unreadMessages({
    required bool isLoading,
  }) async =>
      authCases.unreadMessages(
        isLoading: isLoading,
      );

      
}
