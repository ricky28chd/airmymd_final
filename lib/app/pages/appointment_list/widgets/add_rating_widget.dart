import 'package:airmymd/app/app.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget addRatingWidget({GestureTapCallback? onTap}) {
  return GetBuilder<AppointmentListController>(builder: (controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      margin: const EdgeInsets.all(10),
      width: Get.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate Your Appointment',
              style: TextStyles.darkMedium14,
            ),
            RatingBar.builder(
              unratedColor: AppColors.greyText,
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.all(0),
              itemBuilder: (context, _) => const Icon(
                Icons.star_rounded,
                color: AppColors.primaryColor,
              ),
              onRatingUpdate: (rating) {
                controller.rating = rating.toInt();
              },
            ),
            const Text(
              'Your Review',
              style: TextStyles.darkMedium14,
            ),
            AppSizeBox.height_1,
            TextFormField(
              controller: controller.reviewController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              maxLines: 5,
              decoration: InputDecoration(
                  hintText: 'Please rate and review this '
                      ' appointment so the doctor can continue '
                      'providing better service!',
                  hintStyle: TextStyles.greyMedium14,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          const BorderSide(color: AppColors.textFieldBorder)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          const BorderSide(color: AppColors.textFieldBorder))),
            ),
            AppSizeBox.height_3,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      alignment: Alignment.center,
                      //padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 40,
                      width: Get.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.blackColor)),
                      child: const Text(
                        'Not Now',
                        textAlign: TextAlign.center,
                        style: TextStyles.darkMedium17,
                      ),
                    ),
                  ),
                ),
                AppSizeBox.width_5,
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      alignment: Alignment.center,
                      //padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 40,
                      width: Get.width / 2,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'Rate',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.buttonText,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  });
}
