import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/book_appointment_with_insurance.dart';
import '../../../domain/models/book_with_card_response.dart';
import '../../../domain/models/doctor_detail_response.dart';
import '../../../domain/models/get_card_list_response.dart';
import '../../../domain/models/get_insurance_list_response.dart';
import '../../../domain/models/save_card_response.dart';

class PaymentPresenter {
  PaymentPresenter(this.authCases);
  final AuthCases authCases;

  Future<InsuranceBookingResponse> bookingWithInsuranceModel({
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String sourceId,
    required String sourceName,
    bool isLoading = false,
  }) async =>
      authCases.bookingWithInsuranceModel(
          doctorId: doctorId,
          bookingDate: bookingDate,
          bookingTime: bookingTime,
          paymentType: paymentType,
          reason: reason,
          sourceId: sourceId,
          sourceName: sourceName,
          isLoading: isLoading);

  Future<GetInsuranceResponse> getInsuranceList(
          {bool isLoading = false}) async =>
      authCases.getInsuranceList(
        isLoading: isLoading,
      );

  Future<GetCardListResponse> getAllCards({
    bool isLoading = false,
  }) async =>
      authCases.getAllCards(
        isLoading: isLoading,
      );

  Future<BookWithCardResponse> bookAppointmentWithCard({
    bool isLoading = false,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String cardToken,
  }) async =>
      authCases.bookAppointmentWithCard(
        doctorId: doctorId,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        paymentType: paymentType,
        reason: reason,
        cardToken: cardToken,
        isLoading: isLoading,
      );
}
