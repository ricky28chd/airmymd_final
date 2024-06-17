import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:get/get.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SupportController(
        Get.put(
          SupportPresenter(
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
