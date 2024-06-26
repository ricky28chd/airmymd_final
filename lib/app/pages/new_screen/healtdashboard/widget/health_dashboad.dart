import 'dart:convert';
import 'dart:io';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/data/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../domain/repositories/localstorage_keys.dart';
import '../../../../../domain/repositories/repository.dart';
import '../conroller.dart';
import 'package:http/http.dart' as http;

class HealthDashboardWidget extends StatelessWidget {
  const HealthDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HealthDashboardController>(builder: (controller) {
      return CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: Padding(
            padding: AppPadding.mainScreenPadding,
            child: RefreshIndicator(
              onRefresh: () async {
                controller.getData();
              },
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSizeBox.height_3,
                          const Text(
                            'Doctor Specialty',
                            style: TextStyles.mediumDark25,
                            textScaleFactor: 1.1,
                          ),
                          AppSizeBox.height_3,
                          Row(
                            children: [
                              Expanded(
                                child: GlobalButtons().primaryButton(
                                  text: 'Doctor Speciality',
                                  onTap: () {
                                    NavigateTo.goToFindDoctorScreen();
                                  },
                                ),
                              ),
                              AppSizeBox.width_3,
                              Expanded(
                                child: GlobalButtons().primaryButton(
                                  text: 'Patient Protal',
                                  onTap: () {
                                    NavigateTo.goToallProfilePage();
                                  },
                                ),
                              )
                            ],
                          ),
                          AppSizeBox.height_3,
                          Row(
                            children: [
                              // const Text(
                              //   PageConstants.kSpeciality,
                              //   style: TextStyles.darkHeavy18,
                              // ),
                              // const Spacer(),
                              InkWell(
                                onTap: () {
                                  print('dadsadasdasdadadaddadasdadasdasdadas');
                                  Get.bottomSheet(
                                      isDismissible: false,
                                      enableDrag: false,
                                      backgroundColor: Colors.white,
                                      GetBuilder<HealthDashboardController>(
                                          builder: (controller) {
                                    return SizedBox(
                                      width: Get.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 20),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: const Text(
                                                  'Add Speciality',
                                                  style: TextStyles.darkBlack18,
                                                ),
                                                trailing: InkWell(
                                                  onTap: () {
                                                    controller.title.clear();
                                                    controller.imagePath = '';
                                                    controller.update();
                                                    Get.back();
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              GlobalTextField().withLabel(
                                                  context: context,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  controller: controller.title,
                                                  label: 'Title',
                                                  hintText: 'Title'),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller.pickImage();
                                                },
                                                child: const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Select Icon',
                                                    style: TextStyles
                                                        .extraBoldBlue15Underline,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              if (controller
                                                  .imagePath.isNotEmpty)
                                                Image.file(
                                                  File(controller.imagePath),
                                                  height: 90,
                                                  width: 90,
                                                  fit: BoxFit.cover,
                                                ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              GlobalButtons().primaryButton(
                                                  text: 'Add',
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    controller.addSpecialist();
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
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
                                      'Add Speciality',
                                      style: TextStyles.extraBoldBlue15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      AppSizeBox.height_2,
                      SizedBox(
                        height: Get.height / 1.65,
                        width: Get.width,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: controller.storeData == null
                              ? Container(
                                  height: Get.height / 2,
                                  child: const Center(
                                      child: Text('No data found')))
                              : Column(
                                  children: [
                                    controller.isLoadings == false
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 40),
                                                  child: GridView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    primary: false,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 20,
                                                      mainAxisSpacing: 10,
                                                      childAspectRatio: 0.7,
                                                    ),
                                                    itemCount: controller
                                                        .storeData.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            index) {
                                                      return controller.storeData[
                                                                      index][
                                                                  'is_archive'] ==
                                                              '0'
                                                          ? Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: index
                                                                          .isEven
                                                                      ? 20
                                                                      : 0,
                                                                  bottom: index
                                                                          .isOdd
                                                                      ? 20
                                                                      : 0),
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  Get.find<Repository>().saveValue(
                                                                      'specialistTitle',
                                                                      controller
                                                                          .storeData[
                                                                              index]
                                                                              [
                                                                              'title']
                                                                          .toString());
                                                                  Get.find<Repository>().saveValue(
                                                                      'specialistId',
                                                                      controller
                                                                          .storeData[
                                                                              index]
                                                                              [
                                                                              'id']
                                                                          .toString());

                                                                  NavigateTo
                                                                      .goToPrimaryCare();
                                                                },
                                                                child: Card(
                                                                  elevation: 5,
                                                                  shadowColor:
                                                                      AppColors
                                                                          .containerBackground,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20),
                                                                    height:
                                                                        Get.height *
                                                                            0.22,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                              color: AppColors.containerBackground,
                                                                              spreadRadius: 3,
                                                                              blurRadius: 3),
                                                                        ],
                                                                        color: Colors.white
                                                                        // AppColors
                                                                        //     .containerBackground,
                                                                        ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.topRight,
                                                                          child:
                                                                              PopupMenuButton(
                                                                            icon:
                                                                                MediaQuery.removePadding(
                                                                              removeTop: true,
                                                                              context: context,
                                                                              child: Image.asset('assets/images/icon_more.png', height: 35, fit: BoxFit.cover),
                                                                            ),
                                                                            constraints:
                                                                                BoxConstraints.tight(const Size(65.0, 75)),
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            color:
                                                                                Colors.white,
                                                                            itemBuilder:
                                                                                (context) {
                                                                              return [
                                                                                PopupMenuItem(
                                                                                  onTap: () async {
                                                                                    Utility.showLoader();
                                                                                    await addArchive(
                                                                                      controller.storeData[index]['id'],
                                                                                      controller.storeData[index]['is_archive'] == '1' ? '0' : '1',
                                                                                    );

                                                                                    Utility.closeLoader();
                                                                                    print('entered');
                                                                                  },
                                                                                  height: 30,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  value: 'archive',
                                                                                  child: const Text('Archive'),
                                                                                ),
                                                                                PopupMenuItem(
                                                                                  onTap: () {
                                                                                    // Debugging: Check if this function is called
                                                                                    print("Delete option tapped");

                                                                                    // Assuming Get.back() is used to close the popup menu
                                                                                    // Get.back();
                                                                                    Get.dialog(CupertinoAlertDialog(
                                                                                      title: const Text(
                                                                                        'Are you sure?',
                                                                                      ),
                                                                                      content: const Text(
                                                                                        'You will not be able to recover this Speciality!',
                                                                                      ),
                                                                                      actions: <Widget>[
                                                                                        CupertinoDialogAction(
                                                                                            isDefaultAction: true,
                                                                                            onPressed: () {
                                                                                              Get.back();
                                                                                              deleteHealthDashboard(controller.storeData[index]['id']);
                                                                                            },
                                                                                            child: const Text('Yes,delete it!')),
                                                                                        CupertinoDialogAction(
                                                                                          isDestructiveAction: true,
                                                                                          onPressed: () {
                                                                                            Get.back();
                                                                                          },
                                                                                          child: const Text('No'),
                                                                                        )
                                                                                      ],
                                                                                    ));
                                                                                    // Assuming Utility.showAlertDialogue is correctly implemented
                                                                                    //                                                                             Utility.showAlertDialogue(
                                                                                    //                                                                               'You will not be able to recover this',
                                                                                    //                                                                               'Are you sure?',
                                                                                    //                                                                               () {
                                                                                    //                                                                                 // Debugging: Check if this function is called
                                                                                    //                                                                                 print("Confirm delete action");
                                                                                    // Get.back();
                                                                                    //                                                                                 // Assuming deleteHealthDashboard is correctly implemented
                                                                                    //                                                                                 deleteHealthDashboard(controller.storeData[index]['id']);
                                                                                    //                                                                                 Get.back();
                                                                                    //                                                                               },
                                                                                    //                                                                             );
                                                                                  },
                                                                                  height: 30,
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  value: 'delete',
                                                                                  child: const Text('Delete'),
                                                                                ),
                                                                              ];
                                                                            },
                                                                          ),
                                                                        ),
                                                                        AppSizeBox
                                                                            .height_1,
                                                                        CachedNetworkImage(
                                                                          imageUrl:
                                                                              'http://login.airmymd.com/${controller.storeData[index]['logo'].toString()}',
                                                                          height:
                                                                              45,
                                                                          width:
                                                                              45,
                                                                        ),
                                                                        AppSizeBox
                                                                            .height_1,
                                                                        Text(
                                                                          controller
                                                                              .storeData[index]['title']
                                                                              .toString(),
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              TextStyles.mediumDark15,
                                                                        ),
                                                                        AppSizeBox
                                                                            .height_1,
                                                                        Text(
                                                                          '${controller.storeData[index]['doctors_count'].toString()} Specialists',
                                                                          style:
                                                                              TextStyles.greyPlain13,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              AppSizeBox.width_7,
                                            ],
                                          )
                                        : Container()
                                  ],
                                ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        )
      ]);
    });
  }
}

addArchive(id, status) async {
  Utility.showLoader();
  try {
    var request = await http.post(
        Uri.parse('${ApiWrapper().baseUrl}speciality-archive/$id'),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
        },
        body: {
          'is_archive': status.toString()
        });
    var response = jsonDecode(request.body);
    print(response);
    Utility.closeLoader();
    if (response['returnCode'].toString() == '1') {
      Get.find<HealthDashboardController>().getData();
      Get.find<HealthDashboardController>().getDataArcive();
      Get.find<HealthDashboardController>().update();
    } else {
      Get.snackbar('Error', response['returnMessage']);
    }
    Get.find<HealthDashboardController>().update();
  } catch (e) {
    Utility.printELog(e.toString());
  }
}

deleteHealthDashboard(id) async {
  Utility.showLoader();
  try {
    var request = await http.delete(
      Uri.parse('${ApiWrapper().baseUrl}speciality-delete/$id'),
      headers: {
        'Authorization':
            'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
      },
    );
    var response = jsonDecode(request.body);
    print(response);
    Utility.closeLoader();
    if (response['returnCode'].toString() == '1') {
      Get.find<HealthDashboardController>().getData();
      Get.find<HealthDashboardController>().getDataArcive();
      Get.find<HealthDashboardController>().update();
    } else {
      Get.snackbar('Error', response['returnMessage']);
    }
  } catch (e) {
    Utility.printELog(e.toString());
  }
}
