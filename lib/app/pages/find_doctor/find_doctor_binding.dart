import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class FindDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FindDoctorController(
        Get.put(
          FindDoctorPresenter(
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
