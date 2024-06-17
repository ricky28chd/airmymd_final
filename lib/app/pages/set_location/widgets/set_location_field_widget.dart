import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/navigators/app_pages.dart';

Widget setLocationField(BuildContext context) {
  return Padding(
      padding: AppPadding.outerScreenPadding,
      child: GetBuilder<SetLocationController>(builder: (controller) {
        return Column(
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                child: Obx(
                  () => TextFormField(
                    keyboardType: TextInputType.none,
                    onTap: () => Get.to(
                      LocationSearchDialog(),
                      transition: AppPages.cupertinoTransition,
                      duration: AppPages.cupertinoTransitionDuration,
                    ),
                    //Get.dialog(LocationSearchDialog()),
                    onChanged: controller.enterLocation,
                    controller: controller.locationController,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorText: controller.locationError.value == ''
                            ? null
                            : controller.locationError.value,
                        prefixIcon: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.0,
                          child: Image.asset(
                            AppImages.mapIcon,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(bottom: 5),
                        prefixIconConstraints: const BoxConstraints(
                            maxWidth: 30, minWidth: 30, maxHeight: 20),
                        suffixIcon: Align(
                          alignment: Alignment.centerRight,
                          widthFactor: 0.0,
                          child: GestureDetector(
                            onTap: controller.fetchCurrentLocation,
                            child: Image.asset(
                              AppImages.currentLocationIcon,
                            ),
                          ),
                        ),
                        suffixIconConstraints: const BoxConstraints(
                            maxWidth: 30, minWidth: 30, maxHeight: 20),
                        hintText: 'Location',
                        hintStyle: AppTextStyle.textFieldHint,
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textFieldBorder)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.textFieldBorder))),
                  ),
                )),
          ],
        );
      }));
}
