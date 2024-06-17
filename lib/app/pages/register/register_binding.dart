import 'package:airmymd/app/pages/register/register.dart';
import 'package:airmymd/app/pages/register/register_presenter.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterController(
        Get.put(
          RegisterPresenter(
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
