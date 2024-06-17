import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class MedicalHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MedicalHistoryController(
        Get.put(
          MedicalHistoryPresenter(
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
