import 'package:airmymd/domain/models/user_support_response.dart';
import 'package:airmymd/domain/usecases/authcases.dart';

class SupportPresenter {
  SupportPresenter(this._authCases);
  final AuthCases _authCases;

  Future<UserSupportResponse> userSupport({
    required bool isLoading,
    required String email,
    required String phone,
    required String name,
    required String description,
  }) =>
      _authCases.userSupport(
        isLoading: isLoading,
        email: email,
        phone: phone,
        name: name,
        description: description,
      );
}
