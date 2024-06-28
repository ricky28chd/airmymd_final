import 'package:airmymd/app/pages/new_screen/add_visit/add_visit_controller.dart';
import 'package:airmymd/app/pages/new_screen/add_visit/widget/widget.dart';
import 'package:airmymd/domain/entities/enums.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../app.dart';

import 'primary_care_controllerr.dart';

var visitorList;
var doctorList;

class UserVisitViewScreen extends StatefulWidget {
  final String? type;
  final data;
  const UserVisitViewScreen(
      {super.key, required this.data, this.type = 'true'});

  @override
  State<UserVisitViewScreen> createState() => _UserVisitViewScreenState();
}

class _UserVisitViewScreenState extends State<UserVisitViewScreen> {
  var visitController = Get.put(AddVisitController());
  @override
  void initState() {
    try {
      visitController.foodAllergyList.clear();
      visitController.medImgList.clear();

      for (int i = 0; i < widget.data.length; i++) {
        visitController.foodAllergyList.add(visitController.addFoodAllergies());
      }

      for (int i = 0; i < visitController.foodAllergyList.length; i++) {
        visitController.nameControllerList[i].text =
            widget.data[i]["name"].toString();
        print(visitController.nameControllerList);
        visitController.commentControllerList[i].text =
            widget.data[i]["purpose"].toString();

        visitController.medImgList
            .add('https://dev.airmymd.com/${widget.data[i]["image"]}');
        print(widget.data[i]["image"]);
      }
      print(" ===>> ${visitController.medImgList}");
    } catch (e) {
      print('the exception is $e');
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = Get.put(PrimaryController());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Visit View',
            style: AppTextStyle.appBarHeading,
          ),
          actions: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Utility.showAlertDialogue(
                            'Are you sure you want to delete this visit?',
                            'Alert', () {
                          Get.back();

                          Utility.showLoader();
                          Get.put(AddVisitController()).deleteVisit();
                          Utility.closeLoader();
                        });
                      },
                      child: const Icon(Icons.delete))),
            )
          ],
        ),
        body: GetBuilder<AddVisitController>(builder: (controller) {
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
                      items:
                          name.doctors.map<DropdownMenuItem<String>>((value) {
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
                                  return singleImageViewer(index, context);
                                } catch (e) {
                                  print('exception $e');
                                  return Container();
                                }
                              }(),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  final statusSecond = await Permission
                                      .manageExternalStorage
                                      .request();
                                  final status =
                                      await Permission.storage.request();

                                  if (status.isGranted ||
                                      statusSecond.isGranted) {
                                    // Permission granted, you can proceed with file operations.
                                    // isPermissionStatus = true;
                                    // setState(() { /* Your setState logic here */ });
                                  } else {
                                    // Permission denied, show a message to the user.
                                    Utility.showMessage(
                                      'Please grant permission to access storage for file operations.',
                                      MessageType.information,
                                      () => Get
                                          .back(), // Assuming Get.back() is used for navigation.
                                      'OK',
                                    );
                                  }
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'png',
                                      'doc',
                                      'pdf'
                                    ],
                                  );
                                  for (int i = 0;
                                      i < controller.medImgList.length;
                                      i++) {
                                    if (controller.medImgList[i].contains(
                                        'https://dev.airmymd.com/null')) {
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
                                  print(
                                      'length ==> ${controller.medImgList[0]}');
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
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        onPressed: () {
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
                            text: 'Update',
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              controller.addVisit();
                            }))
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
