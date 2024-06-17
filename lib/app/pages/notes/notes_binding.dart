import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:get/get.dart';

class NotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NotesController(
        Get.put(
          NotesPresenter(
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
