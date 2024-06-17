import 'package:airmymd/app/app.dart';

class SetLocationWidget extends StatelessWidget {
  const SetLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_setLocationLogo(), _bottomFormField(context)],
        ),
      ),
    );
  }
}

Widget _setLocationLogo() {
  return Expanded(
    child: GetBuilder<SetLocationController>(builder: (controller) {
      return Container(
        height: Get.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 120),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    NavigateTo.goToFindDoctorScreen();
                  },
                  child: controller.navigateFrom != 'findDoctor'
                      ? Container()
                      : const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 25,
                        ),
                ),
              ),
            ),
            Image.asset(
              AppImages.logo,
              height: Get.height * 0.15,
            ),
          ],
        ),
      );
    }),
  );
}

Widget _bottomFormField(BuildContext context) {
  return Expanded(
    child: Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            PageConstants.kYourLocation,
            style: AppTextStyle.authenticationHeading,
          ),
          AppSizeBox.height_1,
          const Text(
            PageConstants.kPleaseProvideYourLocationForBestMatches,
            style: AppTextStyle.authenticationSubHeading,
          ),
          const Spacer(),
          setLocationField(context),
          const Spacer(),
          setLocationFormButton(),
        ],
      ),
    ),
  );
}
