import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:airmymd/domain/repositories/repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorProfileWidget extends StatelessWidget {
  const DoctorProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "\n\nthe user id is : ${Get.find<Repository>().getStringValue(LocalKeys.userId)}\n\n");
    return GetBuilder<DoctorProfileController>(builder: (controller) {
      print('controller value is ${controller.doctorDetail.profile?.id}');
      return Padding(
        padding: AppPadding.outerScreenPadding,
        child: SingleChildScrollView(
          child: controller.doctorDetail.profile == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizeBox.height_2,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.18,
                          height: Get.height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.containerBackground)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  '${controller.doctorDetail.profilePhotoUrl}',
                              errorWidget: (context, url, error) {
                                return Image.asset(AppImages.profileIcon);
                              },
                            ),
                          ),
                        ),
                        AppSizeBox.width_3,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dr. ${controller.doctorDetail.profile!.firstName.toString().capitalizeFirst} ${controller.doctorDetail.profile!.lastName.toString().capitalizeFirst}',
                                    style: AppTextStyle.doctorNameTitle,
                                  ),
                                  Text(
                                    '\$${controller.doctorDetail.profile!.fees}',
                                    style: TextStyles.extraBoldBlue15,
                                  ),
                                ],
                              ),
                              AppSizeBox.height_005,
                              GestureDetector(
                                onTap: () {
                                  NavigateTo.goToReviewsListScreen(
                                    doctorId: controller.doctorId,
                                  );
                                },
                                child: Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: controller.doctorDetail
                                              .averageRating!.isNotEmpty
                                          ? double.parse(controller
                                              .doctorDetail.averageRating!)
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
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    AppSizeBox.height_005,
                                    Text(
                                      '(${controller.doctorDetail.reviews!.length} Reviews)',
                                      style: TextStyles.darkPlain13,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSizeBox.height_1,
                    const Divider(),
                    Text(
                      controller.doctorDetail.profile!.bio.toString(),
                      style: TextStyles.darkMedium14,
                    ),
                    AppSizeBox.height_3,
                    const Text(
                      'Location',
                      style: AppTextStyle.mainHeading,
                    ),
                    AppSizeBox.height_1,
                    Text(
                      '${controller.doctorDetail.profile!.address.toString().capitalize}',
                      style: TextStyles.darkMedium14,
                    ),
                    AppSizeBox.height_2,
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.containerBackground,
                          borderRadius: BorderRadius.circular(10)),
                      height: Get.height / 5,
                      child: GoogleMap(
                        myLocationButtonEnabled: false,
                        onMapCreated: controller.onMapCreated,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        markers: controller.marker,
                        mapType: MapType.terrain,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              double.parse(
                                  controller.doctorDetail.profile!.latitude!),
                              double.parse(
                                  controller.doctorDetail.profile!.longitude!)),
                          zoom: 10.0,
                        ),
                      ),
                    ),
                    AppSizeBox.height_10,
                    controller.doctorDetail.profile?.userId.toString() ==
                            Get.find<Repository>()
                                .getStringValue(LocalKeys.userId)
                        ? const SizedBox.shrink()
                        : doctorProfileButton(),
                    AppSizeBox.height_5,
                  ],
                ),
        ),
      );
    });
  }
}
