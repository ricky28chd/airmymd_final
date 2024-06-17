import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class BookAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BookAppointmentController(
        Get.put(
          BookAppointmentPresenter(
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
