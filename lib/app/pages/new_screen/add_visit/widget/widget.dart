import 'dart:io';

import 'package:airmymd/app/app.dart';
import 'package:file_picker/file_picker.dart';

import '../../add_doctor/primary_care/primary_care_controllerr.dart';
import '../add_visit_controller.dart';

class AddVisitWidget extends StatelessWidget {
  const AddVisitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddVisitController>(builder: (controller) {
      var name = Get.put(PrimaryController());

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  isExpanded: true,
                  value: controller.selectedOption,
                  onChanged: controller.onchange,
                  items: name.doctors.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value.toString(),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    Flexible(
                      child: GlobalTextField().withIcon(
                        keyBoardType: TextInputType.none,
                        secondImage: 'assets/images/icon_calendar_new.png',
                        context: context,
                        onTap: () {
                          controller.selectDate(context);
                        },
                        showCursor: false,
                        controller: controller.controller,
                        hintText: 'Date',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: GlobalTextField().withIcon(
                        keyBoardType: TextInputType.none,
                        secondImage: 'assets/images/clock-line-icon.png',
                        context: context,
                        controller: controller.timeController,
                        onTap: () {
                          controller.selectTime(context);
                        },
                        hintText: 'Time ',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Notes',
                  style: TextStyles.darkBlack20,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    maxLines: 10,
                    controller: controller.notesController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                        hintText: 'Enter here..',
                        border: InputBorder.none,
                        hintStyle: AppTextStyle.textFieldHint,
                        contentPadding: EdgeInsets.all(8)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: const Text(
                    'Images/files',
                    style: TextStyles.extraBoldBlue15,
                  ),
                ),
                MediaPageViewLocalAndNetwork(
                  mediFiles: controller.imageList.toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Medicines from doctor',
                  style: TextStyles.darkBlack20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    itemCount: controller.foodAllergyList.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          controller.foodAllergyList[index],
                          const SizedBox(
                            height: 10,
                          ),
                          () {
                            try {
                              if (controller.medImgList.isNotEmpty) {
                                if (index >= 0 &&
                                    index < controller.medImgList.length) {
                                  return singleImageViewer(index, context);
                                } else {
                                  print("Invalid index: $index");
                                  return Container();
                                }
                              }
                            } catch (e) {
                              return Container();
                            }
                            return Container();
                          }(),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'png', 'doc', 'pdf'],
                              );
                              for (int i = 0;
                                  i < controller.medImgList.length;
                                  i++) {
                                if (controller.medImgList[i].contains(
                                    'https://login.airmymd.com/null')) {
                                  controller.medImgList.removeAt(i);
                                }
                              }
                              try {
                                controller.medImgList[index] = result!
                                    .paths.single
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', '');
                              } catch (e) {
                                print('the exception is ${e.toString()}');
                                controller.medImgList.addAll(
                                    result!.paths.map((e) => e.toString()));
                              }
                              print('length ==> ${controller.medImgList[0]}');
                              controller.update();
                              // Process the selected image
                              // ...
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Image/file',
                                  style: TextStyles.extraBoldBlue15,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: controller.foodAllergyList.length > 1
                                ? true
                                : false,
                            child: GestureDetector(
                                onTap: () {
                                  controller.removeFoodAllergy(index);
                                },
                                child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Remove',
                                    ))),
                          ),
                        ],
                      );
                    }),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    onPressed: () {
                      controller.medImgList.add("");
                      controller.foodAllergyList
                          .add(controller.addFoodAllergies());
                      controller.update();
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                    label: const Text(
                      'Add More',
                      style: TextStyles.extraBoldBlue15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: GlobalButtons().primaryButton(
                        text: 'Save',
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.addVisit();
                        }))
              ],
            ),
          ),
        ),
      );
    });
  }
}

singleImageViewer(index, context) {
  try {
    return GetBuilder<AddVisitController>(builder: (controller) {
      return Stack(
        children: [
          if (index >= 0 && index < controller.medImgList.length)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ImageViewerScreen(images: [
                            controller.medImgList[index],
                          ], initialIndex: index)));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: controller.medImgList[index]
                              .toString()
                              .toLowerCase()
                              .endsWith('doc') ||
                          controller.medImgList[index]
                              .toString()
                              .endsWith('pdf')
                      ? Container(
                          height: 200,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image: AssetImage(controller.medImgList[index]
                                          .toLowerCase()
                                          .endsWith('pdf')
                                      ? 'assets/images/pdf-icon.png'
                                      : 'assets/images/doc-icon.png'))),
                        )
                      : controller.medImgList[index].startsWith('http') &&
                              controller.medImgList[index].endsWith('g')
                          ? Image.network(height: 200, width: Get.width,
                              errorBuilder: (BuildContext, Object, StackTrace) {
                              return Container();
                            }, controller.medImgList[index].toString(),
                              fit: BoxFit.cover)
                          : Image.file(
                              errorBuilder: (BuildContext, Object, StackTrace) {
                                return Container();
                              },
                              File(controller.medImgList[index].toString()),
                              height: 200,
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                ),
              ),
            ),
          if (controller.medImgList.isNotEmpty)
            () {
              try {
                return controller.medImgList[index]
                            .toLowerCase()
                            .endsWith('g') ||
                        controller.medImgList[index]
                            .toLowerCase()
                            .endsWith('f') ||
                        controller.medImgList[index].toLowerCase().endsWith('c')
                    ? Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              controller.medImgList.removeAt(index);

                              controller.update();
                            },
                            child:
                                Image.asset('assets/images/close-round.png')))
                    : Container();
              } catch (e) {
                return Container();
              }
            }()
        ],
      );
    });
  } catch (e) {
    return Container();
  }
}
