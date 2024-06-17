import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class DrugsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DrugsController(
        Get.put(
          DrugsPresenter(
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
