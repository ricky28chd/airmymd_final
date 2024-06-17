import 'package:airmymd/domain/domain.dart';
import 'package:get/get.dart';
import 'package:airmymd/app/pages/set_location/set_location.dart';

class SetLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SetLocationController(
        Get.put(
          SetLocationPresenter(
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
