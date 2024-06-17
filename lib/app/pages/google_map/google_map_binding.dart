import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class GoogleMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => GoogleScreenController(
        Get.put(
          GoogleScreenPresenter(
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