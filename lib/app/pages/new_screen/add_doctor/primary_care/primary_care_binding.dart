import 'package:airmymd/app/pages/new_screen/add_doctor/primary_care/primary_care_controllerr.dart';
import 'package:airmymd/app/pages/pages.dart';

class PrimaryCareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrimaryController());
    // TODO: implement dependencies
  }
}
