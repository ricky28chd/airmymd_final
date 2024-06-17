import 'package:airmymd/domain/models/add_review.dart';
import 'package:airmymd/domain/models/allergy_response.dart';
import 'package:airmymd/domain/models/drug_response.dart';
import 'package:airmymd/domain/models/general_health_response.dart';
import 'package:airmymd/domain/models/get_insurance_list_response.dart';
import 'package:airmymd/domain/models/get_medication_response.dart';
import 'package:airmymd/domain/models/get_notes_response.dart';
import 'package:airmymd/domain/models/get_user_profile_response.dart';
import 'package:airmymd/domain/models/health_habits_response.dart';
import 'package:airmymd/domain/models/last_booking_response.dart';
import 'package:airmymd/domain/models/logout_response.dart';
import 'package:airmymd/domain/models/medication_response.dart';
import 'package:airmymd/domain/models/push_notification_setting.dart';
import 'package:airmymd/domain/models/read_messages_response.dart';
import 'package:airmymd/domain/models/read_notification_response.dart';
import 'package:airmymd/domain/models/register_otp_verify_response.dart';
import 'package:airmymd/domain/models/release_payment_response.dart';
import 'package:airmymd/domain/models/reviews_list_response.dart';
import 'package:airmymd/domain/models/save_insurance.dart';
import 'package:airmymd/domain/models/send_message_response.dart';
import 'package:airmymd/domain/models/sexual_health_response.dart';
import 'package:airmymd/domain/models/slot_time_response.dart';
import 'package:airmymd/domain/models/unread_messages_response.dart';
import 'package:airmymd/domain/models/user_conversation_response.dart';
import 'package:airmymd/domain/models/user_support_response.dart';

import '../models/add_note_response.dart';
import '../models/alcohol_response.dart';
import '../models/book_appointment_with_insurance.dart';
import '../models/book_with_card_response.dart';
import '../models/booking_reject_response.dart';
import '../models/build_profile_response.dart';
import '../models/coversation_list_response.dart';
import '../models/delete_card_response.dart';
import '../models/delete_insurance_card_response.dart';
import '../models/doctor_detail_response.dart';
import '../models/doctor_list_response.dart';
import '../models/email_notification_setting.dart';
import '../models/get_allergies_response.dart';
import '../models/get_appointments_response.dart';
import '../models/get_card_list_response.dart';
import '../models/get_cigarette_response.dart';
import '../models/login_response.dart';
import '../models/medical_history_response.dart';
import '../models/login_otp_verify_response.dart';
import '../models/notification_list_response.dart';
import '../models/register_response.dart';
import '../models/save_card_response.dart';
import '../models/save_tobacco_response.dart';
import '../models/set_location_response.dart';
import '../models/specialization_list_response.dart';
import '../models/surgeries_response.dart';
import '../repositories/repository.dart';

class AuthCases {
  AuthCases(this.repository);
  final Repository repository;

  ///get authToken from local.
  Future<String?> getSecureValue(String key) => repository.getSecureValue(key);

  ///Sign in Api Call
  Future<SignUpResponse> signUpUserModel(
          {required String email,
          required String phoneNumber,
          required String password}) async =>
      repository.registerUserModel(
          email: email, phoneNumber: phoneNumber, password: password);

  /// login Otp Verify Api call.
  Future<LoginOtpVerificationResponse> loginOtpVerificationModel({
    required String otp,
    required String navigateFrom,
  }) async =>
      repository.loginOtpVerificationModel(
        otp: otp,
        navigateFrom: navigateFrom,
      );

  /// register Otp Verify Api call.
  Future<RegisterOtpVerificationResponse> registerOtpVerificationModel({
    required String otp,
    required String navigateFrom,
  }) async =>
      repository.registerOtpVerificationModel(
        otp: otp,
        navigateFrom: navigateFrom,
      );

