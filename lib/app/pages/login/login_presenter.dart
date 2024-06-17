import 'package:airmymd/app/pages/login/login.dart';
import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/login_response.dart';

class LoginPresenter {
  LoginPresenter(this.authCases);
  final AuthCases authCases;

  ///Login api call
  Future<LoginResponse> loginUserModel({
    required String email,
    required String deviceToken,
    required String password,
  }) async =>
      authCases.loginUserModel(
        email: email,
        deviceToken: deviceToken,
        password: password,
      );
}
