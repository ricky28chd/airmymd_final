import 'package:airmymd/domain/models/register_response.dart';
import 'package:airmymd/domain/repositories/domain_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';

class DeviceRepository extends DomainRepository {
  /// initialize flutter secure storage
  final _flutterSecureStorage = const FlutterSecureStorage();

  /// Returns the box in which the data is stored.
  Box _getBox() => Hive.box<dynamic>('airmymd');

  @override
  String getStringValue(String key) {
    var box = _getBox();
    var value = box.get(key) as String? ?? '';
    return value;
  }

  ///To get Int Value
  @override
  int getIntValue(String key) {
    var box = _getBox();
    var defaultValue = 0;
    var value = box.get(key, defaultValue: defaultValue) as int;
    return value;
  }

  ///to save a value
  @override
  void saveValue(dynamic key, dynamic value) {
    _getBox().put(key, value);
  }

  @override
  bool getBoolValue(String key) {
    var box = _getBox();
    var defaultValue = false;
    var value = box.get(key, defaultValue: defaultValue) as bool;
    return value;
  }

  ///to clear data
  @override
  void clearData(dynamic key) {
    _getBox().delete(key);
  }

  /// clear all data
  @override
  void clearBox() {
    _getBox().clear();
  }

  @override
  void deleteAllSecuredValues() {
    _flutterSecureStorage.deleteAll();
  }

  @override
  void deleteSecuredValue(String key) {
    _flutterSecureStorage.delete(key: key);
  }

  @override
  Future<String?> getSecuredValue(String key) async {
    var value = await _flutterSecureStorage.read(key: key);
    return value;
  }

  @override
  void saveValueSecurely(String key, String value) {
    _flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<SignUpResponse> registerUserModel(
      {required String email,
      required String phoneNumber,
      required String password}) {
    throw UnimplementedError();
  }

  @override
  Future loginUserModel(
      {required String email,
      required String deviceToken,
      required String password}) {
    throw UnimplementedError();
  }

  @override
  Future locationUserModel({
    required String location,
    required String token,
    required String longitude,
    required String latitude,
  }) {
    throw UnimplementedError();
  }

  @override
  Future profileUserModel(
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
      required String token}) {
    throw UnimplementedError();
  }

  @override
  Future registerOtpVerificationModel({
    required String otp,
    required String navigateFrom,
  }) {
    throw UnimplementedError();
  }

  @override
  Future medicalHistoryUserModel({
    required String medicalHistory,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future surgeriesUserModel({
    required String surgery,
    required String year,
    required String age,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future allergyUserModel({
    required List<Map<String, dynamic>> map,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future medicationUserModel({
    required List<Map<String, dynamic>> map,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future generalHealthUserModel(
      {required String general,
      required String skinProblem,
      required String eyeEarProblem,
      required String token}) {
    throw UnimplementedError();
  }

  @override
  Future healthHabitsUserModel(
      {required String healthHabit, required String token}) {
    throw UnimplementedError();
  }

  @override
  Future sexualHealthUserModel(
      {required String sexualStatus, required String token}) {
    throw UnimplementedError();
  }

  @override
  Future alcoholUserModel({
    required String drinkAlcohol,
    required String howMany,
    required String inADay,
    required String cutDown,
    required String feltGuilty,
    required String morningDrink,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future drugUserModel({
    required String streetDrug,
    required String needleDrug,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future addInsuranceUserModel({
    required String id,
    required String provider,
    required String phone,
    required String groupNumber,
    required String filePath,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future specializationUserModel({
    required String token,
    required String latitude,
    required String longitude,
    required bool isLoading,
  }) {
    throw UnimplementedError();
  }

  @override
  Future doctorListUserModel({
    required String latitude,
    required String longitude,
    required String specialization,
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getDoctorDetail({
    required String doctorId,
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getAllAppointments({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getInsuranceList({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getTimeSlots({
    required String token,
    required String doctorId,
    required String bookingDate,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future bookingWithInsuranceModel({
    required String token,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String sourceId,
    required String sourceName,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future deleteAppointmentUserModel({
    required String token,
    required int appointmentId,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future saveCardDetails({
    required String token,
    required String cardNumber,
    required String cardName,
    required String expMonth,
    required String expYear,
    required String cardCvv,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future saveTobacco({
    required Map<String, dynamic> cigarette,
    required String tobacco,
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future deleteCard({
    bool isLoading = false,
    required String token,
    required String cardId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future deleteInsuranceCard({
    bool isLoading = false,
    required String token,
    required String insuranceId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getAllCard({
    bool isLoading = false,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future bookAppointmentWithCard({
    required String token,
    bool isLoading = false,
    required int doctorId,
    required String bookingDate,
    required String bookingTime,
    required String paymentType,
    required String reason,
    required String cardToken,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getAllergies({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getCigarette({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getMedication({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getConversationList({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getMessages({
    required String userId,
    bool isLoading = false,
    required String token,
    required int pageNumber,
  }) {
    throw UnimplementedError();
  }

  @override
  Future sendMessage({
    required String userId,
    required String token,
    required String message,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getNotificationList({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future addReview({
    required String token,
    required String doctorId,
    required String rating,
    required String comment,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future emailNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future pushNotificationSetting({
    required String token,
    required String status,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future readMessages({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future readNotification({
    required String token,
    bool isLoading = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future reviewsList({
    required String doctorId,
    required String token,
    required bool isLoading,
  }) {
    throw UnimplementedError();
  }

  @override
  Future lastBookingStatus({
    required String token,
    required bool isLoading,
  }) {
    throw UnimplementedError();
  }

  @override
  Future paymentRelease({
    required String token,
    required String bookingId,
    required bool isLoading,
  }) {
    throw UnimplementedError();
  }

  @override
  Future unreadMessages({
    required bool isLoading,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future logoutUser({
    required String token,
    required bool isLoading,
  }) {
    throw UnimplementedError();
  }

  @override
  Future userSupport({
    required String token,
    required bool isLoading,
    required String email,
    required String phone,
    required String name,
    required String description,
  }) {
    throw UnimplementedError();
  }

  @override
  Future addNote({
    required bool isLoading,
    required String token,
    required String title,
    required String description,
    required String users,
    required String dateTime,
    required note_id,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getNotes({
    required bool isLoading,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future getUserProfile({
    required bool isLoading,
    required String token,
  }) {
    throw UnimplementedError();
  }
  
  @override
  Future parentControl({required bool isLoading, required String token, required String userId,}) {
    
    throw UnimplementedError();
  }
}
