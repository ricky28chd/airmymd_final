import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class GeneralHealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => GeneralHealthController(
        Get.put(
          GeneralHealthPresenter(
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
