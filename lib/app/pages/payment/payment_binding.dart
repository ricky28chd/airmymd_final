import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => PaymentController(
        Get.put(
          PaymentPresenter(
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
