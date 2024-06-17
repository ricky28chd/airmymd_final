import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class SurgeriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SurgeriesController(
        Get.put(
          SurgeriesPresenter(
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
