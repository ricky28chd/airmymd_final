import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class MedicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MedicationController(
        Get.put(
          MedicationPresenter(
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
