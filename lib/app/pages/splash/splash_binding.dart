import 'package:airmymd/app/pages/splash/splash.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(
        Get.put(
          SplashPresenter(
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
