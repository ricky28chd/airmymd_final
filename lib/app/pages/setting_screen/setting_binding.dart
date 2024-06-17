import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class UserSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => UserSettingController(
        Get.put(
          UserSettingPresenter(
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
  }
}
