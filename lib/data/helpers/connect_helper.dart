import 'package:airmymd/app/app.dart';
import 'package:airmymd/data/data.dart';
import 'package:airmymd/device/repositories/device_repositories.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';

import '../../domain/models/response_model.dart';

class ConnectHelper {
  ///Initialize Api wrapper
  final apiWrapper = ApiWrapper();

  ///Register Api===============================================================
  Future<ResponseModel> registerUserModel(
      String email, String phoneNumber, String password) async {
    var data = {
      "email": email,
      "phone": phoneNumber,
      'country_code': countryCode,
      'device_token': deviceToken,
      // "password": password
    };
    return await apiWrapper.makeRequest(
      'register-otp',
      Request.post,
      data,
      true,
      {"Content-Type": "application/json"},
    );
  }

  ///Register Otp verification Api==============================================
  ///Method is taking parameter [navigateFrom], it's value comes from otp controller
  ///according to that value if that value is [navigateFromRegister], then hit
  ///register-verify otp else hit login-verify.

  Future<ResponseModel> registerOtpVerificationModel(
      String otp, String navigateFrom) async {
    var registerData = {
      'code': otp,
      'device_token': deviceToken,
    };
    var loginData = {'remember_token': otp};
    return await apiWrapper.makeRequest(
      navigateFrom == 'navigateFromRegister'
          ? 'register-verify'
          : 'login-verify',
      Request.post,
      navigateFrom == "navigateFromRegister" ? registerData : loginData,
      true,
      {"Content-Type": "application/json"},
    );
  }

  ///Login Api==================================================================
  Future<ResponseModel> loginUserModel(
      String email, String deviceToken, String password) async {
    var data = {
      'email_phone': email,
      'device_token': deviceToken,
      // "password": password,
    };
    return await apiWrapper.makeRequest(
      'login-otp',
      Request.post,
      data,
      true,
      {"Content-Type": "application/json"},
    );
  }

  ///Location Api===============================================================
  Future<ResponseModel> locationUserModel(
    String location,
    String token,
    String longitude,
    String latitude,
  ) async {
    var data = {
      'location': location,
      'longitude': longitude,
      'latitude': latitude
    };
    return await apiWrapper.makeRequest(
      'profile-location',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Profile Api================================================================
  Future<ResponseModel> profileUserModel(
      String parentId,
      String childId,
      String profileImage,
      String firstName,
      String middleName,
      String lastName,
      String city,
      String state,
      String zip,
      String height,
      String weight,
      String gender,
      String ethnicity,
      String dob,
      String maritalStatus,
      String token,
      String email,
      String pass) async {
    var data = {
      'parent_id': parentId,
      'child_id': childId,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'city': city,
      'state': state,
      'zip': zip,
      'height': height,
      'weight': weight,
      'gender': gender,
      'ethnicity': ethnicity,
      'dob': dob,
      'marital_status': maritalStatus,
      'phone': pass
    };
    return profileImage.isEmpty
        ? apiWrapper.makeRequest(
            'profile',
            Request.post,
            data,
            true,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
              'Accept': 'application/json',
            },
          )
        : apiWrapper.makeRequest(
            'profile',
            Request.multiPartPost,
            data,
            true,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
            },
            field: 'profile',
            filePath: profileImage,
          );
  }

  ///allergies Api================================================================

