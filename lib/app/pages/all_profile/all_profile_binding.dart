import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/app/pages/pages.dart';
import 'package:airmymd/domain/domain.dart';

class AllProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllProfileController(
        Get.put(AllProfilePresenter(Get.put(AuthCases(Get.find()))))));
  }
}
