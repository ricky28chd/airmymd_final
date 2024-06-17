import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget doctorListField() {
  return GetBuilder<GoogleScreenController>(builder: (controller) {
    return Container(
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: controller.totalCount == 0
            ? Container(
                alignment: Alignment.center,
                child: Text(
                  'No ${controller.specialization} is available at \n${controller.userCurrentLocation.text}',
                  textAlign: TextAlign.center,
                ))
            : RefreshIndicator(
                color: AppColors.whiteColor,
                backgroundColor: AppColors.primaryColor,
                onRefresh: controller.onRefreshList,
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          NavigateTo.goToDoctorProfileScreen(
                            doctorId: controller
                                .doctorList[index].profile!.userId
                                .toString(),
                            specialization: controller.specialization,
                          );
                        },
                        child: SizedBox(
                            width: Get.width * 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color:
                                              AppColors.containerBackground)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          '${controller.doctorList[index].profilePhotoUrl}',
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                            AppImages.profileIcon);
                                      },
                                    ),
                                  ),
                                ),
                                AppSizeBox.width_4,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Dr. ${controller.doctorList[index].profile!.firstName.toString().capitalize} ${controller.doctorList[index].profile!.lastName.toString().capitalize}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.doctorNameTitle,
                                      ),
                                      AppSizeBox.height_002,
                                      Text(
                                        '${controller.doctorList[index].profile!.address.toString().capitalize}',
                                        style:
                                            TextStyles.darkMediumWithHeight14,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      AppSizeBox.height_002,
                                      RichText(
                                          text: TextSpan(
                                              text: 'Consultation fee: ',
                                              style: TextStyles.darkMedium14,
                                              children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    ' \$${controller.doctorList[index].profile!.fees.toString()}',
                                                style:
                                                    TextStyles.extraBoldBlue15)
                                          ]))
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    NavigateTo.goToReviewsListScreen(
                                        doctorId: controller.doctorList[index]
                                            .profile!.userId!);
                                  },
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: (controller
                                                .doctorList[index]
                                                .averageRating!
                                                .isNotEmpty)
                                            ? double.parse(controller
                                                .doctorList[index]
                                                .averageRating!)
                                            : 0.0,
                                        itemSize: 17,
                                        ignoreGestures: true,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.zero,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star_rounded,
                                          color: AppColors.primaryColor,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      Text(
                                        '(${controller.doctorList[index].reviews!.length.toString()} Reviews)',
                                        style: TextStyles.darkPlain13,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 10),
                        child: Divider(
                          thickness: 1,
                        ),
                      );
                    },
                    itemCount: controller.doctorList.length),
              ),
      ),
    );
  });
}
