import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class InsuranceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => InsuranceListController(
        Get.put(
          InsuranceListPresenter(
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
