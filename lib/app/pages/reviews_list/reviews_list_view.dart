import 'package:airmymd/app/app.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsListController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(
              controller.allReviewsList == null
                  ? ''
                  : '${controller.allReviewsList!.doctorProfile!.firstName} '
                      '${controller.allReviewsList!.doctorProfile!.lastName}',
              style: AppTextStyle.appBarHeading,
            )),
        body: const ReviewsListWidget(),
      );
    });
  }
}
