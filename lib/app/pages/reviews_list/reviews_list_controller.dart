import 'package:airmymd/app/app.dart';

import '../../../domain/models/reviews_list_response.dart';

class ReviewsListController extends GetxController {
  ReviewsListController(this._reviewsListPresenter);
  final ReviewsListPresenter _reviewsListPresenter;

  var doctorId = Get.arguments['doctorId'];

  Data? allReviewsList;

  Future<void> reviewsList() async {
    var response = await _reviewsListPresenter.reviewsList(
      doctorId: doctorId,
      isLoading: true,
    );
    if (response.data != null) {
      allReviewsList = response.data!;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    reviewsList();
  }
}
