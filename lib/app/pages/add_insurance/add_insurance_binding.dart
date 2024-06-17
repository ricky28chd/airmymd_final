import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class AddInsuranceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddInsuranceController(
        Get.put(
          AddInsurancePresenter(
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
