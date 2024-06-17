import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class SexualHealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SexualHealthController(
        Get.put(
          SexualHealthPresenter(
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
