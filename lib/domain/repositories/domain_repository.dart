abstract class DomainRepository {
  ///Get the string value for the [key]
  ///
  /// [key] save the needed value
  void getStringValue(String key);

  /// Get the string value for the [key].
  ///Login response which [value] will be saved.
  ///[value] : The value which needs to be saved.
  void saveValue(dynamic key, dynamic value);

  ///Clear data from local storage.
  void clearData(dynamic key);

  /// Get the boolean value for the [key].
  ///
  /// [key] : The key whose value is needed.
  bool getBoolValue(String key);

  /// Get the Int value for the [key].
  ///
  /// [key] : The key whose value is needed.
  int getIntValue(String key);

  /// [key] : The key whose value is needed.
  Future<String?> getSecuredValue(String key);

  /// Save the value to the string.
  ///
  /// [key] : The key to which [value] will be saved in secure storage.
  /// [value] : The value which needs to be saved.
  void saveValueSecurely(String key, String value);

  /// Clear data from secure storage for [key].
  void deleteSecuredValue(String key);

  /// Remove all data from secure storage.
  void deleteAllSecuredValues();

  /// clear all data
  void clearBox();

//==============================================================================
  /// User/Model register API call
  Future<dynamic> registerUserModel({
    required String email,
    required String phoneNumber,
    required String password,
  });

  ///User/Model register otp verification Api call
  Future<dynamic> registerOtpVerificationModel({
    required String otp,
    required String navigateFrom,
  });

  ///User/Model login Api call
  Future<dynamic> loginUserModel(
      {required String email,
      required String deviceToken,
      required String password});

  ///User/Model location Api call
  Future<dynamic> locationUserModel({
    required String location,
    required String token,
    required String longitude,
    required String latitude,
  });

  ///User/Model profile Api call
  Future<dynamic> profileUserModel(
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
      required String email,
      required String pass,
      required String token});

  ///User/Model allergy Api call.
  Future<dynamic> allergyUserModel({
    required List<Map<String, dynamic>> map,
    required String token,
  });

  ///User/Model medical history Api call.
  Future<dynamic> medicalHistoryUserModel(
      {required String medicalHistory, required String token});

  ///User/Model surgeries Api call.
  Future<dynamic> surgeriesUserModel({
    required String surgery,
    required String year,
    required String age,
    required String token,
  });

  ///User/Model medications Api call.
  Future<dynamic> medicationUserModel({
    required List<Map<String, dynamic>> map,
    required String token,
  });

  ///User/Model sexual health Api call.
  Future<dynamic> sexualHealthUserModel({
    required String sexualStatus,
    required String token,
  });

  ///User/Model health habits Api call.
  Future<dynamic> healthHabitsUserModel({
    required String healthHabit,
    required String token,
  });

  ///User/Model general health Api call.
  Future<dynamic> generalHealthUserModel({
    required String general,
    required String skinProblem,
    required String eyeEarProblem,
    required String token,
  });

  ///User/Model alcohol Api call.
  Future<dynamic> alcoholUserModel({
    required String drinkAlcohol,
    required String howMany,
    required String inADay,
    required String cutDown,
    required String feltGuilty,
    required String morningDrink,
    required String token,
  });

  ///User/Model drug Api call.
  Future<dynamic> drugUserModel({
    required String streetDrug,
    required String needleDrug,
    required String token,
  });

  ///User/Model add insurance Api call.
  Future<dynamic> addInsuranceUserModel({
    required String id,
    required String provider,
    required String phone,
    required String groupNumber,
    required String filePath,
    required String token,
  });

  ///User/Model specialization list Api call.
  Future<dynamic> specializationUserModel({
    required String token,
    required String latitude,
    required String longitude,
    required bool isLoading,
  });

  ///User/Model doctor list Api call.
  Future<dynamic> doctorListUserModel({
    required String latitude,
    required String longitude,
    required String specialization,
    required String token,
    bool isLoading = false,
  });

  ///User/Model doctor detail Api call.
  Future<dynamic> getDoctorDetail({
    required String token,
    required String doctorId,
    bool isLoading = false,
  });

  ///User/Model appointments Api call.
  Future<dynamic> getAllAppointments({
    required String token,
    bool isLoading = false,
  });

  ///User/Model book appointment with insurance Api call.
  Future<dynamic> bookingWithInsuranceModel({
    required String token,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String sourceId,
    required String sourceName,
    bool isLoading = false,
  });

  ///User/Model insurance list Api call.
  Future<dynamic> getInsuranceList({
    required String token,
    bool isLoading = false,
  });

  ///User/Model get time slots Api call.
  Future<dynamic> getTimeSlots({
    required String token,
    required String doctorId,
    required String bookingDate,
    bool isLoading = false,
  });

  ///User/Model delete appointment Api call.
  Future<dynamic> deleteAppointmentUserModel({
    required String token,
    required int appointmentId,
    bool isLoading = false,
  });

  ///User/Model delete appointment Api call.
  Future<dynamic> saveCardDetails({
    required String token,
    required String cardNumber,
    required String cardName,
    required String expMonth,
    required String expYear,
    required String cardCvv,
    bool isLoading = false,
  });

  ///User/Model save tobacco Api call.
  Future<dynamic> saveTobacco({
    required Map<String, dynamic> cigarette,
    required String tobacco,
    required String token,
    bool isLoading = false,
  });

  ///User/Model get card list Api call.
  Future<dynamic> getAllCard({
    bool isLoading = false,
    required String token,
  });

  ///User/Model delete insurance card list Api call.
  Future<dynamic> deleteInsuranceCard({
    bool isLoading = false,
    required String token,
    required String insuranceId,
  });

  ///User/Model delete card list Api call.
  Future<dynamic> deleteCard({
    bool isLoading = false,
    required String token,
    required String cardId,
  });

  ///User/Model booking with card Api call.
  Future<dynamic> bookAppointmentWithCard({
    required String token,
    bool isLoading = false,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String cardToken,
  });

  ///User/Model get allergies Api call.
  Future<dynamic> getAllergies({
    required String token,
    bool isLoading = false,
  });

  ///User/Model get medication Api call.
  Future<dynamic> getMedication({
    required String token,
    bool isLoading = false,
  });

  ///User/Model get cigarette Api call.
  Future<dynamic> getCigarette({
    required String token,
    bool isLoading = false,
  });

  ///User/Model get conversation list Api call.
  Future<dynamic> getConversationList({
    required String token,
    bool isLoading = false,
  });

  ///User/Model get all messages of specific user call.
  Future<dynamic> getMessages({
    required String userId,
    bool isLoading = false,
    required String token,
    required int pageNumber,
  });

  Future<dynamic> sendMessage({
    required String userId,
    required String token,
    required String message,
    bool isLoading = false,
  });

  Future<dynamic> getNotificationList({
    required String token,
    bool isLoading = false,
  });

  Future<dynamic> addReview({
    required String token,
    required String doctorId,
    required String rating,
    required String comment,
    bool isLoading = false,
  });

  Future<dynamic> pushNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  });

  Future<dynamic> emailNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  });

  Future<dynamic> readNotification({
    required String token,
    bool isLoading = false,
  });

  Future<dynamic> readMessages({
    required String token,
    bool isLoading = false,
  });

  Future<dynamic> reviewsList({
    required String doctorId,
    required String token,
    required bool isLoading,
  });

  Future<dynamic> paymentRelease({
    required String token,
    required String bookingId,
    required bool isLoading,
  });

  Future<dynamic> lastBookingStatus({
    required String token,
    required bool isLoading,
  });

  Future<dynamic> unreadMessages({
    required bool isLoading,
    required String token,
  });

  Future<dynamic> logoutUser({
    required String token,
    required bool isLoading,
  });

  Future<dynamic> userSupport({
    required String token,
    required bool isLoading,
    required String email,
    required String phone,
    required String name,
    required String description,
  });

  Future<dynamic> addNote(
      {required bool isLoading,
      required String token,
      required String title,
      required String description,
      required String users,
      required String dateTime,
      required note_id});

  Future<dynamic> getNotes({
    required bool isLoading,
    required String token,
  });

  Future<dynamic> getUserProfile({
    required bool isLoading,
    required String token,
  });

  Future<dynamic> parentControl({
     required bool isLoading,
    required String token,
    required String userId,
  });
}
