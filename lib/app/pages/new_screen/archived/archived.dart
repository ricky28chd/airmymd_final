import 'package:airmymd/app/pages/pages.dart';
import 'package:airmymd/app/theme/theme_export.dart';
import 'package:airmymd/app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/repositories/repository.dart';
import '../../../navigators/navigators.dart';
import '../healtdashboard/conroller.dart';
import '../healtdashboard/widget/health_dashboad.dart';

class ArchivedScreen extends StatefulWidget {
  const ArchivedScreen({super.key});

  @override
  State<ArchivedScreen> createState() => _ArchivedScreenState();
}

class _ArchivedScreenState extends State<ArchivedScreen> {
  var controller = Get.put(HealthDashboardController());
  @override
  void initState() {
    controller.getDataArcive();
    print('caling');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Archived',
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: controller.loading == false
          ? GetBuilder<HealthDashboardController>(builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: controller.data.length > 0
                      ? Column(children: [
                          Column(
                            children: [
                              controller.loading == false
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 0.8,
                                        ),
                                        itemCount: controller.data.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return controller.data[index]
                                                      ['is_archive'] ==
                                                  '1'
                                              ? GestureDetector(
                                                  onTap: () async {
                                                    Get.find<Repository>()
                                                        .saveValue(
                                                            'specialistTitle',
                                                            controller
                                                                .data[index]
                                                                    ['title']
                                                                .toString());
                                                    Get.find<Repository>()
                                                        .saveValue(
                                                            'specialistId',
                                                            controller
                                                                .data[index]
                                                                    ['id']
                                                                .toString());

                                                    NavigateTo
                                                        .goToPrimaryCare();
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: index.isEven
                                                            ? 20
                                                            : 0,
                                                        bottom: index.isOdd
                                                            ? 20
                                                            : 0),
                                                    child: Card(
                                                      elevation: 5,
                                                      shadowColor: AppColors
                                                          .containerBackground,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        height:
                                                            Get.height * 0.22,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                  color: AppColors
                                                                      .containerBackground,
                                                                  spreadRadius:
                                                                      3,
                                                                  blurRadius:
                                                                      3),
                                                            ]),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child:
                                                                  PopupMenuButton(
                                                                icon: Image.asset(
                                                                    'assets/images/icon_more.png',
                                                                    height: 35,
                                                                    fit: BoxFit
                                                                        .cover),
                                                                constraints:
                                                                    BoxConstraints.tight(
                                                                        const Size(
                                                                            85.0,
                                                                            75)),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                color: Colors
                                                                    .white,
                                                                itemBuilder:
                                                                    (context) {
                                                                  return [
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () async {
                                                                        Get.back();
                                                                        Utility
                                                                            .showLoader();
                                                                        await addArchive(
                                                                          controller.data[index]
                                                                              [
                                                                              'id'],
                                                                          "0",
                                                                        );

                                                                        Utility
                                                                            .closeLoader();
                                                                        print(
                                                                            'entered');
                                                                      },
                                                                      height:
                                                                          30,
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              5),
                                                                      value:
                                                                          'archive',
                                                                      child: const Text(
                                                                          'Unarchive'),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      onTap:
                                                                          () {
                                                                        // Debugging: Check if this function is called
                                                                        print(
                                                                            "Delete option tapped");

                                                                        // Assuming Get.back() is used to close the popup menu
                                                                        Get.back();
                                                                        Get.dialog(
                                                                            CupertinoAlertDialog(
                                                                          title:
                                                                              const Text(
                                                                            'Are you sure?',
                                                                          ),
                                                                          content:
                                                                              const Text(
                                                                            'You will not be able to recover this Speciality!',
                                                                          ),
                                                                          actions: <Widget>[
                                                                            CupertinoDialogAction(
                                                                                isDefaultAction: true,
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                  deleteHealthDashboard(controller.data[index]['id']);
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
                                                                        Utility
                                                                            .showAlertDialogue(
                                                                          'You will not be able to recover this',
                                                                          'Are you sure?',
                                                                          () {
                                                                            // Debugging: Check if this function is called
                                                                            print("Confirm delete action");

                                                                            deleteHealthDashboard(controller.data[index]['id']);
                                                                          },
                                                                        );
                                                                      },
                                                                      height:
                                                                          30,
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              5),
                                                                      value:
                                                                          'delete',
                                                                      child: const Text(
                                                                          'Delete'),
                                                                    ),
                                                                  ];
                                                                },
                                                              ),
                                                            ),
                                                            AppSizeBox.height_1,
                                                            CachedNetworkImage(
                                                              placeholder:
                                                                  (context,
                                                                      url) {
                                                                return const CupertinoActivityIndicator(
                                                                    color: Colors
                                                                        .grey);
                                                              },
                                                              imageUrl:
                                                                  'http://login.airmymd.com/${controller.data[index]['logo'].toString()}',
                                                              height: 45,
                                                              width: 45,
                                                            ),
                                                            AppSizeBox.height_1,
                                                            Text(
                                                              controller
                                                                  .data[index]
                                                                      ['title']
                                                                  .toString(),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyles
                                                                  .mediumDark15,
                                                            ),
                                                            AppSizeBox.height_1,
                                                            Text(
                                                              '${controller.data[index]['doctors_count'].toString()} Specialists',
                                                              style: TextStyles
                                                                  .greyPlain13,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container();
                                        },
                                        // separatorBuilder:
                                        //     (BuildContext context,
                                        //         int index) {
                                        //   return AppSizeBox.height_2;
                                        // },
                                      ),
                                    )
                                  : const Center(
                                      child: CupertinoActivityIndicator()),
                              AppSizeBox.width_7,
                            ],
                          )
                        ])
                      : Padding(
                          padding: EdgeInsets.only(top: Get.height / 2.5),
                          child: const Center(
                            child: Text(
                              'Look like you have\'t any archived specialist.',
                            ),
                          ),
                        ),
                ),
              );
            })
          : const Center(child: CupertinoActivityIndicator()),
    );
  }
}
