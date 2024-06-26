import 'package:airmymd/app/app.dart';
import 'package:airmymd/data/data.dart';
import 'package:airmymd/domain/models/add_note_response.dart';
import 'package:airmymd/domain/models/add_review.dart';
import 'package:airmymd/domain/models/book_appointment_with_insurance.dart';
import 'package:airmymd/domain/models/doctor_detail_response.dart';
import 'package:airmymd/domain/models/doctor_list_response.dart';
import 'package:airmymd/domain/models/email_notification_setting.dart';
import 'package:airmymd/domain/models/get_notes_response.dart';
import 'package:airmymd/domain/models/get_user_profile_response.dart';
import 'package:airmymd/domain/models/last_booking_response.dart';
import 'package:airmymd/domain/models/login_response.dart';
import 'package:airmymd/domain/models/logout_response.dart';
import 'package:airmymd/domain/models/medication_response.dart';
import 'package:airmymd/domain/models/parent_control_response.dart';
import 'package:airmymd/domain/models/push_notification_setting.dart';
import 'package:airmymd/domain/models/read_messages_response.dart';
import 'package:airmymd/domain/models/read_notification_response.dart';
import 'package:airmymd/domain/models/register_otp_verify_response.dart';
import 'package:airmymd/domain/models/release_payment_response.dart';
import 'package:airmymd/domain/models/reviews_list_response.dart';
import 'package:airmymd/domain/models/save_insurance.dart';
import 'package:airmymd/domain/models/send_message_response.dart';
import 'package:airmymd/domain/models/unread_messages_response.dart';
import 'package:airmymd/domain/models/user_support_response.dart';

import '../../device/repositories/device_repositories.dart';
import '../models/alcohol_response.dart';
import '../models/allergy_response.dart';
import '../models/book_with_card_response.dart';
import '../models/booking_reject_response.dart';
import '../models/build_profile_response.dart';
import '../models/coversation_list_response.dart';
import '../models/delete_card_response.dart';
import '../models/delete_insurance_card_response.dart';
import '../models/drug_response.dart';
import '../models/general_health_response.dart';
import '../models/get_allergies_response.dart';
import '../models/get_appointments_response.dart';
import '../models/get_card_list_response.dart';
import '../models/get_cigarette_response.dart';
import '../models/get_insurance_list_response.dart';
import '../models/get_medication_response.dart';
import '../models/health_habits_response.dart';
import '../models/medical_history_response.dart';
import '../models/login_otp_verify_response.dart';
import '../models/notification_list_response.dart';
import '../models/register_response.dart';
import '../models/save_card_response.dart';
import '../models/save_tobacco_response.dart';
import '../models/set_location_response.dart';
import '../models/sexual_health_response.dart';
import '../models/slot_time_response.dart';
import '../models/specialization_list_response.dart';
import '../models/surgeries_response.dart';
import '../models/user_conversation_response.dart';
import 'localstorage_keys.dart';

/// The main repository which will get the data from [DeviceRepository] or the
/// [DataRepository].
class Repository {
  /// [_deviceRepository] : the local repository.
  /// [_dataRepository] : the data repository like api and all.
  Repository(this._deviceRepository, this._dataRepository);

  final DataRepository _dataRepository;
  final DeviceRepository _deviceRepository;

  ///Clear data from local storage for [key].
  void clearData(dynamic key) {
    try {
      _deviceRepository.clearData(key);
    } catch (_) {
      _dataRepository.clearData(key);
    }
  }

  /// Get the string value for the [key].
  ///
  /// [key] : The key whose value is needed.
  String getStringValue(String key) {
    try {
      return _deviceRepository.getStringValue(
        key,
      );
    } catch (_) {
      return _dataRepository.getStringValue(
        key,
      );
    }
  }

  /// Save the value to the string.
  ///
  /// [key] : The key to which [value] will be saved.
  /// [value] : The value which needs to be saved.
  void saveValue(dynamic key, dynamic value) {
    try {
      _deviceRepository.saveValue(
        key,
        value,
      );
    } catch (_) {
      _dataRepository.saveValue(
        key,
        value,
      );
    }
  }

  /// Get the bool value for the [key].
  ///
  /// [key] : The key whose value is needed.
  bool getBoolValue(String key) {
    try {
      return _deviceRepository.getBoolValue(
        key,
      );
    } catch (_) {
      return _dataRepository.getBoolValue(
        key,
      );
    }
  }

  /// Get the secure value for the [key].
  /// [key] : The key whose value is needed.
  Future<String?> getSecureValue(String key) {
    try {
      return _deviceRepository.getSecuredValue(
        key,
      );
    } catch (_) {
      return _dataRepository.getSecuredValue(
        key,
      );
    }
  }

  /// Save the value to the string.
  ///
  /// [key] : The key to which [value] will be saved.
  /// [value] : The value which needs to be saved.
  void saveSecureValue(String key, String value) {
    try {
      _deviceRepository.saveValueSecurely(
        key,
        value,
      );
    } catch (_) {
      _dataRepository.saveValueSecurely(
        key,
        value,
      );
    }
  }

  /// Clear data from secure storage for [key].
  void deleteSecuredValue(String key) {
    try {
      _deviceRepository.deleteSecuredValue(
        key,
      );
    } catch (_) {
      _dataRepository.deleteSecuredValue(
        key,
      );
    }
  }

  /// Clear all data from secure storage .
  void deleteAllSecuredValues() {
    try {
      _deviceRepository.deleteAllSecuredValues();
    } catch (_) {
      _dataRepository.deleteAllSecuredValues();
    }
  }

