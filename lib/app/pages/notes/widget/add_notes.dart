import 'dart:io';

import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

var images;

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotesController>(builder: (controller) {
      controller.updates();
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Notes',
            style: AppTextStyle.appBarHeading,
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.addNotes();
                  },
                  child: const Icon(
                    Icons.check,
                    size: 30,
                  ),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            FocusScope.of(context).unfocus();
            showCupertinoModalPopup(
                context: context,
                builder: (_) =>
                    GetBuilder<NotesController>(builder: (controller) {
                      return CupertinoActionSheet(
                        title: const Text('Choose Option'),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                              onPressed: () async {
                                // multipleFinalImages.clear();

                                controller.update();
                                final ImagePicker picker = ImagePicker();

                                // ignore: deprecated_member_use
                                // final PickedFile? pickedFile =
                                //     await picker.getImage(
                                //   source: ImageSource.camera,
                                // );
                                var pickedFile = await picker.pickImage(
                                    source: ImageSource.camera);

                                if (pickedFile != null) {
                                  print('obbject of fff ${pickedFile.path}');

                                  multipleFinalImages.add(pickedFile.path);
                                  print(multipleFinalImages);
                                  controller.update();
                                  Get.back();
                                } else {
                                  Get.back();
                                }
                                controller.update();
                              },
                              child: const Text('Camera')),
                          CupertinoActionSheetAction(
                              onPressed: () async {
                                //  multipleFinalImages.clear();

                                controller.update();
                                final ImagePicker imagePicker = ImagePicker();

                                final List<XFile> selectedImages =
                                    await imagePicker.pickMultiImage();
                                if (selectedImages.isNotEmpty) {
                                  var multipleNote = selectedImages
                                      .map((e) => File(e.path))
                                      .toList();

                                  for (var val in multipleNote) {
                                    multipleFinalImages.add(val.path);
                                    print(multipleFinalImages);
                                  }
                                  Get.back();
                                }

                                controller.update();
                              },
                              child: const Text('Gallery')),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Cancel'),
                        ),
                      );
                    }));
          },
          child: const Icon(Icons.image),
        ),
        body: Padding(
          padding: AppPadding.mainScreenPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text('Date/Time:  ', style: TextStyles.darkBlack16),
                    Text(
                      DateFormat('d MMM hh:mm a').format(DateTime.now()),
                      style: const TextStyle(
                        color: AppColors.darkText,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: TextFormField(
                    style: AppTextStyle.textFieldInput,
                    controller: controller.usersController,
                    cursorColor: AppColors.greyText,
                    minLines: 1,
                    maxLines: 3,
                    inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        // errorText:
                        //     controller.userControllerErrorText.value == ''
                        //         ? null
                        //         : controller.userControllerErrorText.value,
                        contentPadding: EdgeInsets.zero,
                        icon: Text('Share: ', style: TextStyles.darkBlack16),
                        hintText: 'Separate email by a comma ',
                        hintStyle: TextStyle(
                            fontSize: 14, overflow: TextOverflow.ellipsis),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkText)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkText))),
                  ),
                ),
                TextFormField(
                  autofocus: false,
                  controller: controller.titleController,
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyles.greyPlain16,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
                TextFormField(
                  controller: controller.descriptionController,
                  minLines: 1,
                  maxLines: 10,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                      hintText: 'Start Typing',
                      hintStyle: TextStyles.greyPlain16,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
                controller.a.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.a.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(
                            'jdljdlkjdkdjkdj${controller.a.length}',
                          );
                          return controller.a[index].toString().endsWith('g') ||
                                  controller.a[index].toString().endsWith('p')
                              ? Stack(
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, right: 5),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: 400,
                                          width: Get.width,
                                          filterQuality: FilterQuality.high,
                                          progressIndicatorBuilder:
                                              (BuildContext, String,
                                                  DownloadProgress) {
                                            return const SizedBox(
                                                height: 40,
                                                child:
                                                    CupertinoActivityIndicator());
                                          },
                                          errorWidget:
                                              (BuildContext, String, dynamic) {
                                            return Container();
                                          },
                                          imageUrl:
                                              'https://dev.airmymd.com/uploads/notes/${controller.a[index]}',
                                        ),
                                      ),
                                    ),
                                    if (controller.a[index]
                                            .toString()
                                            .endsWith('g') ||
                                        controller.a[index]
                                            .toString()
                                            .endsWith('p'))
                                      //Container
                                      InkWell(
                                        onTap: () async {
                                          newLists.add(controller.a[index]);
                                          controller.a.removeAt(index);
                                          controller.update();
                                          print('controller.newLists$newLists');
                                        },
                                        child: Container(
                                            alignment: Alignment.topRight,
                                            width: 40,
                                            height: 40,
                                            child: Image.asset(
                                              'assets/images/close-round.png',
                                              color: AppColors.primaryColor,
                                            )),
                                      ), //Container
                                    //Container
                                  ], //<Widget>[]
                                )
                              : Container();
                        })
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                multipleFinalImages.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: multipleFinalImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, right: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    height: 400,
                                    width: Get.width,
                                    File(multipleFinalImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // //Container
                              InkWell(
                                onTap: () async {
                                  multipleFinalImages.removeAt(index);
                                  controller.update();
                                },
                                child: Container(
                                    alignment: Alignment.topRight,
                                    width: 40,
                                    height: 40,
                                    child: Image.asset(
                                      'assets/images/close-round.png',
                                      color: AppColors.primaryColor,
                                    )),
                              ), //Container
                              //Container
                            ], //<Widget>[]
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                      )
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class NeatCostFilterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    newText.write(newValue.text.replaceAll("com ", "com,"));

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(
          offset: newValue.text.replaceAll("com ", "com,").length),
    );
  }
}