  Future<ResponseModel> allergyUserModel(
    List<Map<String, dynamic>> map,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      "allergies": map,
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
    };
    return await apiWrapper.makeRequest(
      'allergies',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Medical history Api================================================================
  Future<ResponseModel> medicalHistoryUserModel(
    String medicalHistory,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      'medical_history': medicalHistory,
    };
    return await apiWrapper.makeRequest(
      'medical-history',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Surgeries Api================================================================
  Future<ResponseModel> surgeriesUserModel(
    String surgery,
    String year,
    String age,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      'surgeries': surgery,
      'year': year,
      'age': age,
    };
    return await apiWrapper.makeRequest(
      'surgeries',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///medication Api================================================================

  Future<ResponseModel> medicationUserModel(
    List<Map<String, dynamic>> map,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      "medications": map,
    };
    return await apiWrapper.makeRequest(
      'medications',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///sexual health API==========================================================
  Future<ResponseModel> sexualHealthUserModel(
      String sexualStatus, String token) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      'sexual_health': sexualStatus,
    };
    return await apiWrapper.makeRequest(
      'sexual-health',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Health Habits Api==========================================================
  Future<ResponseModel> healthHabitsUserModel(
    String exerciseHabit,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      'habits': exerciseHabit,
    };
    return await apiWrapper.makeRequest(
      'habits',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///General health Api=========================================================
  Future<ResponseModel> generalHealth(
    String general,
    String skinProblem,
    String eyeEarProblem,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      'general': general,
      'skin': skinProblem,
      'eyes': eyeEarProblem,
    };
    return await apiWrapper.makeRequest(
      'general',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Alcohol Api================================================================
  Future<ResponseModel> alcoholUserModel(
      String drinkAlcohol,
      String howMany,
      String inADay,
      String cutDown,
      String feltGuilty,
      String morningDrink,
      String token) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      'drink_alcohol': drinkAlcohol,
      'how_many': howMany,
      'drinks_in_day': inADay,
      'cut_down': cutDown,
      'felt_guilty': feltGuilty,
      'morning_drink': morningDrink,
    };
    return await apiWrapper.makeRequest(
      'alcohol',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Drug Api===================================================================
  Future<ResponseModel> drugUserModel(
    String streetDrug,
    String needleDrug,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
      'street_drug': streetDrug,
      'needle_drug': needleDrug,
    };
    return await apiWrapper.makeRequest(
      'drug',
      Request.post,
      data,
      true,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Add insurance Api==========================================================
  Future<ResponseModel> addInsuranceUserModel(
    String id,
    String provider,
    String phone,
    String groupNumber,
    String filePath,
    String token,
  ) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();

    var data = {
      'id': id,
      'provider': provider,
      'phone': phone,
      'group_number': groupNumber,
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
    };
    return filePath.isEmpty
        ? apiWrapper.makeRequest(
            'insurance?child_id=${childId.isEmpty ? '' : childId}',
            Request.post,
            data,
            true,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
            },
          )
        : apiWrapper.makeRequest(
            'insurance?child_id=${childId.isEmpty ? '' : childId}',
            Request.multiPartPost,
            data,
            true,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
            },
            field: 'image',
            filePath: filePath);
  }

  ///specialization api call====================================================
  Future<ResponseModel> specializationUserModel({
    required String token,
    required String latitude,
    required String longitude,
    required bool isLoading,
  }) async {
    var data = {
      'latitude': latitude,
      'longitude': longitude,
    };
    return await apiWrapper.makeRequest(
      'specializations',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///doctor list api call=======================================================
  Future<ResponseModel> doctorListUserModel(
    String latitude,
    String longitude,
    String specialization,
    String token, {
    bool isLoading = false,
  }) async {
    var data = {
      'latitude': latitude,
      'longitude': longitude,
      'specialization': specialization,
    };
    return await apiWrapper.makeRequest(
      'doctor-list',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///doctor detail api call=====================================================
  Future<ResponseModel> getDoctorDetail(
    String token,
    String doctorId, {
    bool isLoading = false,
  }) async {
    return await apiWrapper.makeRequest(
      'doctor-view/$doctorId',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///save card details api======================================================
  Future<ResponseModel> saveCardDetail({
    required String token,
    required String cardNumber,
    required String cardName,
    required String expMonth,
    required String expYear,
    required String cardCvv,
    bool isLoading = false,
  }) async {
    var data = {
      'card_number': cardNumber,
      'card_name': cardName,
      'exp_month': expMonth,
      'exp_year': expYear,
      'card_cvc': cardCvv,
    };
    return await apiWrapper.makeRequest(
      'add-card',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  ///appointment list api call==================================================
  Future<ResponseModel> appointmentWithInsuranceModel({
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
    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    var data = {
      'doctor_id': doctorId,
      'booking_date': bookingDate,
      'booking_time': bookingTime,
      'payment_type': paymentType,
      'reason': reason,
      'source_id': sourceId,
      'source_name': 'Parent',
      'child_id': childId.isEmpty ? '' : childId,
    };
    return await apiWrapper.makeRequest(
      'booking',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  ///appointment booking with card=============================================
  Future<ResponseModel> appointmentWithCard({
    required String token,
    bool isLoading = false,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String cardToken,
  }) async {
    var data = {
      "doctor_id": doctorId,
      "booking_date": bookingDate,
      "booking_time": bookingTime,
      "payment_type": paymentType,
      "reason": reason,
      "card_token": cardToken,
    };
    return await apiWrapper.makeRequest(
      'booking',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  ///insurance list api call==================================================
  Future<ResponseModel> getInsuranceList(
    String token, {
    bool isLoading = false,
  }) async {
    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    return await apiWrapper.makeRequest(
      'insurance-list?child_id=${childId.isEmpty ? '' : childId}',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///get slots time api call==================================================
  Future<ResponseModel> getTimeSlots(
    String token,
    String doctorId,
    String bookingDate, {
    bool isLoading = false,
  }) async {
    var data = {"doctor_id": doctorId, "booking_date": bookingDate};
    return await apiWrapper.makeRequest(
      'slots',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///appointment list api call==================================================
  Future<ResponseModel> getAllAppointmentsUserModel(
    String token, {
    bool isLoading = false,
  }) async {
    return await apiWrapper.makeRequest(
      'appointments',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///Delete appointment api=====================================================
  Future<ResponseModel> deleteAppointmentUserModel({
    required String token,
    required int appointmentId,
    bool isLoading = false,
  }) async {
    var data = {
      'id': appointmentId,
    };
    return await apiWrapper.makeRequest(
      'booking-reject',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Tobacco save api===========================================================
  Future<ResponseModel> saveTobacco({
    required Map<String, dynamic> cigarette,
    required String tobacco,
    required String token,
    bool isLoading = false,
  }) async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();

    var data = {
      'cigarette': cigarette,
      'tobacco': tobacco,
      'parent_id': parentId.isEmpty ? '' : parentId,
      'child_id': childId.isEmpty ? '' : childId,
    };
    return await apiWrapper.makeRequest(
      'tobacco',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///get card list api==========================================================
  Future<ResponseModel> getAllCards({
    bool isLoading = false,
    required String token,
  }) async {
    return await apiWrapper.makeRequest(
      'card-listing',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///delete card api============================================================
  Future<ResponseModel> deleteCard({
    bool isLoading = false,
    required String token,
    required String cardId,
  }) async {
    var data = {
      'id': cardId,
    };
    return await apiWrapper.makeRequest(
      'card-delete',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///delete insurance api=======================================================
  Future<ResponseModel> deleteInsuranceCard({
    bool isLoading = false,
    required String token,
    required String insuranceId,
  }) async {
    var data = {
      'id': insuranceId,
    };
    return await apiWrapper.makeRequest(
      'delete-insurance',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///get Allergies api==========================================================
  Future<ResponseModel> getAllergies({
    required String token,
    bool isLoading = false,
  }) async {
    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();

    return await apiWrapper.makeRequest(
      'get-allergies?child_id=${childId.isEmpty ? '' : childId}',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///get Medication api==========================================================
  Future<ResponseModel> getMedication({
    required String token,
    bool isLoading = false,
  }) async {
    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();

    return await apiWrapper.makeRequest(
      'get-medication?child_id=${childId.isEmpty ? '' : childId}',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///get cigarette api==========================================================
  Future<ResponseModel> getCigarette({
    required String token,
    bool isLoading = false,
  }) async {
    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();
    return await apiWrapper.makeRequest(
      'get-cigarette?child_id=${childId.isEmpty ? '' : childId}',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///get converstion list api==================================================
  Future<ResponseModel> getConversationList({
    required String token,
    bool isLoading = false,
  }) async {
    return await apiWrapper.makeRequest(
      'conversion-list',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///send message api=================================================
  Future<ResponseModel> sendMessage({
    required String userId,
    required String token,
    required String message,
    bool isLoading = false,
  }) async {
    var data = {
      'user_id': userId,
      'text_msg': message,
    };
    return chatImage.isNotEmpty
        ? apiWrapper.makeRequest(
            'add-messages',
            Request.multipartGroup,
            data,
            isLoading,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
            },
            field: 'media[]',
            fileGroupPath: chatImage,
          )
        : apiWrapper.makeRequest(
            'add-messages',
            Request.post,
            data,
            isLoading,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
            },
          );
  }

  ///get messages list api==================================================
  Future<ResponseModel> getMessages({
    required String userId,
    bool isLoading = false,
    required String token,
    required int pageNumber,
  }) async {
    var data = {
      'user_id': userId,
    };
    return await apiWrapper.makeRequest(
      'get-messages?page=$pageNumber',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///get notification list api call=========================================
  Future<ResponseModel> getNotificationList({
    required String token,
    bool isLoading = false,
  }) async {
    return await apiWrapper.makeRequest(
      'notifications',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///send review api========================================================
  Future<ResponseModel> addReview({
    required String token,
    required String doctorId,
    required String rating,
    required String comment,
    bool isLoading = false,
  }) async {
    var data = {
      'booking_id': appointmentId,
      'doctor_id': doctorId,
      'rating': rating,
      'review': comment,
    };
    return await apiWrapper.makeRequest(
      'review',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///push notifcation setting api================================
  Future<ResponseModel> pushNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  }) async {
    var data = {'status': status};
    return await apiWrapper.makeRequest(
      'push-notifications',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///push notifcation setting api================================
  Future<ResponseModel> emailNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  }) async {
    var data = {'status': status};
    return await apiWrapper.makeRequest(
      'email-notifications',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///Read notification api=============================================
  Future<ResponseModel> readNotification({
    required String token,
    bool isLoading = false,
  }) async {
    return await apiWrapper.makeRequest(
      'read-notifications',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///Read messages api=================================================
  Future<ResponseModel> readMessages({
    required String token,
    bool isLoading = false,
  }) async {
    return await apiWrapper.makeRequest(
      'read-messages',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///review list api==========================================
  Future<ResponseModel> reviewsList(
      {required String doctorId,
      required String token,
      required bool isLoading}) async {
    var data = {
      'doctor_id': doctorId,
    };
    return await apiWrapper.makeRequest(
      'doctor-review',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///payment release api========================================
  Future<ResponseModel> paymentRelease({
    required String token,
    required String bookingId,
    required bool isLoading,
  }) async {
    var data = {
      "booking_id": bookingId,
    };
    return await apiWrapper.makeRequest(
      'release-payment',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  ///last booking status api=========================================
  Future<ResponseModel> lastBookingStatus({
    required String token,
    required bool isLoading,
  }) async {
    return await apiWrapper.makeRequest(
      'appointment-reviewed',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  ///unread messages===================================================

  Future<ResponseModel> unreadMessages({
    required bool isLoading,
    required String token,
  }) async {
    return await apiWrapper.makeRequest(
      'unread-messages-count',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<ResponseModel> logoutUser({
    required String token,
    required bool isLoading,
  }) async {
    return await apiWrapper.makeRequest(
      'logout',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<ResponseModel> userSupport({
    required String token,
    required bool isLoading,
    required String email,
    required String phone,
    required String name,
    required String description,
  }) async {
    var data = {
      'name': name,
      'email': email,
      'phone': phone,
      'description': description,
    };
    return await apiWrapper.makeRequest(
      'support',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  Future<ResponseModel> addNote(
      {required bool isLoading,
      required String token,
      required String title,
      required String description,
      required String users,
      required String dateTime,
      required note_id}) async {
    print('jlfkjfkljfkljfkljfklfjklfjk $newLists');
    var data = {
      'title': title,
      'description': description,
      'datetime': dateTime,
      'users': users,
      'images': newLists
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .trim()
          .replaceAll(' ', ''),
      'note_id': note_id.toString() == 'null' ? '' : note_id.toString()
    };
    print('dddkhdjkhdjihdjkdhjdh $data');
    return multipleFinalImages.isNotEmpty
        ? apiWrapper.makeRequest(
            'add-note',
            Request.multipartGroup,
            data,
            isLoading,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
            },
            field: 'files[]',
            fileGroupPath: multipleFinalImages,
          )
        : apiWrapper.makeRequest(
            'add-note',
            Request.post,
            data,
            isLoading,
            {
              'Authorization': 'Bearer $token',
              "Content-Type": "application/json",
            },
          );
  }

  Future<ResponseModel> getNotes({
    required bool isLoading,
    required String token,
  }) async {
    return await apiWrapper.makeRequest(
      'get-notes',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  Future<ResponseModel> getUserProfile({
    required bool isLoading,
    required String token,
  }) async {
    return await apiWrapper.makeRequest(
      'get-profile',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }

  Future<ResponseModel> parentControl({
    required bool isLoading,
    required String token,
    required String userId,
  }) async {
    var data = {
      'user_id': userId,
    };
    return await apiWrapper.makeRequest(
      'switch-account',
      Request.post,
      data,
      isLoading,
      {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );
  }
}
