import 'package:airmymd/domain/domain.dart';
import 'package:get/get.dart';
import 'package:airmymd/app/pages/otp/otp.dart';

class OtpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => OtpController(
        Get.put(
          OtpPresenter(
            Get.put(
              AuthCases(Get.find()),
            ),
          ),
        ),
      ),
      fenix: true,
    );
  }
}
