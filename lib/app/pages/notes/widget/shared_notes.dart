import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import '../../../../domain/repositories/localstorage_keys.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../main.dart';
import 'image_view.dart';
import 'package:http/http.dart' as http;

List<String> names = [];

class SharedNotesWidget extends StatelessWidget {
  const SharedNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (controller) {
      return controller.sharedNotes.isEmpty
          ? SizedBox(
              height: Get.height / 1.5,
              width: Get.width,
              child: Center(
                  child: Text(
                controller.sharedNotesErrorText,
                style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              )),
            )
          : Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.getNotes(isLoading: false);
                },
                child: SizedBox.expand(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: controller.sharedNotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(controller.sharedNotes[index].title.toString());
                        // controller.sharedNotes
                        //     .sort((a, b) => b.id!.compareTo(a.id!.toInt()));

                        // var finalImages =
                        //     controller.sharedNotes[index].files!.isNotEmpty
                        //         ? controller.sharedNotes[index].files!.split(',')
                        //
                        var finalImages = [];
                        if (controller.sharedNotes[index].files != "") {
                          finalImages =
                              controller.sharedNotes[index].files!.split(',');
                        }

                        // int randomColor = Random().nextInt(colorsList.length - 1);
                        Color textColor = Colors.black;
                        return GestureDetector(
                          onTap: () async {
                            controller.clearChache();
                            Get.dialog(
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // controller.sharedNotes[index].users
                                          //             .toString() ==
                                          //         ""
                                          //     ? Colors.yellow
                                          //     : Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () async {
                                                        newLists.clear();
                                                        controller.a.clear();
                                                        multipleFinalImages
                                                            .clear();
                                                        await box.put(
                                                            'notesId',
                                                            controller
                                                                .sharedNotes[
                                                                    index]
                                                                .id);
                                                        await box.put(
                                                            'notesTitle',
                                                            controller
                                                                .sharedNotes[
                                                                    index]
                                                                .title);
                                                        await box.put(
                                                            'notesUsers',
                                                            controller
                                                                .sharedNotes[
                                                                    index]
                                                                .users);
                                                        await box.put(
                                                            'notesDescription',
                                                            controller
                                                                .sharedNotes[
                                                                    index]
                                                                .description);

                                                        controller.a =
                                                            controller
                                                                .sharedNotes[
                                                                    index]
                                                                .files!
                                                                .split(',');

                                                        controller.update();
                                                        Get.back();
                                                        await Get.to(
                                                            const AddNoteScreen());
                                                      },
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          height: 50,
                                                          width: 90,
                                                          child: const Icon(
                                                              Icons.edit))),
                                                  GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          height: 50,
                                                          width: 90,
                                                          child: const Icon(
                                                              Icons.cancel)))
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                  controller.sharedNotes[index]
                                                      .dateTime
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              AppSizeBox.height_2,
                                              Text(
                                                  StringUtils.capitalize(
                                                      controller
                                                          .sharedNotes[index]
                                                          .title
                                                          .toString()),
                                                  style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              AppSizeBox.height_2,
                                              Text(
                                                  StringUtils.capitalize(
                                                      controller
                                                          .sharedNotes[index]
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
                                              controller.sharedNotes[index]
                                                      .files!.isNotEmpty
                                                  ? GridView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          finalImages.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int imageIndex) {
                                                        return finalImages[
                                                                    imageIndex]
                                                                .isNotEmpty
                                                            ? InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(MaterialPageRoute(
                                                                          builder: (_) =>
                                                                              ImageView(url: 'https://dev.airmymd.com/uploads/notes/${finalImages[imageIndex]}')));
                                                                },
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: CachedNetworkImage(
                                                                      fit: BoxFit.cover,
                                                                      height: 400,
                                                                      width: Get.width,
                                                                      filterQuality: FilterQuality.high,
                                                                      progressIndicatorBuilder: (BuildContext, String, DownloadProgress) {
                                                                        return const SizedBox(
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                CupertinoActivityIndicator());
                                                                      },
                                                                      imageUrl: 'https://dev.airmymd.com/uploads/notes/${finalImages[imageIndex]}'),
                                                                ),
                                                              )
                                                            : Container();
                                                      },
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio:
                                                                  1.5 / 2,
                                                              crossAxisSpacing:
                                                                  20,
                                                              mainAxisSpacing:
                                                                  20),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
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

                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20)),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, bottom: 15, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            controller
                                                .sharedNotes[index].dateTime
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            Utility.showAlertDialogue(
                                                'Are you sure you want to delete this note?',
                                                'Delete Note', () {
                                              var response = http.post(
                                                  Uri.parse(
                                                      'https://dev.airmymd.com/api/delete-notes'),
                                                  headers: {
                                                    'Authorization':
                                                        'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}'
                                                  },
                                                  body: {
                                                    'id': controller
                                                        .sharedNotes[index].id
                                                        .toString(),
                                                    // 'email': ''
                                                  });
                                              controller.sharedNotes
                                                  .removeAt(index);
                                              controller.update();
                                              Get.back();
                                            });
                                          },
                                          child: const Icon(Icons.delete))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            StringUtils.capitalize(controller
                                                .sharedNotes[index].title
                                                .toString()),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      controller.sharedNotes[index].files != ""
                                          ? const Icon(
                                              Icons.attach_file,
                                              color: Colors.black,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  AppSizeBox.height_2,
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
