// ignore_for_file: avoid_unnecessary_containers

import 'package:airmymd/app/app.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../utils/list_data_for_project.dart';

Widget buildProfileFields(BuildContext context) {
  return GetBuilder<BuildProfileController>(builder: (controller) {
    print(controller.profileImage);

    return Container(
      alignment: Alignment.topCenter,
      padding: AppPadding.outerScreenPadding,
      child: SingleChildScrollView(
        child: Column(children: [
          AppSizeBox.height_3,
          Stack(
            children: [
              Container(
                color: Colors.transparent,
                height: Get.height * 0.13,
                width: Get.width * 0.24,
              ),
              GestureDetector(
                  onTap: () {
                    controller.getImage();
                  },
                  child: Container(
                    height: Get.height * 0.11,
                    width: Get.width * 0.24,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7)),
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.02),
                              spreadRadius: 3,
                              blurRadius: 4)
                        ],
                        image: Get.find<Repository>()
                                .getStringValue('saveImage')
                                .isNotEmpty
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(Get.find<Repository>()
                                    .getStringValue('saveImage')))
                            : controller.image != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(controller.image!))
                                : const DecorationImage(
                                    scale: 4.0,
                                    image: AssetImage(
                                      AppImages.profileIcon,
                                    ))),
                  )),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                    child: GestureDetector(
                  onTap: () {
                    controller.getImage();
                  },
                  child:
                      Image.asset(AppImages.circleAdd, height: 30, width: 30),
                )),
              ),
            ],
          ),
          AppSizeBox.height_2,
          Obx(
            () => GlobalTextField().withLabel(
              textInputAction: TextInputAction.next,
              keyBoardType: TextInputType.name,
              label: 'First Name',
              hintText: 'First Name',
              textCapitalization: TextCapitalization.words,
              controller: controller.firstNameController,
              onChanged: controller.enterFirstName,
              errorText: controller.firstNameError.value == ''
                  ? null
                  : controller.firstNameError.value,
            ),
          ),
          GlobalTextField().withLabel(
            textInputAction: TextInputAction.next,
            keyBoardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            label: 'Middle Name',
            hintText: 'Middle Name',
            controller: controller.middleNameController,
          ),
          Obx(
            () => GlobalTextField().withLabel(
              textInputAction: TextInputAction.next,
              keyBoardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              label: 'Last Name',
              hintText: 'Last Name',
              controller: controller.lastNameController,
              onChanged: controller.enterLastName,
              errorText: controller.lastNameError.value == ''
                  ? null
                  : controller.lastNameError.value,
            ),
          ),
          Obx(() => GlobalTextField().withLabel(
                textInputAction: TextInputAction.next,
                keyBoardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.words,
                editable: false,
                label: 'Email',
                hintText: 'Email',
                controller: controller.emailController,
                onChanged: controller.enterEmail,
                errorText: controller.emailError.value == ''
                    ? null
                    : controller.emailError.value,
              )),
          Obx(() => GlobalTextField().withLabel(
                textInputAction: TextInputAction.next,
                keyBoardType: TextInputType.phone,
                textCapitalization: TextCapitalization.words,
                editable: false,
                label: 'Phone',
                hintText: 'Phone',
                controller: controller.phoneController,
                onChanged: controller.enterphone,
                errorText: controller.phoneError.value == ''
                    ? null
                    : controller.phoneError.value,
              )),
          Obx(
            () => GlobalTextField().withLabel(
              textInputAction: TextInputAction.next,
              keyBoardType: TextInputType.streetAddress,
              label: 'City',
              hintText: 'City',
              textCapitalization: TextCapitalization.words,
              controller: controller.cityController,
              onChanged: controller.enterCityName,
              errorText: controller.cityError.value == ''
                  ? null
                  : controller.cityError.value,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => GlobalDropDown(
                    hintText: 'State',
                    items: state,
                    dropDownItem:
                        controller.stateDropDownItem.toString().length >= 8
                            ? controller.stateDropDownItem
                            : controller.stateDropDownItem,
                    onChanged: controller.enterStateName,
                    errorText: controller.stateError.value == ''
                        ? null
                        : controller.stateError.value,
                  ),
                ),
              ),
              AppSizeBox.width_10,
              Expanded(
                  child: Obx(() => GlobalTextField().withLabel(
                      textInputAction: TextInputAction.next,
                      keyBoardType: TextInputType.streetAddress,
                      label: 'Zip',
                      hintText: 'Zip',
                      controller: controller.zipController,
                      onChanged: controller.enterZipCode,
                      errorText: controller.zipError.value == ''
                          ? null
                          : controller.zipError.value)))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Obx(() => GlobalTextField().withLabel(
                        textInputAction: TextInputAction.next,
                        inputFormat: [
                          HeightFormatter(sample: 'x-xxx', seperator: '-')
                        ],
                        keyBoardType: TextInputType.number,
                        label: 'Height (Ft\'In")',
                        hintText: 'Height',
                        controller: controller.heightController,
                        onChanged: controller.enterHeight,
                        errorText: controller.heightError.value == ''
                            ? null
                            : controller.heightError.value,
                      ))),
              AppSizeBox.width_10,
              Expanded(
                  child: Obx(() => GlobalTextField().withLabel(
                        textInputAction: TextInputAction.done,
                        keyBoardType: TextInputType.number,
                        label: 'Weight (lbs)',
                        hintText: 'Weight',
                        controller: controller.weightController,
                        onChanged: controller.enterWeight,
                        errorText: controller.weightError.value == ''
                            ? null
                            : controller.weightError.value,
                      )))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Obx(
                () => GlobalDropDown(
                  hintText: 'Gender',
                  items: gender,
                  dropDownItem: controller.genderDropDownItem,
                  onChanged: controller.enterGender,
                  errorText: controller.genderError.value == ''
                      ? null
                      : controller.genderError.value,
                ),
              )),
              AppSizeBox.width_10,
              Expanded(
                  child: Obx(() => GlobalDropDown(
                        hintText: 'Ethnicity',
                        items: ethnicity,
                        dropDownItem: controller.ethnicityDropDownItem,
                        onChanged: controller.enterEthnicity,
                        errorText: controller.ethnicityError.value == ''
                            ? null
                            : controller.ethnicityError.value,
                      ))),
            ],
          ),
          Obx(
            () => GlobalTextField().withLabel(
              keyBoardType: TextInputType.none,
              label: 'Date Of Birth',
              onTap: () {
                controller.selectDate(context);
              },
              hintText: 'YYYY-MM-DD',
              controller: controller.dobController,
              suffixIcon: GestureDetector(
                  onTap: () {
                    controller.selectDate(context);
                  },
                  child: Image.asset(AppImages.calenderIcon)),
              onChanged: controller.enterDob,
              errorText: controller.dobError.value == ''
                  ? null
                  : controller.dobError.value,
            ),
          ),
          Obx(() => GlobalDropDown(
                hintText: 'Marital Status',
                items: maritalStatus,
                dropDownItem: controller.maritalStatusDropDownItem,
                onChanged: controller.enterMaritalStatus,
                errorText: controller.maritalError.value == ''
                    ? null
                    : controller.maritalError.value,
              )),
        ]),
      ),
    );
  });
}