  ///login Api call.
  Future<LoginResponse> loginUserModel({
    required String email,
    required String deviceToken,
    required String password,
  }) async =>
      repository.loginUserModel(
          email: email, deviceToken: deviceToken, password: password);

  ///set Location Api call
  Future<SetLocationResponse> locationUserModel({
    required String location,
    required String longitude,
    required String latitude,
  }) async =>
      repository.locationUserModel(
        location: location,
        longitude: longitude,
        latitude: latitude,
      );

  ///Build profile Api call
  Future<ProfileResponse> profileUserModel({
    required String parentId,
    required String childId,
    required String profileImage,
    required String firstName,
    required String middleName,
    required String lastName,
    required String city,
    required String state,
    required String zip,
    required String height,
    required String weight,
    required String gender,
    required String ethnicity,
    required String dob,
    required String email,
    required String pass,
    required String maritalStatus,
  }) async =>
      repository.profileUserModel(
        parentId: parentId,
        childId: childId,
        profileImage: profileImage,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        city: city,
        state: state,
        zip: zip,
        height: height,
        weight: weight,
        gender: gender,
        ethnicity: ethnicity,
        dob: dob,
        email: email,
        pass: pass,
        maritalStatus: maritalStatus,
      );

  ///allergies API call
  Future<AllergyResponse> allergyUserModel({
    required List<Map<String, dynamic>> map,
  }) async =>
      repository.allergyUserResponse(
        map: map,
      );

  ///Medical History Api call
  Future<MedicalHistoryResponse> medicalHistoryUserModel({
    required String medicalHistory,
  }) async =>
      repository.medicalHistoryUserModel(
        medicalHistory: medicalHistory,
      );

  ///Surgeries Api call.
  Future<SurgeriesResponse> surgeriesUserModel({
    required String surgery,
    required String year,
    required String age,
  }) =>
      repository.surgeryUserModel(
        surgery: surgery,
        year: year,
        age: age,
      );

  ///allergies API call
  Future<MedicationResponse> medicationUserModel({
    required List<Map<String, dynamic>> map,
  }) async =>
      repository.medicationUserResponse(
        map: map,
      );

  ///sexual health API call
  Future<SexualHealthResponse> sexualHealthUserModel({
    required String sexualStatus,
  }) async =>
      repository.sexualHealthUserModel(
        sexualStatus: sexualStatus,
      );

  ///health habit API call
  Future<HealthHabitsResponse> healthHabitUserModel({
    required String healthHabit,
  }) async =>
      repository.healthHabitsUserModel(
        healthHabit: healthHabit,
      );

  ///health habit API call
  Future<GeneralHealthResponse> generalHealthUserModel({
    required String general,
    required String skinProblem,
    required String eyeEarProblem,
  }) async =>
      repository.generalHealthUserModel(
        general: general,
        skinProblem: skinProblem,
        eyeEarProblem: eyeEarProblem,
      );

  ///alcohol API call
  Future<AlcoholResponse> alcoholUserModel({
    required String drinkAlcohol,
    required String howMany,
    required String inADay,
    required String cutDown,
    required String feltGuilty,
    required String morningDrink,
  }) async =>
      repository.alcoholUserModel(
        drinkAlcohol: drinkAlcohol,
        howMany: howMany,
        inADay: inADay,
        cutDown: cutDown,
        feltGuilty: feltGuilty,
        morningDrink: morningDrink,
      );

  ///drug api call
  Future<DrugResponse> drugUserModel({
    required String streetDrug,
    required String needleDrug,
  }) async =>
      repository.drugUserModel(
        streetDrug: streetDrug,
        needleDrug: needleDrug,
      );

  /// add insurance api call
  Future<AddInsuranceResponse> addInsuranceResponse({
    required String id,
    required String provider,
    required String phone,
    required String groupNumber,
    required String filePath,
  }) async =>
      repository.addInsuranceUserModel(
        id: id,
        provider: provider,
        phone: phone,
        groupNumber: groupNumber,
        filePath: filePath,
      );

