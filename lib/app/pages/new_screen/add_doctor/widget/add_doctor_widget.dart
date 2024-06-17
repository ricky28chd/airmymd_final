import 'dart:io';

import 'package:airmymd/app/app.dart';
import 'package:flutter/services.dart';

import '../../../../utils/list_data_for_project.dart';
import '../add_doctor_controller.dart';

class AddDoctorWidget extends StatelessWidget {
  const AddDoctorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDoctorControler>(builder: (controller) {
      print('object the image is ${controller.imagePath}');
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    GlobalTextField().withLabel(
                        context: context,
                        textCapitalization: TextCapitalization.sentences,
                        hintText: 'Office Name',
                        label: 'Office Name',
                        textInputAction: TextInputAction.next,
                        validator: controller.organisationNameValidator,
                        controller: controller.officeNameController),
                    GlobalTextField().withLabel(
                        context: context,
                        textCapitalization: TextCapitalization.sentences,
                        hintText: 'First Name',
                        label: 'First Name',
                        textInputAction: TextInputAction.next,
                        validator: controller.firstNameValidator,
                        controller: controller.fNameController),
                    GlobalTextField().withLabel(
                        context: context,
                        textCapitalization: TextCapitalization.sentences,
                        hintText: 'Last Name',
                        label: 'Last Name',
                        textInputAction: TextInputAction.next,
                        validator: controller.lastControllerValidator,
                        controller: controller.lastController),
                    GlobalTextField().withLabel(
                        context: context,
                        textCapitalization: TextCapitalization.sentences,
                        hintText: 'Address',
                        label: 'Address',
                        textInputAction: TextInputAction.next,
                        validator: controller.addressValidator,
                        controller: controller.addressConroller),
                    GlobalTextField().withLabel(
                        context: context,
                        textCapitalization: TextCapitalization.sentences,
                        validator: controller.cityValidator,
                        hintText: 'City',
                        label: 'City',
                        textInputAction: TextInputAction.next,
                        controller: controller.cityConroller),
                    Row(
                      children: [
                        Flexible(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('State', // Label text
                                style: TextStyle(
                                    color: AppColors.textFieldHintText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                            DropdownButton<String>(
                              isDense: true,
                              itemHeight: 70,
                              isExpanded: true,
                              value: controller.selectedOption,
                              onChanged: (newValue) {
                                controller.selectedOption = newValue!;
                                controller.update();
                              },
                              items: state.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        )),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: GlobalTextField().withLabel(
                              context: context,
                              keyBoardType: TextInputType.phone,
                              hintText: 'Zip',
                              label: 'Zip',
                              textInputAction: TextInputAction.next,
                              validator: controller.zipValidator,
                              controller: controller.zipConroller),
                        ),
                      ],
                    ),
                    GlobalTextField().withLabel(
                        context: context,
                        validator: controller.emailNameValidator,
                        hintText: 'Email',
                        label: 'Email',
                        textInputAction: TextInputAction.next,
                        controller: controller.emailController),
                    GlobalTextField().withLabel(
                        context: context,
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        keyBoardType: TextInputType.phone,
                        validator: controller.phoneValidator,
                        hintText: 'Phone Number',
                        label: 'Phone Number',
                        textInputAction: TextInputAction.next,
                        controller: controller.phoneController),
                    GlobalTextField().withLabel(
                        context: context,
                        validator: controller.websiteValidator,
                        hintText: 'Website',
                        label: 'Website',
                        textInputAction: TextInputAction.done,
                        controller: controller.websiteController),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Image',
                              style: TextStyles.extraBoldBlue15,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (controller.imagePath.isNotEmpty)
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: controller.imagePath.startsWith('https://')
                                  ? Image.network(
                                      controller.imagePath,
                                      height: 200,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container();
                                      },
                                    )
                                  : Image.file(
                                      File(controller.imagePath),
                                      height: 200,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container();
                                      },
                                    ),
                            ),
                          ),
                          if (controller.imagePath.isNotEmpty)
                            Container(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                      onTap: () {
                                        controller.imagePath = '';
                                        controller.update();
                                      },
                                      child: Image.asset(
                                          'assets/images/close-round.png'))),
                            )
                        ],
                      ),
                    const SizedBox(
                      height: 80,
                    ),
                    GlobalButtons().primaryButton(
                        text: controller.doctorId != null ? 'Update' : 'Save',
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.addDotor();
                          }
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
