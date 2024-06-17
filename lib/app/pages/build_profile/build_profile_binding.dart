import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/app/pages/build_profile/build_profile.dart';
import 'package:get/get.dart';



class BuildProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BuildProfileController(
        Get.put(
          BuildProfilePresenter(
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



