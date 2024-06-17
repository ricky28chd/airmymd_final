import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class AlcoholBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AlcoholController(
        Get.put(
          AlcoholPresenter(
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
