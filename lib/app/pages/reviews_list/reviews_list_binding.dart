import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';

class ReviewsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ReviewsListController(
        Get.put(
          ReviewsListPresenter(
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
