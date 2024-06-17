import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class AllergiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AllergiesController(
        Get.put(
          AllergiesPresenter(
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
