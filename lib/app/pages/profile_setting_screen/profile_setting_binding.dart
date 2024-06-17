import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/pages.dart';
import 'package:airmymd/domain/domain.dart';

class ProfileSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfileSettingController(
        Get.put(
          ProfileSettingPresenter(
            Get.put(
              AuthCases(
                Get.find(),
              ),
            ),
          ),
        ),
      ),
      fenix: true,
    );

    /// Build profile controller initialize
    Get.put(
      () => BuildProfileController(
        Get.put(
          BuildProfilePresenter(
            Get.put(
              AuthCases(
                Get.find(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
