import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class AddNewCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddNewCardController(
        Get.put(
          AddNewCardPresenter(
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
