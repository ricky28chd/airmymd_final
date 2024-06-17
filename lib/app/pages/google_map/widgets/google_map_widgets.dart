import 'package:airmymd/app/app.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleScreenController>(builder: (controller) {
      return Stack(
        children: [
          controller.totalCount == 0
              ? Container(
                  alignment: Alignment.center,
                  child: Text(
                    'No ${controller.specialization} is available at \n${controller.userCurrentLocation.text}',
                    textAlign: TextAlign.center,
                  ))
              : GoogleMap(
                  myLocationButtonEnabled: false,
                  circles: {
                    Circle(
                      strokeWidth: 1,
                      fillColor: AppColors.primaryColor.withOpacity(0.2),
                      strokeColor: AppColors.primaryColor,
                      circleId: CircleId('id'),
                      center: LatLng(double.parse(controller.defaultLatitude),
                          double.parse(controller.defaultLongitude)),
                      radius: 32186.9,
                    )
                  },
                  onMapCreated: controller.onMapCreated,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  mapType: MapType.terrain,
                  markers: controller.markers.values.toSet(),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(controller.defaultLatitude),
                          double.parse(controller.defaultLongitude)),
                      zoom: 9.5),
                ),
          Obx(
            () => Visibility(
                visible: controller.doctorLisVisible.value,
                child: doctorListField()),
          ),
        ],
      );
    });
  }
}

Widget mapBottomView(
    {required String doctorName,
    required String address,
    required String doctorFee,
    required String averageRating,
    required double initialRating,
    GestureTapCallback? onRateTap,
    void Function()? onTap,
    DecorationImage? decorationImage}) {
  return GetBuilder<GoogleScreenController>(builder: (controller) {
    return Stack(
      children: [
        Container(
          height: Get.height / 2.6,
          width: Get.width * 1,
          color: Colors.transparent,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: Get.height / 3.1,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          doctorName,
                          style: TextStyles.darkBlack20,
                        ),
                        AppSizeBox.height_1,
                        Text(
                          address,
                          style: TextStyles.darkPlain14,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSizeBox.height_1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Consultation fee: ',
                              style: TextStyles.darkMedium17,
                            ),
                            Text(
                              '\$$doctorFee',
                              style: TextStyles.extraBoldBlue15,
                            ),
                          ],
                        ),
                        AppSizeBox.height_1,
                        GestureDetector(
                          onTap: onRateTap,
                          child: RatingBar.builder(
                            initialRating: initialRating,
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
                        ),
                        AppSizeBox.height_1,
                        GestureDetector(
                          onTap: onRateTap,
                          child: Text(
                            '($averageRating Reviews)',
                            style: TextStyles.darkPlain14,
                          ),
                        ),
                        AppSizeBox.height_2,
                        GlobalButtons()
                            .primaryButton(text: 'View', onTap: onTap!),
                        AppSizeBox.height_3,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            left: 140,
            right: 140,
            child: Container(
              height: Get.height * 0.12,
              decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5.0),
                  image: decorationImage),
            )),
      ],
    );
  });
}
