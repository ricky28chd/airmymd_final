import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class PaymentCardListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => PaymentCardListController(
        Get.put(
          PaymentCardListPresenter(
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
