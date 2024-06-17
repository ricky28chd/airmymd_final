import 'package:airmymd/app/app.dart';

class SupportWidget extends StatelessWidget {
  const SupportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            AppSizeBox.height_4,
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryColor,
                child: Image.asset(
                  AppImages.supportIcon,
                  scale: 25,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyles.darkBlack16,
                  ),
                  Text(
                    controller.userName,
                    style: TextStyles.greyPlain13,
                  ),
                  AppSizeBox.height_2,
                  const Text(
                    'Email',
                    style: TextStyles.darkBlack16,
                  ),
                  Text(
                    controller.userEmail,
                    style: TextStyles.greyPlain13,
                  ),
                  AppSizeBox.height_2,
                  const Text(
                    'Phone',
                    style: TextStyles.darkBlack16,
                  ),
                  Text(
                    controller.userPhone,
                    style: TextStyles.greyPlain13,
                  ),
                  AppSizeBox.height_2,
                  const Text(
                    'Description',
                    style: TextStyles.darkBlack16,
                  ),
                  AppSizeBox.height_1,
                  Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      onChanged: controller.enterDescription,
                      controller: controller.descriptionController,
                      style: AppTextStyle.textFieldInput,
                      maxLines: 5,
                      decoration: InputDecoration(
                          errorText: controller.descriptionTextError.value == ''
                              ? null
                              : controller.descriptionTextError.value,
                          hintText: 'Explain your issue',
                          hintStyle: TextStyles.greyPlain13,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: AppColors.textFieldBorder)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: AppColors.textFieldBorder)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: AppColors.redColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: AppColors.redColor))),
                    ),
                  ),
                  AppSizeBox.height_5,
                  Align(
                      alignment: Alignment.center,
                      child: GlobalButtons().primaryButton(
                          text: 'Submit', onTap: controller.userSupport))
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
