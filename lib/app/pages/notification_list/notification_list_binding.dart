import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class NotificationListBinging extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NotificationListController(
        Get.put(
          NotificationListPresenter(
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
