import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/visit/visit_controller.dart';

class VisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VisitController());
  }
}
