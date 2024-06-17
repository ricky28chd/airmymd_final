import 'package:airmymd/domain/models/reviews_list_response.dart';
import 'package:airmymd/domain/usecases/authcases.dart';

class ReviewsListPresenter {
  ReviewsListPresenter(this.authCases);
  final AuthCases authCases;

  Future<ReviewsListResponse> reviewsList({
    required String doctorId,
    required bool isLoading,
  }) async =>
      authCases.reviewsList(
        doctorId: doctorId,
        isLoading: isLoading,
      );
}