  /// Method for user/model signup from the [DataRepository] and [DeviceRepository]
  Future<SignUpResponse> registerUserModel({
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      var response = await _dataRepository.registerUserModel(
          email: email, phoneNumber: phoneNumber, password: password);
      SignUpResponse? signupResponse;

      if (!response.hasError) {
        signupResponse = signUpResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return signupResponse!;
    } catch (_) {
      return await _deviceRepository.registerUserModel(
          email: email, phoneNumber: phoneNumber, password: password);
    }
  }

  ///Method for user/model registerOtpVerification from the [DataRepository] and [DeviceRepository].
  Future<LoginOtpVerificationResponse> loginOtpVerificationModel(
      {required String otp, required String navigateFrom}) async {
    try {
      var response = await _dataRepository.registerOtpVerificationModel(
          otp: otp, navigateFrom: navigateFrom);
      LoginOtpVerificationResponse? loginOtpVerificationResponse;
      if (!response.hasError) {
        loginOtpVerificationResponse =
            loginOtpVerificationResponseFromJson(response.data);
        // var logInData =
        //     loginOtpVerificationResponse.data!.userData![0].patientProfile!;
        saveValue(
            LocalKeys.authToken, loginOtpVerificationResponse.data!.token);

        // saveValue(LocalKeys.location, logInData.location);
        // saveValue(LocalKeys.latitude, logInData.latitude);
        // saveValue(LocalKeys.longitude, logInData.longitude);
        // saveValue(LocalKeys.userEmail,
        //     loginOtpVerificationResponse.data!.userData![0].email);
        // saveValue(LocalKeys.userPhone,
        //     loginOtpVerificationResponse.data!.userData![0].phone);
        // saveValue(LocalKeys.firstName, logInData.firstName);
        // saveValue(LocalKeys.middleName, logInData.middleName);
        // saveValue(LocalKeys.lastName, logInData.lastName);
        // saveValue(LocalKeys.city, logInData.city);
        // saveValue(LocalKeys.state, logInData.state);
        // saveValue(LocalKeys.zip, logInData.zip);
        // saveValue(LocalKeys.height, logInData.height);
        // saveValue(LocalKeys.weight, logInData.weight);
        // saveValue(LocalKeys.gender, logInData.gender);
        // saveValue(LocalKeys.ethnicity, logInData.ethnicity);
        // saveValue(LocalKeys.dob, logInData.dob.toString());
        // saveValue(LocalKeys.maritalStatus, logInData.maritalStatus);
        // saveValue(LocalKeys.medicalHistory, logInData.medicalHistory);
        // saveValue(LocalKeys.surgeries, logInData.surgeries);
        // saveValue(LocalKeys.year, logInData.year);
        // saveValue(LocalKeys.age, logInData.age);
        // saveValue(LocalKeys.sexualHealth, logInData.sexualHealth);
        // saveValue(LocalKeys.habits, logInData.habits);
        // saveValue(LocalKeys.general, logInData.general);
        // saveValue(LocalKeys.skin, logInData.skin);
        // saveValue(LocalKeys.eyes, logInData.eyes);
        // saveValue(LocalKeys.cigarette, logInData.cigarette);
        // saveValue(LocalKeys.tobacco, logInData.tobacco);
        // saveValue(LocalKeys.streetDrug, logInData.streetDrug);
        // saveValue(LocalKeys.needleDrug, logInData.needleDrug);
        // saveValue(LocalKeys.drinkAlcohol, logInData.drinkAlcohol);
        // saveValue(LocalKeys.howMany, logInData.howMany);
        // saveValue(LocalKeys.drinksInDay, logInData.drinksInDay);
        // saveValue(LocalKeys.cutDown, logInData.cutDown);
        // saveValue(LocalKeys.feltGuilty, logInData.feltGuilty);
        // saveValue(LocalKeys.morningDrink, logInData.morningDrink);
        // saveValue(LocalKeys.profileImage,
        //     loginOtpVerificationResponse.data!.userData![0].profilePhotoUrl);
        // saveValue(LocalKeys.pushNotification,
        //     loginOtpVerificationResponse.data!.userData![0].pushNotification);
        // saveValue(LocalKeys.emailNotification,
        //     loginOtpVerificationResponse.data!.userData![0].emailNotification);
        // saveValue(LocalKeys.userId,
        //     loginOtpVerificationResponse.data!.userData![0].id.toString());
        // print(getStringValue(LocalKeys.userId));
      } else {
        Utility.showInfoDialog(response, false);
      }
      return loginOtpVerificationResponse!;
    } catch (e) {
      debugPrint(e.toString());
      return await _deviceRepository.registerOtpVerificationModel(
        otp: otp,
        navigateFrom: navigateFrom,
      );
    }
  }

  ///Method for user/model register Otp Verification from the [DataRepository] and [DeviceRepository].
  Future<RegisterOtpVerificationResponse> registerOtpVerificationModel(
      {required String otp, required String navigateFrom}) async {
    try {
      var response = await _dataRepository.registerOtpVerificationModel(
          otp: otp, navigateFrom: navigateFrom);
      RegisterOtpVerificationResponse? registerOtpVerificationResponse;
      if (!response.hasError) {
        registerOtpVerificationResponse =
            registerOtpVerificationResponseFromJson(response.data);
        saveValue(
            LocalKeys.authToken, registerOtpVerificationResponse.data!.token!);
        saveValue(
            LocalKeys.userEmail, registerOtpVerificationResponse.data!.email!);
        saveValue(
            LocalKeys.userPhone, registerOtpVerificationResponse.data!.phone!);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return registerOtpVerificationResponse!;
    } catch (e) {
      return await _deviceRepository.registerOtpVerificationModel(
        otp: otp,
        navigateFrom: navigateFrom,
      );
    }
  }

  ///Method for user/model location from the [DataRepository] and [DeviceRepository].
  Future<SetLocationResponse> locationUserModel({
    required String location,
    required String longitude,
    required String latitude,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.locationUserModel(
        location: location,
        token: token,
        longitude: longitude,
        latitude: latitude,
      );
      SetLocationResponse? setLocationResponse;
      if (!response.hasError) {
        setLocationResponse = setLocationResponseFromJson(response.data);
        saveValue(LocalKeys.location, setLocationResponse.data!.location);
        var userLocation = getStringValue('userLocation');
        print(userLocation);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return setLocationResponse!;
    } catch (_) {
      return await _deviceRepository.locationUserModel(
        location: location,
        token: token,
        longitude: longitude,
        latitude: latitude,
      );
    }
  }

  ///Method for user/model login from the [DataRepository] and [DeviceRepository].
  Future<LoginResponse> loginUserModel({
    required String email,
    required String deviceToken,
    required String password,
  }) async {
    try {
      var response = await _dataRepository.loginUserModel(
        password: password,
        email: email,
        deviceToken: deviceToken,
      );
      LoginResponse? loginResponse;
      if (!response.hasError) {
        loginResponse = loginResponseFromJson(response.data);
      } else {
        NavigateTo.goToLoginScreen();
        Utility.showInfoDialog(response, false);
      }
      return loginResponse!;
    } catch (e) {
      return await _deviceRepository.loginUserModel(
          email: email, deviceToken: deviceToken, password: password);
    }
  }

  ///Method for user/model build profile from the [DataRepository] and [DeviceRepository].
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
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.profileUserModel(
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
        maritalStatus: maritalStatus,
        token: token,
        email: email,
        pass: pass,
      );
      ProfileResponse? profileResponse;
      if (!response.hasError) {
        profileResponse = profileResponseFromJson(response.data);
        if (profileResponse.data!.newChildId != null) {
          saveValue(
              LocalKeys.childId, profileResponse.data!.newChildId.toString());
        }
        // saveValue(LocalKeys.firstName, profileResponse.data!.firstName);
        // saveValue(LocalKeys.userEmail, profileResponse.data!.email);

        // saveValue(LocalKeys.userPhone, profileResponse.data!.phone);

        // saveValue(LocalKeys.middleName, profileResponse.data!.middleName);
        // saveValue(LocalKeys.lastName, profileResponse.data!.lastName);
        // saveValue(LocalKeys.city, profileResponse.data!.city);

        // saveValue(LocalKeys.state, profileResponse.data!.state);
        // saveValue(LocalKeys.zip, profileResponse.data!.zip);
        // saveValue(LocalKeys.height, profileResponse.data!.height);
        // saveValue(LocalKeys.weight, profileResponse.data!.weight);
        // saveValue(LocalKeys.gender, profileResponse.data!.gender);
        // saveValue(LocalKeys.ethnicity, profileResponse.data!.ethnicity);
        // saveValue(LocalKeys.dob, profileResponse.data!.dob.toString());

        // saveValue('saveImage', profileResponse.data!.profilePhotoPath);
        // print('djdlkjdkldjkldjkldjdlkjd${getStringValue('saveImage')}');
        // saveValue(LocalKeys.maritalStatus, profileResponse.data!.maritalStatus);
        // if (profileResponse.data!.profilePhotoPath!.isNotEmpty) {
        //   saveValue(
        //       LocalKeys.profileImage, profileResponse.data!.profilePhotoPath);
        // }
      } else {
        Utility.showInfoDialog(response, false);
      }
      return profileResponse!;
    } catch (_) {
      return await _deviceRepository.profileUserModel(
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
        maritalStatus: maritalStatus,
        email: email,
        pass: pass,
        token: token,
      );
    }
  }

  ///Method for user/model allergies from the [DataRepository] and [DeviceRepository].
  Future<AllergyResponse> allergyUserResponse(
      {required List<Map<String, dynamic>> map}) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.allergyUserModel(
        map: map,
        token: token,
      );
      AllergyResponse? allergyResponse;
      if (!response.hasError) {
        allergyResponse = allergyResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return allergyResponse!;
    } catch (e) {
      return await _deviceRepository.allergyUserModel(
        map: map,
        token: token,
      );
    }
  }