  ///specialization list api call
  Future<SpecializationListResponse> specializationUserModel({
    required String latitude,
    required String longitude,
    required bool isLoading,
  }) async =>
      repository.specializationUserModel(
        latitude: latitude,
        longitude: longitude,
        isLoading: isLoading,
      );

  ///doctor list api call.
  Future<DoctorListResponse> doctorListUserModel({
    required String latitude,
    required String longitude,
    required String specialization,
    bool isLoading = false,
  }) async =>
      repository.doctorListUserModel(
        latitude: latitude,
        longitude: longitude,
        specialization: specialization,
        isLoading: isLoading,
      );

  /// doctor detail api call
  Future<DoctorDetailResponse> getDoctorDetail({
    required String doctorId,
    bool isLoading = false,
  }) async =>
      repository.doctorDetailUserModel(
        doctorId: doctorId,
        isLoading: isLoading,
      );

  /// get appointments api call
  Future<AppointmentsResponse> getAllAppointments({
    bool isLoading = false,
  }) async =>
      repository.getAllAppointments(
        isLoading: isLoading,
      );

  /// booking with insurance api call
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
      repository.bookingWithInsuranceModel(
        doctorId: doctorId,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        paymentType: paymentType,
        reason: reason,
        sourceId: sourceId,
        sourceName: sourceName,
        isLoading: isLoading,
      );

  /// get insurance list api call
  Future<GetInsuranceResponse> getInsuranceList({
    bool isLoading = false,
  }) async =>
      repository.getInsuranceList(
        isLoading: isLoading,
      );

  /// get time slots api call
  Future<SlotTimeResponse> getTimeSlot({
    required String doctorId,
    required String bookingDate,
    bool isLoading = false,
  }) async =>
      repository.getTimeSlots(
        doctorId: doctorId,
        bookingDate: bookingDate,
        isLoading: isLoading,
      );

  ///Delete appointment api call.
  Future<BookingRejectResponse> deleteAppointmentsUserModel({
    required int appointmentId,
    bool isLoading = false,
  }) async =>
      repository.deleteAppointmentUserModel(
        appointmentId: appointmentId,
        isLoading: isLoading,
      );

  ///save card details api call.
  Future<SaveCardResponse> saveCardDetails({
    required String cardNumber,
    required String cardName,
    required String expMonth,
    required String expYear,
    required String cardCvv,
    bool isLoading = false,
  }) async =>
      repository.saveCardDetails(
        cardNumber: cardNumber,
        cardName: cardName,
        expMonth: expMonth,
        expYear: expYear,
        cardCvv: cardCvv,
        isLoading: isLoading,
      );

  ///save tobacco api call.
  Future<SaveTobaccoCard> saveTobacco({
    required Map<String, dynamic> cigarette,
    required String tobacco,
    bool isLoading = false,
  }) async =>
      repository.saveTobacco(
        cigarette: cigarette,
        tobacco: tobacco,
        isLoading: isLoading,
      );

  Future<GetCardListResponse> getAllCards({
    bool isLoading = false,
  }) async =>
      repository.getAllCards(
        isLoading: isLoading,
      );

  Future<DeleteInsuranceCard> deleteInsuranceCard({
    required String insuranceId,
    bool isLoading = false,
  }) async =>
      repository.deleteInsuranceCard(
        insuranceId: insuranceId,
        isLoading: isLoading,
      );

  Future<DeleteBankCardResponse> deleteBankCard({
    required String cardId,
    bool isLoading = false,
  }) async =>
      repository.deleteBankCard(
        cardId: cardId,
        isLoading: isLoading,
      );

  Future<GetAllergiesResponse> getAllergies({
    bool isLoading = false,
  }) async =>
      repository.getAllergies(
        isLoading: isLoading,
      );

  Future<GetCigaretteResponse> getCigarette({
    bool isLoading = false,
  }) async =>
      repository.getCigarette(
        isLoading: isLoading,
      );

