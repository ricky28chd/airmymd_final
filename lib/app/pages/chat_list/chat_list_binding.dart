import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class ChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ChatListController(
        Get.put(
          ChatListPresenter(
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
