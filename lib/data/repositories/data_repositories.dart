import 'package:airmymd/data/data.dart';
import 'package:airmymd/domain/repositories/domain_repository.dart';

import '../../domain/models/response_model.dart';

class DataRepository implements DomainRepository {
  /// [connectHelper] : A connection helper which will connect to the
  /// remote to get the data.
  DataRepository(this.connectHelper);

  final ConnectHelper connectHelper;

  @override
  void clearData(key) {
    throw UnimplementedError();
  }

  @override
  void deleteAllSecuredValues() {
    throw UnimplementedError();
  }

  @override
  void deleteSecuredValue(String key) {
    throw UnimplementedError();
  }

  @override
  int getIntValue(String key) {
    throw UnimplementedError();
  }

  @override
  void clearBox() {
    throw UnimplementedError();
  }

  @override
  bool getBoolValue(String key) {
    throw UnimplementedError();
  }

  @override
  Future<String?> getSecuredValue(String key) {
    throw UnimplementedError();
  }

  @override
  String getStringValue(String key) {
    throw UnimplementedError();
  }

  @override
  void saveValue(key, value) {
    throw UnimplementedError();
  }

  @override
  void saveValueSecurely(String key, String value) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> registerUserModel(
      {required String email,
      required String phoneNumber,
      required String password}) async {
    return await connectHelper.registerUserModel(email, phoneNumber, password);
  }

  @override
  Future<ResponseModel> loginUserModel(
      {required String email,
      required String deviceToken,
      required String password}) async {
    return await connectHelper.loginUserModel(email, deviceToken, password);
  }

  @override
  Future<ResponseModel> locationUserModel({
    required String location,
    required String token,
    required String longitude,
    required String latitude,
  }) async {
    return await connectHelper.locationUserModel(
        location, token, longitude, latitude);
  }

  @override
  Future<ResponseModel> profileUserModel(
      {required String parentId,
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
      required String maritalStatus,
      required String token,
      required String email,
      required String pass}) async {
    return await connectHelper.profileUserModel(
        parentId,
        childId,
        profileImage,
        firstName,
        middleName,
        lastName,
        city,
        state,
        zip,
        height,
        weight,
        gender,
        ethnicity,
        dob,
        maritalStatus,
        token,
        email,
        pass);
  }

  @override
  Future<ResponseModel> registerOtpVerificationModel({
    required String otp,
    required String navigateFrom,
  }) async {
    return await connectHelper.registerOtpVerificationModel(
      otp,
      navigateFrom,
    );
  }

  @override
  Future<ResponseModel> medicalHistoryUserModel({
    required String medicalHistory,
    required String token,
  }) async {
    return await connectHelper.medicalHistoryUserModel(
      medicalHistory,
      token,
    );
  }

  @override
  Future<ResponseModel> surgeriesUserModel({
    required String surgery,
    required String year,
    required String age,
    required String token,
  }) async {
    return await connectHelper.surgeriesUserModel(
      surgery,
      year,
      age,
      token,
    );
  }

  @override
  Future<ResponseModel> allergyUserModel({
    required List<Map<String, dynamic>> map,
    required String token,
  }) async {
    return await connectHelper.allergyUserModel(
      map,
      token,
    );
  }

  @override
  Future<ResponseModel> medicationUserModel({
    required List<Map<String, dynamic>> map,
    required String token,
  }) async {
    return await connectHelper.medicationUserModel(
      map,
      token,
    );
  }

  @override
  Future<ResponseModel> generalHealthUserModel({
    required String general,
    required String skinProblem,
    required String eyeEarProblem,
    required String token,
  }) async {
    return await connectHelper.generalHealth(
      general,
      skinProblem,
      eyeEarProblem,
      token,
    );
  }

  @override
  Future<ResponseModel> healthHabitsUserModel({
    required String healthHabit,
    required String token,
  }) async {
    return await connectHelper.healthHabitsUserModel(
      healthHabit,
      token,
    );
  }

  @override
  Future<ResponseModel> sexualHealthUserModel({
    required String sexualStatus,
    required String token,
  }) async {
    return await connectHelper.sexualHealthUserModel(
      sexualStatus,
      token,
    );
  }

  @override
  Future<ResponseModel> alcoholUserModel({
    required String drinkAlcohol,
    required String howMany,
    required String inADay,
    required String cutDown,
    required String feltGuilty,
    required String morningDrink,
    required String token,
  }) async {
    return await connectHelper.alcoholUserModel(
      drinkAlcohol,
      howMany,
      inADay,
      cutDown,
      feltGuilty,
      morningDrink,
      token,
    );
  }

  @override
  Future<ResponseModel> drugUserModel({
    required String streetDrug,
    required String needleDrug,
    required String token,
  }) async {
    return await connectHelper.drugUserModel(
      streetDrug,
      needleDrug,
      token,
    );
  }

  @override
  Future<ResponseModel> addInsuranceUserModel({
    required String id,
    required String provider,
    required String phone,
    required String groupNumber,
    required String filePath,
    required String token,
  }) async {
    return await connectHelper.addInsuranceUserModel(
      id,
      provider,
      phone,
      groupNumber,
      filePath,
      token,
    );
  }

