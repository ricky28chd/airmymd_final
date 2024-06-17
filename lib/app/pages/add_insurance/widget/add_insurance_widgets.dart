import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddInsuranceWidget extends StatelessWidget {
  const AddInsuranceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddInsuranceController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_3,
              const Text(
                PageConstants.kUploadInsuranceCard,
                style: AppTextStyle.mainHeading,
              ),
              AppSizeBox.height_3,
              GestureDetector(
                onTap: () {
                  controller.getImage();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.containerBackground,
                      image: controller.insuranceImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(controller.insuranceImage))
                          : controller.image != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(controller.image!))
                              : const DecorationImage(
                                  scale: 4.0,
                                  image: AssetImage(
                                    AppImages.uploadImageIcon,
                                  ))),
                  height: Get.height / 4,
                  width: Get.width * 1,
                ),
              ),
              AppSizeBox.height_2,
              addInsuranceField(),
              addInsuranceButton(),
               AppSizeBox.height_2,
              controller.navigateFrom == 'Setting Screen' && controller.navigateFrom == 'Setting Screen'
                  ? Container()
                  : Center(
                      child: GlobalButtons().primaryButton(
                          text: 'Skip',
                          onTap:   NavigateTo.goToFindDoctorScreen),
                    ),
              AppSizeBox.height_5,
            ],
          ),
        ),
      );
    });
  }
}
