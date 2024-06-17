import 'package:airmymd/app/app.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsListWidget extends StatelessWidget {
  const ReviewsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsListController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppPadding.mainScreenPadding,
          child: controller.allReviewsList == null
              ? Container()
              : controller.allReviewsList!.reviews!.isEmpty
                  ? SizedBox(
                      height: Get.height / 1.7,
                      child: const Center(child: Text('No Reviews yet!!!')))
                  : ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Container(
                            height: Get.height * 0.10,
                            width: Get.width * 0.10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.containerBackground,
                                image: controller
                                            .allReviewsList!
                                            .reviews![index]
                                            .patientProfileData!
                                            .profilePhotoUrl !=
                                        null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(controller
                                            .allReviewsList!
                                            .reviews![index]
                                            .patientProfileData!
                                            .profilePhotoUrl!))
                                    : const DecorationImage(
                                        scale: 4,
                                        image:
                                            AssetImage(AppImages.profileIcon))),
                          ),
                          title: Text(
                            '${controller.allReviewsList!.reviews![index].patientProfileData!.firstName} '
                            '${controller.allReviewsList!.reviews![index].patientProfileData!.middleName} '
                            '${controller.allReviewsList!.reviews![index].patientProfileData!.lastName}',
                            style: TextStyles.darkBlack15,
                          ),
                          subtitle: Text(
                            '${controller.allReviewsList!.reviews![index].review}',
                            style: TextStyles.darkMedium12,
                          ),
                          trailing: RatingBar.builder(
                            initialRating: controller.allReviewsList!
                                    .reviews![index].rating!.isNotEmpty
                                ? double.parse(controller
                                    .allReviewsList!.reviews![index].rating!)
                                : 0.0,
                            itemSize: 17,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ignoreGestures: true,
                            itemPadding: EdgeInsets.zero,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: AppColors.primaryColor,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 2,
                          color: AppColors.containerBackground,
                        );
                      },
                      itemCount: controller.allReviewsList!.reviews!.length),
        ),
      );
    });
  }
}
