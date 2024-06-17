import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/save_insurance.dart';

class AddInsurancePresenter {
  AddInsurancePresenter(this.authCases);
  final AuthCases authCases;

  Future<AddInsuranceResponse> addInsuranceResponse({
    required String id,
    required String provider,
    required String phone,
    required String groupNumber,
    required String filePath,
  }) async =>
      authCases.addInsuranceResponse(
        id: id,
        provider: provider,
        phone: phone,
        groupNumber: groupNumber,
        filePath: filePath,
      );
}