  Future<GetMedicationResponse> getMedication({
    bool isLoading = false,
  }) async =>
      repository.getMedication(
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
      repository.bookAppointmentWithCard(
        doctorId: doctorId,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        paymentType: paymentType,
        reason: reason,
        cardToken: cardToken,
        isLoading: isLoading,
      );

  Future<GetConversationListResponse> getConversationList({
    bool isLoading = false,
  }) async =>
      repository.getConversationList(
        isLoading: isLoading,
      );

  Future<GetUserConversationResponse> getMessages({
    required String userId,
    bool isLoading = false,
    required int pageNumber,
  }) async =>
      await repository.getMessages(
        userId: userId,
        pageNumber: pageNumber,
        isLoading: isLoading,
      );

  Future<SendMessageResponse> sendMessage({
    required String userId,
    required String message,
    bool isLoading = false,
  }) async =>
      await repository.sendMessage(
        userId: userId,
        message: message,
        isLoading: isLoading,
      );

  Future<GetNotificationList> getNotificationList({
    bool isLoading = false,
  }) async =>
      await repository.getNotificationList(
        isLoading: isLoading,
      );

  Future<AddReview> addReview({
    required String doctorId,
    required String rating,
    required String comment,
    bool isLoading = false,
  }) async =>
      await repository.addReview(
        doctorId: doctorId,
        rating: rating,
        comment: comment,
        isLoading: isLoading,
      );

  Future<PushNotificationSetting> pushNotificationSetting({
    required String status,
    bool isLoading = false,
  }) async =>
      await repository.pushNotificationSetting(
        status: status,
        isLoading: isLoading,
      );

  Future<EmailNotificationSetting> emailNotificationSetting({
    required String status,
    bool isLoading = false,
  }) async =>
      await repository.emailNotificationSetting(
        status: status,
        isLoading: isLoading,
      );

  Future<ReadNotificationResponse> readNotification({
    bool isLoading = false,
  }) async =>
      await repository.readNotification(
        isLoading: isLoading,
      );

  Future<ReadMessagesResponse> readMessages({
    bool isLoading = false,
  }) async =>
      await repository.readMessages(
        isLoading: isLoading,
      );

  Future<ReviewsListResponse> reviewsList({
    required String doctorId,
    required bool isLoading,
  }) async =>
      repository.reviewsList(
        doctorId: doctorId,
        isLoading: isLoading,
      );

  Future<PaymentReleaseResponse> paymentRelease({
    required String bookingId,
    required bool isLoading,
  }) async =>
      repository.paymentRelease(
        bookingId: bookingId,
        isLoading: isLoading,
      );

  Future<LastBookingResponse> lastBookingStatus({
    required bool isLoading,
  }) async =>
      repository.lastBookingStatus(
        isLoading: isLoading,
      );

  Future<UnreadMessagesResponse> unreadMessages({
    required bool isLoading,
  }) async =>
      repository.unreadMessages(
        isLoading: isLoading,
      );

  Future<LogoutResponse> logoutUser({
    required bool isLoading,
  }) async =>
      repository.logoutUser(
        isLoading: isLoading,
      );

  Future<UserSupportResponse> userSupport({
    required bool isLoading,
    required String email,
    required String phone,
    required String name,
    required String description,
  }) =>
      repository.userSupport(
        isLoading: isLoading,
        email: email,
        phone: phone,
        name: name,
        description: description,
      );

  Future<AddNoteResponse> addNote(
          {required bool isLoading,
          required String title,
          required String description,
          required String users,
          required String dateTime,
          required userId}) =>
      repository.addNote(
        isLoading: isLoading,
        title: title,
        description: description,
        users: users,
        dateTime: dateTime,
        userId: userId,
      );

  Future<GetNotesResponse> getNotes({
    required bool isLoading,
  }) =>
      repository.getNotes(
        isLoading: isLoading,
      );

  Future<GetUserProfileResponse> getUserProfile({
    required bool isLoading,
  }) =>
      repository.getUserProfile(isLoading: isLoading);
}
