import 'package:airmymd/app/app.dart';
import '../../../domain/usecases/authcases.dart';

class TobaccoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TobaccoController(
        Get.put(
          TobaccoPresenter(
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
