import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/register_response.dart';


///This the page which communicates between controller page and authCases.
///This page will receive response and also send valid data to authCases.

class RegisterPresenter {
  RegisterPresenter(this.authCases);
  final AuthCases authCases;

  ///SignUp Api call
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
}
