import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class DoctorProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DoctorProfileController(
        Get.put(
          DoctorProfilePresenter(
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
