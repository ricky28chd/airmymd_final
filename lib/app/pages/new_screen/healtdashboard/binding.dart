import 'package:airmymd/app/pages/pages.dart';

import 'conroller.dart';

class HealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HealthDashboardController());
  }
}
