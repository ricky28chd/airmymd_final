import 'package:airmymd/app/pages/walkthrough/walkthrough_controller.dart';
import 'package:get/get.dart';

class WalkThroughBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WalkThroughController());
  }

}