import 'package:airmymd/app/pages/new_screen/add_visit/add_visit_controller.dart';
import 'package:airmymd/app/pages/pages.dart';

class AddVisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddVisitController());
  }
}