  ///Method for user/model medical history from the [DataRepository] and [DeviceRepository].
  Future<MedicalHistoryResponse> medicalHistoryUserModel(
      {required String medicalHistory}) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.medicalHistoryUserModel(
        medicalHistory: medicalHistory,
        token: token,
      );
      MedicalHistoryResponse? medicalHistoryResponse;
      if (!response.hasError) {
        medicalHistoryResponse = medicalHistoryResponseFromJson(response.data);
        saveValue(LocalKeys.medicalHistory,
            medicalHistoryResponse.data!.medicalHistory);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return medicalHistoryResponse!;
    } catch (_) {
      return await _deviceRepository.medicalHistoryUserModel(
        medicalHistory: medicalHistory,
        token: token,
      );
    }
  }

  ///Method for user/model surgeries from the [DataRepository] and [DeviceRepository].
  Future<SurgeriesResponse> surgeryUserModel({
    required String surgery,
    required String year,
    required String age,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.surgeriesUserModel(
        surgery: surgery,
        year: year,
        age: age,
        token: token,
      );
      SurgeriesResponse? surgeryResponse;
      if (!response.hasError) {
        surgeryResponse = surgeriesResponseFromJson(response.data);
        saveValue(LocalKeys.surgeries, surgeryResponse.data!.surgeries);
        saveValue(LocalKeys.year, surgeryResponse.data!.year);
        saveValue(LocalKeys.age, surgeryResponse.data!.age);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return surgeryResponse!;
    } catch (_) {
      return await _deviceRepository.surgeriesUserModel(
        surgery: surgery,
        year: year,
        age: age,
        token: token,
      );
    }
  }

  ///Method for user/model medication from the [DataRepository] and [DeviceRepository].
  Future<MedicationResponse> medicationUserResponse(
      {required List<Map<String, dynamic>> map}) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.medicationUserModel(
        map: map,
        token: token,
      );
      MedicationResponse? medicationResponse;
      if (!response.hasError) {
        medicationResponse = medicationResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return medicationResponse!;
    } catch (_) {
      return await _deviceRepository.medicationUserModel(
        map: map,
        token: token,
      );
    }
  }

  ///Method for user/model sexual health from the [DataRepository] and [DeviceRepository].
  Future<SexualHealthResponse> sexualHealthUserModel({
    required String sexualStatus,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.sexualHealthUserModel(
        sexualStatus: sexualStatus,
        token: token,
      );
      SexualHealthResponse? sexualHealthResponse;
      if (!response.hasError) {
        sexualHealthResponse = sexualHealthResponseFromJson(response.data);
        saveValue(
            LocalKeys.sexualHealth, sexualHealthResponse.data!.sexualHealth);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return sexualHealthResponse!;
    } catch (_) {
      return await _deviceRepository.sexualHealthUserModel(
        sexualStatus: sexualStatus,
        token: token,
      );
    }
  }

  ///Method for user/model sexual health from the [DataRepository] and [DeviceRepository].
  Future<HealthHabitsResponse> healthHabitsUserModel({
    required String healthHabit,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.healthHabitsUserModel(
        healthHabit: healthHabit,
        token: token,
      );
      HealthHabitsResponse? healthHabitsResponse;
      if (!response.hasError) {
        healthHabitsResponse = healthHabitsResponseFromJson(response.data);
        saveValue(LocalKeys.habits, healthHabitsResponse.data!.habits);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return healthHabitsResponse!;
    } catch (_) {
      return await _deviceRepository.healthHabitsUserModel(
        healthHabit: healthHabit,
        token: token,
      );
    }
  }

  ///Method for user/model sexual health from the [DataRepository] and [DeviceRepository].
  Future<GeneralHealthResponse> generalHealthUserModel({
    required String general,
    required String skinProblem,
    required String eyeEarProblem,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.generalHealthUserModel(
        general: general,
        skinProblem: skinProblem,
        eyeEarProblem: eyeEarProblem,
        token: token,
      );
      GeneralHealthResponse? generalHealthResponse;
      if (!response.hasError) {
        generalHealthResponse = generalHealthResponseFromJson(response.data);
        saveValue(LocalKeys.general, generalHealthResponse.data!.general);
        saveValue(LocalKeys.skin, generalHealthResponse.data!.skin);
        saveValue(LocalKeys.eyes, generalHealthResponse.data!.eyes);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return generalHealthResponse!;
    } catch (_) {
      return await _deviceRepository.generalHealthUserModel(
        general: general,
        skinProblem: skinProblem,
        eyeEarProblem: eyeEarProblem,
        token: token,
      );
    }
  }

  ///Method for user/model alcohol from the [DataRepository] and [DeviceRepository].
  Future<AlcoholResponse> alcoholUserModel({
    required String drinkAlcohol,
    required String howMany,
    required String inADay,
    required String cutDown,
    required String feltGuilty,
    required String morningDrink,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.alcoholUserModel(
        drinkAlcohol: drinkAlcohol,
        howMany: howMany,
        inADay: inADay,
        cutDown: cutDown,
        feltGuilty: feltGuilty,
        morningDrink: morningDrink,
        token: token,
      );
      AlcoholResponse? alcoholResponse;
      if (!response.hasError) {
        alcoholResponse = alcoholResponseFromJson(response.data);
        saveValue(LocalKeys.drinkAlcohol, alcoholResponse.data!.drinkAlcohol);
        saveValue(LocalKeys.howMany, alcoholResponse.data!.howMany);
        saveValue(LocalKeys.drinksInDay, alcoholResponse.data!.drinksInDay);
        saveValue(LocalKeys.cutDown, alcoholResponse.data!.cutDown);
        saveValue(LocalKeys.feltGuilty, alcoholResponse.data!.feltGuilty);
        saveValue(LocalKeys.morningDrink, alcoholResponse.data!.morningDrink);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return alcoholResponse!;
    } catch (_) {
      return await _deviceRepository.alcoholUserModel(
        drinkAlcohol: drinkAlcohol,
        howMany: howMany,
        inADay: inADay,
        cutDown: cutDown,
        feltGuilty: feltGuilty,
        morningDrink: morningDrink,
        token: token,
      );
    }
  }

  ///Method for user/model drug from the [DataRepository] and [DeviceRepository].
  Future<DrugResponse> drugUserModel({
    required String streetDrug,
    required String needleDrug,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.drugUserModel(
        streetDrug: streetDrug,
        needleDrug: needleDrug,
        token: token,
      );
      DrugResponse? drugResponse;
      if (!response.hasError) {
        drugResponse = drugResponseFromJson(response.data);
        saveValue(LocalKeys.streetDrug, drugResponse.data!.streetDrug);
        saveValue(LocalKeys.needleDrug, drugResponse.data!.needleDrug);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return drugResponse!;
    } catch (_) {
      return await _deviceRepository.drugUserModel(
        streetDrug: streetDrug,
        needleDrug: needleDrug,
        token: token,
      );
    }
  }

  ///Method for user/model add insurance from the [DataRepository] and [DeviceRepository].
  Future<AddInsuranceResponse> addInsuranceUserModel({
    required String id,
    required String provider,
    required String phone,
    required String groupNumber,
    required String filePath,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.addInsuranceUserModel(
        id: id,
        provider: provider,
        phone: phone,
        groupNumber: groupNumber,
        filePath: filePath,
        token: token,
      );
      AddInsuranceResponse? addInsuranceResponse;
      if (!response.hasError) {
        addInsuranceResponse = addInsuranceResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return addInsuranceResponse!;
    } catch (e) {
      debugPrint(e.toString());
      return await _deviceRepository.addInsuranceUserModel(
        id: id,
        provider: provider,
        phone: phone,
        groupNumber: groupNumber,
        filePath: filePath,
        token: token,
      );
    }
  }

  ///Method for user/model specialization list from the [DataRepository] and [DeviceRepository].
  Future<SpecializationListResponse> specializationUserModel({
    required String latitude,
    required String longitude,
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.specializationUserModel(
        token: token,
        latitude: latitude,
        longitude: longitude,
        isLoading: isLoading,
      );
      SpecializationListResponse? specializationListResponse;
      if (!response.hasError) {
        specializationListResponse =
            specializationListResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return specializationListResponse!;
    } catch (_) {
      return await _deviceRepository.specializationUserModel(
        token: token,
        latitude: latitude,
        longitude: longitude,
        isLoading: isLoading,
      );
    }
  }

  ///Method for user/model doctor list from the [DataRepository] and [DeviceRepository].
  Future<DoctorListResponse> doctorListUserModel({
    required String latitude,
    required String longitude,
    required String specialization,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.doctorListUserModel(
        latitude: latitude,
        longitude: longitude,
        specialization: specialization,
        token: token,
        isLoading: isLoading,
      );
      DoctorListResponse? doctorListResponse;
      if (!response.hasError) {
        doctorListResponse = doctorListResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return doctorListResponse!;
    } catch (_) {
      return await _deviceRepository.doctorListUserModel(
        latitude: latitude,
        longitude: longitude,
        specialization: specialization,
        token: token,
        isLoading: isLoading,
      );
    }
  }

  ///Method for user/model doctor detail from the [DataRepository] and [DeviceRepository].
  Future<DoctorDetailResponse> doctorDetailUserModel({
    required String doctorId,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getDoctorDetail(
        doctorId: doctorId,
        token: token,
        isLoading: isLoading,
      );
      DoctorDetailResponse? doctorDetailResponse;
      if (!response.hasError) {
        doctorDetailResponse = doctorDetailResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return doctorDetailResponse!;
    } catch (_) {
      return await _deviceRepository.getDoctorDetail(
        doctorId: doctorId,
        token: token,
        isLoading: isLoading,
      );
    }
  }

  ///Method for user/model get appointments from the [DataRepository] and [DeviceRepository].
  Future<AppointmentsResponse> getAllAppointments({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getAllAppointments(
        token: token,
        isLoading: isLoading,
      );
      AppointmentsResponse? appointmentsResponse;
      if (!response.hasError) {
        appointmentsResponse = appointmentsResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return appointmentsResponse!;
    } catch (_) {
      return await _deviceRepository.getAllAppointments(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  ///Method for user/model booking with insurance from the [DataRepository] and [DeviceRepository].
  Future<InsuranceBookingResponse> bookingWithInsuranceModel({
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String sourceId,
    required String sourceName,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.bookingWithInsuranceModel(
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
      InsuranceBookingResponse? insuranceBookingResponse;
      if (!response.hasError) {
        insuranceBookingResponse =
            insuranceBookingResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return insuranceBookingResponse!;
    } catch (_) {
      return await _deviceRepository.bookingWithInsuranceModel(
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
  }

  ///Method for user/model get insurance List from the [DataRepository] and [DeviceRepository].
  Future<GetInsuranceResponse> getInsuranceList({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getInsuranceList(
        token: token,
        isLoading: isLoading,
      );
      GetInsuranceResponse? getInsuranceResponse;
      if (!response.hasError) {
        getInsuranceResponse = getInsuranceResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getInsuranceResponse!;
    } catch (e) {
      return await _deviceRepository.getInsuranceList(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  ///Method for user/model get time slots from the [DataRepository] and [DeviceRepository].
  Future<SlotTimeResponse> getTimeSlots({
    required String doctorId,
    required String bookingDate,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getTimeSlots(
        token: token,
        doctorId: doctorId,
        bookingDate: bookingDate,
        isLoading: isLoading,
      );
      SlotTimeResponse? slotTimeResponse;
      if (!response.hasError) {
        slotTimeResponse = slotTimeResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return slotTimeResponse!;
    } catch (e) {
      print(e.toString());
      return await _deviceRepository.getTimeSlots(
        token: token,
        doctorId: doctorId,
        bookingDate: bookingDate,
        isLoading: isLoading,
      );
    }
  }

  ///Method for user/model delete appointment from the [DataRepository] and [DeviceRepository].
  Future<BookingRejectResponse> deleteAppointmentUserModel({
    required int appointmentId,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.deleteAppointmentUserModel(
        token: token,
        appointmentId: appointmentId,
        isLoading: isLoading,
      );
      BookingRejectResponse? bookingRejectResponse;
      if (!response.hasError) {
        bookingRejectResponse = bookingRejectResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return bookingRejectResponse!;
    } catch (_) {
      return await _deviceRepository.deleteAppointmentUserModel(
        token: token,
        appointmentId: appointmentId,
        isLoading: isLoading,
      );
    }
  }

  ///Method for user/model get insurance List from the [DataRepository] and [DeviceRepository].
  Future<SaveCardResponse> saveCardDetails({
    required String cardNumber,
    required String cardName,
    required String expMonth,
    required String expYear,
    required String cardCvv,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.saveCardDetails(
        token: token,
        cardNumber: cardNumber,
        cardName: cardName,
        expMonth: expMonth,
        expYear: expYear,
        cardCvv: cardCvv,
        isLoading: isLoading,
      );
      SaveCardResponse? saveCardResponse;
      if (!response.hasError) {
        saveCardResponse = saveCardResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return saveCardResponse!;
    } catch (e) {
      return await _deviceRepository.saveCardDetails(
        token: token,
        cardNumber: cardNumber,
        cardName: cardName,
        expMonth: expMonth,
        expYear: expYear,
        cardCvv: cardCvv,
        isLoading: isLoading,
      );
    }
  }

  Future<SaveTobaccoCard> saveTobacco({
    required Map<String, dynamic> cigarette,
    required String tobacco,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.saveTobacco(
        cigarette: cigarette,
        tobacco: tobacco,
        token: token,
        isLoading: isLoading,
      );
      SaveTobaccoCard? saveTobaccoCard;
      if (!response.hasError) {
        saveTobaccoCard = saveTobaccoCardFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return saveTobaccoCard!;
    } catch (_) {
      return await _deviceRepository.saveTobacco(
        cigarette: cigarette,
        tobacco: tobacco,
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<GetCardListResponse> getAllCards({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getAllCard(
        token: token,
        isLoading: isLoading,
      );
      GetCardListResponse? getCardListResponse;
      if (!response.hasError) {
        getCardListResponse = getCardListResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getCardListResponse!;
    } catch (_) {
      return await _deviceRepository.getAllCard(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<DeleteInsuranceCard> deleteInsuranceCard({
    required String insuranceId,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.deleteInsuranceCard(
        token: token,
        insuranceId: insuranceId,
        isLoading: isLoading,
      );
      DeleteInsuranceCard? deleteInsuranceCard;
      if (!response.hasError) {
        deleteInsuranceCard = deleteInsuranceCardFromJson(response.data);
      } else {
        Utility.showInfoDialog(
          response,
          false,
        );
      }
      return deleteInsuranceCard!;
    } catch (_) {
      return await _deviceRepository.deleteInsuranceCard(
        token: token,
        insuranceId: insuranceId,
        isLoading: isLoading,
      );
    }
  }

  Future<DeleteBankCardResponse> deleteBankCard({
    required String cardId,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.deleteCard(
        token: token,
        cardId: cardId,
        isLoading: isLoading,
      );
      DeleteBankCardResponse? deleteBankCardResponse;
      if (!response.hasError) {
        deleteBankCardResponse = deleteBankCardResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return deleteBankCardResponse!;
    } catch (_) {
      return await _deviceRepository.deleteCard(
        token: token,
        cardId: cardId,
        isLoading: isLoading,
      );
    }
  }

  Future<GetAllergiesResponse> getAllergies({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getAllergies(
        token: token,
        isLoading: isLoading,
      );
      GetAllergiesResponse? getAllergiesResponse;
      if (!response.hasError) {
        getAllergiesResponse = getAllergiesResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getAllergiesResponse!;
    } catch (_) {
      return await _deviceRepository.getAllergies(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<GetCigaretteResponse> getCigarette({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getCigarette(
        token: token,
        isLoading: isLoading,
      );
      GetCigaretteResponse? getCigaretteResponse;
      if (!response.hasError) {
        getCigaretteResponse = getCigaretteResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getCigaretteResponse!;
    } catch (_) {
      return await _deviceRepository.getCigarette(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<GetMedicationResponse> getMedication({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getMedication(
        token: token,
        isLoading: isLoading,
      );
      GetMedicationResponse? getMedicationResponse;
      if (!response.hasError) {
        getMedicationResponse = getMedicationResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getMedicationResponse!;
    } catch (_) {
      return await _deviceRepository.getMedication(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<BookWithCardResponse> bookAppointmentWithCard({
    bool isLoading = false,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String cardToken,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.bookAppointmentWithCard(
        token: token,
        doctorId: doctorId,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        paymentType: paymentType,
        reason: reason,
        cardToken: cardToken,
        isLoading: isLoading,
      );
      BookWithCardResponse? bookWithCardResponse;
      if (!response.hasError) {
        bookWithCardResponse = bookWithCardResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(
          response,
          false,
        );
      }
      return bookWithCardResponse!;
    } catch (_) {
      return await _deviceRepository.bookAppointmentWithCard(
        token: token,
        doctorId: doctorId,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        paymentType: paymentType,
        reason: reason,
        cardToken: cardToken,
        isLoading: isLoading,
      );
    }
  }

  Future<GetConversationListResponse> getConversationList({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getConversationList(
        token: token,
        isLoading: isLoading,
      );
      GetConversationListResponse? getConversationListResponse;
      if (!response.hasError) {
        /*
        //final responseStr = json.decode(response.toString());

        List<String> dataList = (jsonDecode(response.data) as List<dynamic>).cast<String>();

        print("dataList ==>> $dataList");

        for (var data in dataList) {
          data['created_at'] = data['latest_msg'] == '{}'
              ? data['created_at']
              : data['latest_msg']['created_at'];
          data['latest_msg'] =
              data['latest_msg'] == '{}' ? "" : data['latest_msg']['message'];
        }

        getConversationListResponse =
            getConversationListResponseFromJson(responseStr);*/
        getConversationListResponse =
            getConversationListResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getConversationListResponse!;
    } catch (_) {
      debugPrint(_.toString());
      return await _deviceRepository.getConversationList(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<GetUserConversationResponse> getMessages({
    required String userId,
    bool isLoading = false,
    required int pageNumber,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getMessages(
        userId: userId,
        token: token,
        pageNumber: pageNumber,
        isLoading: isLoading,
      );
      GetUserConversationResponse? getUserConversationResponse;
      if (!response.hasError) {
        getUserConversationResponse =
            getUserConversationResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getUserConversationResponse!;
    } catch (e) {
      print('exception is ============================ $e');
      return await _deviceRepository.getMessages(
        userId: userId,
        token: token,
        pageNumber: pageNumber,
        isLoading: isLoading,
      );
    }
  }

  Future<SendMessageResponse> sendMessage({
    required String userId,
    required String message,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.sendMessage(
        userId: userId,
        token: token,
        message: message,
        isLoading: isLoading,
      );
      SendMessageResponse? sendMessageResponse;
      if (!response.hasError) {
        sendMessageResponse = sendMessageResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return sendMessageResponse!;
    } catch (_) {
      print(_.toString());
      return await _deviceRepository.sendMessage(
        userId: userId,
        token: token,
        message: message,
        isLoading: isLoading,
      );
    }
  }

  Future<GetNotificationList> getNotificationList({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getNotificationList(
        token: token,
        isLoading: isLoading,
      );
      GetNotificationList? getNotificationList;
      if (!response.hasError) {
        getNotificationList = getNotificationListFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getNotificationList!;
    } catch (_) {
      return await _deviceRepository.getNotificationList(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<AddReview> addReview({
    required String doctorId,
    required String rating,
    required String comment,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.addReview(
        token: token,
        doctorId: doctorId,
        rating: rating,
        comment: comment,
        isLoading: isLoading,
      );
      AddReview? addReview;
      if (!response.hasError) {
        addReview = addReviewFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return addReview!;
    } catch (_) {
      debugPrint(_.toString());
      return await _deviceRepository.addReview(
        token: token,
        doctorId: doctorId,
        rating: rating,
        comment: comment,
        isLoading: isLoading,
      );
    }
  }

  Future<PushNotificationSetting> pushNotificationSetting({
    required String status,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.pushNotificationSetting(
        token: token,
        status: status,
        isLoading: isLoading,
      );
      PushNotificationSetting? pushNotificationSetting;
      if (!response.hasError) {
        pushNotificationSetting =
            pushNotificationSettingFromJson(response.data);
        saveValue(
            LocalKeys.pushNotification, pushNotificationSetting.data!.status);
        var email = getStringValue(LocalKeys.emailNotification);
        print(
            'apiresponse push=============================================........${pushNotificationSetting.data!.status}');
        print(
            'apiresponse push_email=============================================........$email');
      } else {
        Utility.showInfoDialog(response, false);
      }
      return pushNotificationSetting!;
    } catch (_) {
      print(_.toString());
      return await _deviceRepository.pushNotificationSetting(
        token: token,
        status: status,
        isLoading: isLoading,
      );
    }
  }

  Future<EmailNotificationSetting> emailNotificationSetting({
    required String status,
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.emailNotificationSetting(
        token: token,
        status: status,
        isLoading: isLoading,
      );
      EmailNotificationSetting? emailNotificationSetting;
      if (!response.hasError) {
        emailNotificationSetting =
            emailNotificationSettingFromJson(response.data);
        saveValue(
            LocalKeys.emailNotification, emailNotificationSetting.data!.status);
        var psuh = getStringValue(LocalKeys.pushNotification);
        print(
            'apiresponse email=============================================........${emailNotificationSetting.data!.status}');
        print(
            'apiresponse email_push=============================================........$psuh');
      } else {
        Utility.showInfoDialog(response, false);
      }
      return emailNotificationSetting!;
    } catch (_) {
      return await _deviceRepository.emailNotificationSetting(
        token: token,
        status: status,
        isLoading: isLoading,
      );
    }
  }

  Future<ReadNotificationResponse> readNotification({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.readNotification(
        token: token,
        isLoading: isLoading,
      );
      ReadNotificationResponse? readNotificationResponse;
      if (!response.hasError) {
        readNotificationResponse =
            readNotificationResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return readNotificationResponse!;
    } catch (_) {
      return await _deviceRepository.readNotification(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<ReadMessagesResponse> readMessages({
    bool isLoading = false,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.readMessages(
        token: token,
        isLoading: isLoading,
      );
      ReadMessagesResponse? readMessagesResponse;
      if (!response.hasError) {
        readMessagesResponse = readMessagesResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return readMessagesResponse!;
    } catch (_) {
      return await _deviceRepository.readMessages(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<ReviewsListResponse> reviewsList({
    required String doctorId,
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.reviewsList(
        doctorId: doctorId,
        token: token,
        isLoading: isLoading,
      );
      ReviewsListResponse? reviewsListResponse;
      if (!response.hasError) {
        reviewsListResponse = reviewsListResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return reviewsListResponse!;
    } catch (_) {
      return await _deviceRepository.reviewsList(
        doctorId: doctorId,
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<PaymentReleaseResponse> paymentRelease({
    required String bookingId,
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.paymentRelease(
        token: token,
        bookingId: bookingId,
        isLoading: isLoading,
      );
      PaymentReleaseResponse? paymentReleaseResponse;
      if (!response.hasError) {
        paymentReleaseResponse = paymentReleaseResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return paymentReleaseResponse!;
    } catch (e) {
      return await _deviceRepository.paymentRelease(
        token: token,
        bookingId: bookingId,
        isLoading: isLoading,
      );
    }
  }

  Future<LastBookingResponse> lastBookingStatus({
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.lastBookingStatus(
        token: token,
        isLoading: isLoading,
      );
      LastBookingResponse? lastBookingResponse;
      if (!response.hasError) {
        lastBookingResponse = lastBookingResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return lastBookingResponse!;
    } catch (_) {
      return await _deviceRepository.lastBookingStatus(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<UnreadMessagesResponse> unreadMessages({
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.unreadMessages(
        isLoading: isLoading,
        token: token,
      );
      UnreadMessagesResponse? unreadMessagesResponse;
      if (!response.hasError) {
        unreadMessagesResponse = unreadMessagesResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return unreadMessagesResponse!;
    } catch (e) {
      debugPrint(e.toString());
      return await _deviceRepository.unreadMessages(
        isLoading: isLoading,
        token: token,
      );
    }
  }

  Future<LogoutResponse> logoutUser({
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.logoutUser(
        token: token,
        isLoading: isLoading,
      );
      NavigateTo.goToLoginScreen();
      LogoutResponse? logoutResponse;
      if (!response.hasError) {
        logoutResponse = logoutResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return logoutResponse!;
    } catch (e) {
      print('the exception is $e');
      NavigateTo.goToLoginScreen();
      return await _deviceRepository.logoutUser(
        token: token,
        isLoading: isLoading,
      );
    }
  }

  Future<UserSupportResponse> userSupport({
    required bool isLoading,
    required String email,
    required String phone,
    required String name,
    required String description,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.userSupport(
        token: token,
        isLoading: isLoading,
        email: email,
        phone: phone,
        name: name,
        description: description,
      );
      UserSupportResponse? userSupportResponse;
      if (!response.hasError) {
        userSupportResponse = userSupportResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return userSupportResponse!;
    } catch (e) {
      return await _deviceRepository.userSupport(
        token: token,
        isLoading: isLoading,
        email: email,
        phone: phone,
        name: name,
        description: description,
      );
    }
  }

  Future<AddNoteResponse> addNote(
      {required bool isLoading,
      required String title,
      required String description,
      required String users,
      required String dateTime,
      required userId}) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.addNote(
          isLoading: isLoading,
          token: token,
          title: title,
          description: description,
          users: users,
          dateTime: dateTime,
          note_id: userId);
      AddNoteResponse? addNoteResponse;
      if (!response.hasError) {
        print('l[og ] Exception of the Erors');
        addNoteResponse = addNoteResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return addNoteResponse!;
    } catch (e) {
      print('exception is ====================================== $e');
      return await _deviceRepository.addNote(
          isLoading: isLoading,
          token: token,
          title: title,
          description: description,
          users: users,
          dateTime: dateTime,
          note_id: userId);
    }
  }

  Future<GetNotesResponse> getNotes({
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getNotes(
        isLoading: isLoading,
        token: token,
      );
      GetNotesResponse? getNotesResponse;
      if (!response.hasError) {
        getNotesResponse = getNotesResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getNotesResponse!;
    } catch (e) {
      return await _deviceRepository.getNotes(
        isLoading: isLoading,
        token: token,
      );
    }
  }

  Future<GetUserProfileResponse> getUserProfile({
    required bool isLoading,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.getUserProfile(
        isLoading: isLoading,
        token: token,
      );
      GetUserProfileResponse? getUserProfileResponse;
      if (!response.hasError) {
        getUserProfileResponse = getUserProfileResponseFromJson(response.data);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return getUserProfileResponse!;
    } catch (e) {
      print('e--=-=-=-=-=--=--=--=-=$e');
      return await _deviceRepository.getUserProfile(
        isLoading: isLoading,
        token: token,
      );
    }
  }

  Future<ParentControlResponse> parentControl({
    required bool isLoading,
    required String userId,
  }) async {
    var token = getStringValue(LocalKeys.authToken);
    try {
      var response = await _dataRepository.parentControl(
        isLoading: isLoading,
        token: token,
        userId: userId,
      );
      ParentControlResponse? parentControlResponse;
      if (!response.hasError) {
        parentControlResponse = parentControlResponseFromJson(response.data);
        saveValue(LocalKeys.authToken, parentControlResponse.activeUserToken);
      } else {
        Utility.showInfoDialog(response, false);
      }
      return parentControlResponse!;
    } catch (e) {
      return await _deviceRepository.parentControl(
        isLoading: isLoading,
        token: token,
        userId: userId,
      );
    }
  }
}