  @override
  Future<ResponseModel> specializationUserModel({
    required String token,
    required String latitude,
    required String longitude,
    required bool isLoading,
  }) async {
    return await connectHelper.specializationUserModel(
      token: token,
      latitude: latitude,
      longitude: longitude,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> doctorListUserModel({
    required String latitude,
    required String longitude,
    required String specialization,
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.doctorListUserModel(
      latitude,
      longitude,
      specialization,
      token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getDoctorDetail({
    required String doctorId,
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getDoctorDetail(
      token,
      doctorId,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getAllAppointments({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getAllAppointmentsUserModel(
      token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getInsuranceList({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getInsuranceList(
      token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getTimeSlots({
    required String token,
    required String doctorId,
    required String bookingDate,
    bool isLoading = false,
  }) async {
    return await connectHelper.getTimeSlots(token, doctorId, bookingDate,
        isLoading: isLoading);
  }

  @override
  Future<ResponseModel> bookingWithInsuranceModel({
    required String token,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String sourceId,
    required String sourceName,
    bool isLoading = false,
  }) async {
    return await connectHelper.appointmentWithInsuranceModel(
      token: token,
      doctorId: doctorId,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      paymentType: paymentType,
      reason: reason,
      sourceId: sourceId,
      sourceName: sourceName,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> deleteAppointmentUserModel({
    required String token,
    required int appointmentId,
    bool isLoading = false,
  }) async {
    return await connectHelper.deleteAppointmentUserModel(
      token: token,
      appointmentId: appointmentId,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> saveCardDetails({
    required String token,
    required String cardNumber,
    required String cardName,
    required String expMonth,
    required String expYear,
    required String cardCvv,
    bool isLoading = false,
  }) async {
    return await connectHelper.saveCardDetail(
      token: token,
      cardNumber: cardNumber,
      cardName: cardName,
      expMonth: expMonth,
      expYear: expYear,
      cardCvv: cardCvv,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> saveTobacco({
    required Map<String, dynamic> cigarette,
    required String tobacco,
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.saveTobacco(
      cigarette: cigarette,
      tobacco: tobacco,
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> deleteCard({
    bool isLoading = false,
    required String token,
    required String cardId,
  }) async {
    return await connectHelper.deleteCard(
      token: token,
      cardId: cardId,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> deleteInsuranceCard(
      {bool isLoading = false,
      required String token,
      required String insuranceId}) async {
    return await connectHelper.deleteInsuranceCard(
      token: token,
      insuranceId: insuranceId,
    );
  }

  @override
  Future<ResponseModel> getAllCard({
    bool isLoading = false,
    required String token,
  }) async {
    return await connectHelper.getAllCards(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> bookAppointmentWithCard({
    required String token,
    bool isLoading = false,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String cardToken,
  }) async {
    return await connectHelper.appointmentWithCard(
      token: token,
      isLoading: isLoading,
      doctorId: doctorId,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      paymentType: paymentType,
      reason: reason,
      cardToken: cardToken,
    );
  }

  @override
  Future<ResponseModel> getAllergies({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getAllergies(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getCigarette({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getCigarette(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getMedication({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getMedication(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getConversationList({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getConversationList(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getMessages({
    required String userId,
    bool isLoading = false,
    required String token,
    required int pageNumber,
  }) async {
    return await connectHelper.getMessages(
      userId: userId,
      token: token,
      pageNumber: pageNumber,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> sendMessage({
    required String userId,
    required String token,
    required String message,
    bool isLoading = false,
  }) async {
    return await connectHelper.sendMessage(
      userId: userId,
      token: token,
      message: message,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> getNotificationList({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.getNotificationList(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> addReview({
    required String token,
    required String doctorId,
    required String rating,
    required String comment,
    bool isLoading = false,
  }) async {
    return await connectHelper.addReview(
      token: token,
      doctorId: doctorId,
      rating: rating,
      comment: comment,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> emailNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  }) async {
    return await connectHelper.emailNotificationSetting(
      token: token,
      status: status,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> pushNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  }) async {
    return await connectHelper.pushNotificationSetting(
      token: token,
      status: status,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> readMessages({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.readMessages(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> readNotification({
    required String token,
    bool isLoading = false,
  }) async {
    return await connectHelper.readNotification(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> reviewsList({
    required String doctorId,
    required String token,
    required bool isLoading,
  }) async {
    return await connectHelper.reviewsList(
      doctorId: doctorId,
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> lastBookingStatus({
    required String token,
    required bool isLoading,
  }) async {
    return await connectHelper.lastBookingStatus(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> paymentRelease(
      {required String token,
      required String bookingId,
      required bool isLoading}) async {
    return await connectHelper.paymentRelease(
      token: token,
      bookingId: bookingId,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> unreadMessages({
    required bool isLoading,
    required String token,
  }) async {
    return await connectHelper.unreadMessages(
      isLoading: isLoading,
      token: token,
    );
  }

  @override
  Future<ResponseModel> logoutUser({
    required String token,
    required bool isLoading,
  }) async {
    return await connectHelper.logoutUser(
      token: token,
      isLoading: isLoading,
    );
  }

  @override
  Future<ResponseModel> userSupport({
    required String token,
    required bool isLoading,
    required String email,
    required String phone,
    required String name,
    required String description,
  }) async {
    return await connectHelper.userSupport(
      token: token,
      isLoading: isLoading,
      email: email,
      phone: phone,
      name: name,
      description: description,
    );
  }

  @override
  Future<ResponseModel> addNote(
      {required bool isLoading,
      required String token,
      required String title,
      required String description,
      required String users,
      required note_id,
      required String dateTime}) async {
    return await connectHelper.addNote(
      isLoading: isLoading,
      token: token,
      title: title,
      description: description,
      users: users,
      dateTime: dateTime,
      note_id: note_id,
    );
  }

  @override
  Future<ResponseModel> getNotes({
    required bool isLoading,
    required String token,
  }) async {
    return await connectHelper.getNotes(
      isLoading: isLoading,
      token: token,
    );
  }

  @override
  Future<ResponseModel> getUserProfile({
    required bool isLoading,
    required String token,
  }) async {
    return await connectHelper.getUserProfile(
      isLoading: isLoading,
      token: token,
    );
  }
}
