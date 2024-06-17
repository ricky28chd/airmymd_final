import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/register_otp_verify_response.dart';
import '../../../domain/models/login_response.dart';
import '../../../domain/models/login_otp_verify_response.dart';
import '../../../domain/models/notification_list_response.dart';
import '../../../domain/models/register_response.dart';

class OtpPresenter {
  OtpPresenter(this.authCases);
  final AuthCases authCases;

  ///login verify Otp Api call.
  Future<LoginOtpVerificationResponse> loginOtpVerificationModel({
    required String otp,
    required String navigateFrom,
  }) async =>
      authCases.loginOtpVerificationModel(
        otp: otp,
        navigateFrom: navigateFrom,
      );

  ///register verify Otp Api call.
  Future<RegisterOtpVerificationResponse> registerOtpVerificationModel({
    required String otp,
    required String navigateFrom,
  }) async =>
      authCases.registerOtpVerificationModel(
        otp: otp,
        navigateFrom: navigateFrom,
      );

  ///generate Otp again while Register
  Future<SignUpResponse> signUpUserModel({
    required String email,
    required String phoneNumber,
    required String password
  }) async =>
      authCases.signUpUserModel(
        email: email,
        phoneNumber: phoneNumber,
        password: password
      );

  ///generate Otp again while Login
  Future<LoginResponse> loginUserModel({
    required String email,
    required String deviceToken,
    required String password
  }) =>
      authCases.loginUserModel(
        email: email,
        deviceToken: deviceToken,
        password: password
      );

  Future<GetNotificationList> getNotificationList({
    bool isLoading = false,
  }) async =>
      authCases.getNotificationList(
        isLoading: isLoading,
      );
}
