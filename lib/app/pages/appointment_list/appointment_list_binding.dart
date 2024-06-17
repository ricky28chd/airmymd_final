import 'package:airmymd/app/app.dart';

import 'package:airmymd/domain/domain.dart';

class AppointmentListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AppointmentListController(
        Get.put(
          AppointmentListPresenter(
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
