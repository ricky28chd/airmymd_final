import 'dart:math';
import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/notes/widget/image_view.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/repositories/localstorage_keys.dart';
import '../../../../domain/repositories/repository.dart';
import 'package:http/http.dart' as http;

class MyNotesWidget extends StatelessWidget {
  const MyNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (controller) {
      print(DateTime.now());
      return controller.myNotes.isEmpty
          ? SizedBox(
              height: Get.height / 1.5,
              width: Get.width,
              child: const Center(
                  child: Text('You haven\'t received any notes yet.',
                      style: TextStyle(
                          color: AppColors.darkText,
                          fontSize: 13,
                          fontWeight: FontWeight.bold))),
            )
          : Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.getNotes(isLoading: false);
                },
                child: SizedBox.expand(
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      // reverse: true,
                      itemCount: controller.myNotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        // var finalImages =
                        //     controller.myNotes[index].files!.isNotEmpty
                        //         ? controller.myNotes[index].files!.split(',')
                        //
                        var finalImages = [];
                        if (controller.myNotes[index].files != "") {
                          if (controller.myNotes[index].files != null) {
                            finalImages =
                                controller.myNotes[index].files!.split(',');
                          }
                        }

                        int randomColor =
                            Random().nextInt(colorsList.length - 1);
                        Color textColor = Colors.black;
                        // Color(colorsList[randomColor]).computeLuminance() > 0.7
                        //     ? AppColors.darkText
                        //     : Colors.white;
                        return GestureDetector(
                          onTap: () {
                            Get.dialog(
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                      height: 40,
                                                      width: 50,
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: const Icon(
                                                          Icons.cancel))),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      controller.myNotes[index]
                                                          .dateTime
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                  AppSizeBox.height_2,
                                                  Text(
                                                      StringUtils.capitalize(
                                                          controller
                                                              .myNotes[index]
                                                              .title
                                                              .toString()),
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  AppSizeBox.height_2,
                                                  Text(
                                                      StringUtils.capitalize(
                                                          controller
                                                              .myNotes[index]
                                                              .description
                                                              .toString()),
                                                      style: TextStyle(
                                                        color: textColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  if (controller.myNotes[index]
                                                          .files !=
                                                      null)
                                                    controller.myNotes[index]
                                                                .files!
                                                                .toString()
                                                                .isNotEmpty ||
                                                            controller
                                                                    .myNotes[
                                                                        index]
                                                                    .files !=
                                                                null
                                                        ? GridView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                childAspectRatio:
                                                                    1.5 / 2,
                                                                crossAxisSpacing:
                                                                    20,
                                                                mainAxisSpacing:
                                                                    20),
                                                            itemCount:
                                                                finalImages
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int imageIndex) {
                                                              return finalImages
                                                                          .length >
                                                                      index
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (_) =>
                                                                                ImageView(url: 'https://dev.airmymd.com/uploads/notes/${finalImages[imageIndex]}')));
                                                                      },
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              400,
                                                                          width:
                                                                              Get.width,
                                                                          filterQuality:
                                                                              FilterQuality.high,
                                                                          progressIndicatorBuilder: (BuildContext,
                                                                              String,
                                                                              DownloadProgress) {
                                                                            return const SizedBox(
                                                                                height: 40,
                                                                                child: CupertinoActivityIndicator());
                                                                          },
                                                                          imageUrl:
                                                                              'https://dev.airmymd.com/uploads/notes/${finalImages[imageIndex]}',
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container();
                                                            })
                                                        : Container()
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            controller.myNotes[index].dateTime
                                                .toString(),
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            Utility.showAlertDialogue(
                                                'Are you sure you want to remove yourself from this note?',
                                                'Remove Access', () {
                                              http.post(
                                                  Uri.parse(
                                                      'https://dev.airmymd.com/api/delete-notes'),
                                                  headers: {
                                                    'Authorization':
                                                        'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}'
                                                  },
                                                  body: {
                                                    'id': controller
                                                        .myNotes[index].id
                                                        .toString(),
                                                    'email':
                                                        Get.find<Repository>()
                                                            .getStringValue(
                                                                LocalKeys
                                                                    .userEmail)
                                                  });
                                              controller.myNotes
                                                  .removeAt(index);

                                              controller.update();
                                              Get.back();
                                            });
                                          },
                                          child:
                                              const Icon(Icons.remove_circle)),
                                    ],
                                  ),
                                  AppSizeBox.height_2,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          StringUtils.capitalize(
                                            controller.myNotes[index].title
                                                .toString(),
                                          ),
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (controller.myNotes[index].files !=
                                          null)
                                        controller.myNotes[index].files != ""
                                            ? Icon(
                                                Icons.attach_file,
                                                color: textColor,
                                              )
                                            : Container()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            );
    });
  }
}
