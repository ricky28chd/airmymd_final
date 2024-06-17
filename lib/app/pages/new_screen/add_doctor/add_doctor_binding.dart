import 'package:airmymd/app/pages/new_screen/add_doctor/add_doctor_controller.dart';
import 'package:airmymd/app/pages/pages.dart';

class AddDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddDoctorControler());
  }
}
