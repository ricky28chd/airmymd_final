import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/notes/widget/image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../domain/repositories/localstorage_keys.dart';

String sendId = '';

class MyObject {
  final int id;
  final String url;
  final String photo;
  final String email;
  MyObject(
      {required this.id,
      required this.url,
      required this.photo,
      required this.email});
}

class ViewInvitations extends StatefulWidget {
  const ViewInvitations({super.key});

  @override
  State<ViewInvitations> createState() => _ViewInvitationsState();
}

class _ViewInvitationsState extends State<ViewInvitations> {
  List<MyObject> storeData = [];
  bool loading = false;

  void getData() async {
    try {
      var request = await http.get(
        Uri.parse('https://login.airmymd.com/api/invitations'),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
        },
      );
      print('body is =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${request.body}');
      var response = jsonDecode(request.body);

      if (response['returnCode'] == 1) {
        List<dynamic> data = response["data"];

        storeData = data.map((obj) {
          return MyObject(
              id: obj['id'],
              url: obj['updated_at'],
              email:
                  '${obj['user']['patient_profile']['first_name'] ?? ''} ${obj['user']['patient_profile']['middle_name'] ?? ''}',
              photo: obj['user']['profile_photo_url']);
        }).toList();

        loading = true;
        setState(() {});
      } else {
        Utility.showDialogue(response["returnMessage"]);
        Utility.closeLoader();
        loading = true;
        setState(() {});
      }
    } catch (e) {
      Utility.closeLoader();
      Utility.showDialogue(e.toString());
      loading = true;
      setState(() {});
    }
  }

  List<MyObject> removeDuplicates(List<MyObject> list) {
    Map<String, MyObject> uniqueUrls = {};

    for (MyObject obj in list) {
      if (!uniqueUrls.containsKey(obj.url)) {
        uniqueUrls[obj.url] = obj;
      }
    }

    return uniqueUrls.values.toList();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  String formatUtcDateTime(DateTime utcDateTime) {
    // Convert to local time format
    String localTimeFormat = DateFormat.jm().format(utcDateTime.toLocal());

    // Convert to local date format
    String monthAbbrDayYearFormat =
        DateFormat("MMM d, y").format(utcDateTime.toLocal());
    String formattedDateTime = "$monthAbbrDayYearFormat at $localTimeFormat";

    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          'Invitations',
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: loading == true
          ? SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: storeData.length.toInt() > 0
                  ? Column(children: [
                      ...List.generate(storeData.length, (index) {
                        print('the image is ${storeData[index].photo}');
                        storeData.sort((a, b) => b.url.compareTo(a.url));
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                try {
                                  print(
                                      'https://login.airmymd.com/api/speciality-visit/${storeData[index].id}');
                                  Utility.showLoader();
                                  var request = await http.get(
                                      Uri.parse(
                                          'https://login.airmymd.com/api/speciality-visit/${storeData[index].id}'),
                                      headers: {
                                        'Authorization':
                                            'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
                                        'Accept': 'application/json',
                                      });
                                  print(request.body);
                                  var response = jsonDecode(request.body);
                                  print(response);
                                  if (response['returnCode'] == 1) {
                                    var imageList = response['data']
                                            ["user_visit_doctor"]["image"]
                                        .toString()
                                        .split(',');
                                    setState(() {
                                      print('the image list is $imageList');
                                    });

                                    Utility.closeLoader();
                                    Get.bottomSheet(FittedBox(
                                      fit: BoxFit.cover,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50),
                                                child: Container(
                                                  width: Get.width,
                                                  height: Get.height,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 40,
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height / 1.5,
                                                          child:
                                                              SingleChildScrollView(
                                                            physics:
                                                                const AlwaysScrollableScrollPhysics(),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'Dr. ${response['data']["user_visit_doctor"]['doctor']['first_name'].toString()} ${response['data']["user_visit_doctor"]['doctor']['last_name'].toString()}',
                                                                  style: TextStyles
                                                                      .darkBlack18,
                                                                ),
                                                                Text(
                                                                  response['data']["user_visit_doctor"]
                                                                              [
                                                                              'doctor']
                                                                          [
                                                                          'office_name']
                                                                      .toString()
                                                                      .toString(),
                                                                  style: TextStyles
                                                                      .darkMedium17,
                                                                ),
                                                                Text(
                                                                  '${response['data']["user_visit_doctor"]['doctor']['city'].toString().toString().toString()}, ${response['data']["user_visit_doctor"]['doctor']['state'].toString()}, ${response['data']["user_visit_doctor"]['doctor']['zip_code'].toString()}',
                                                                  style: TextStyles
                                                                      .darkMedium17,
                                                                ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    var urls =
                                                                        'mailto:${response['data']["user_visit_doctor"]['doctor']['email']}';
                                                                    if (await canLaunch(
                                                                        urls)) {
                                                                      await launch(
                                                                          urls);
                                                                    } else {
                                                                      Utility.showMessage(
                                                                          'Invalid address',
                                                                          MessageType
                                                                              .success,
                                                                          () =>
                                                                              null,
                                                                          'Okay');
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'assets/updated_icons/icon_email (1).png',
                                                                        scale:
                                                                            4.0,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          response['data']["user_visit_doctor"]['doctor']
                                                                              [
                                                                              'email'],
                                                                          style:
                                                                              TextStyles.extraBoldBlue13)
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    try {
                                                                      var url = response['data']["user_visit_doctor"]
                                                                              [
                                                                              'doctor']
                                                                          [
                                                                          'phone_number'];
                                                                      final Uri
                                                                          launchUri =
                                                                          Uri(
                                                                        scheme:
                                                                            'tel',
                                                                        path:
                                                                            url,
                                                                      );
                                                                      await launchUrl(
                                                                          launchUri);
                                                                    } catch (e) {
                                                                      Utility.showMessage(
                                                                          e
                                                                              .toString(),
                                                                          MessageType
                                                                              .success,
                                                                          () =>
                                                                              null,
                                                                          'Okay');
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'assets/updated_icons/icon_phone.png',
                                                                        scale:
                                                                            4.0,
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          response['data']["user_visit_doctor"]['doctor']
                                                                              [
                                                                              'phone_number'],
                                                                          style:
                                                                              TextStyles.extraBoldBlue13)
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                if (response['data']["user_visit_doctor"]
                                                                            [
                                                                            'doctor']
                                                                        [
                                                                        'website'] !=
                                                                    null)
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      if (response['data']["user_visit_doctor"]['doctor']
                                                                              [
                                                                              'website']
                                                                          .toString()
                                                                          .startsWith(
                                                                              'https')) {
                                                                        var url =
                                                                            Uri.parse(response['data']["user_visit_doctor"]['doctor']['website']);
                                                                        if (await canLaunch(
                                                                            url.toString())) {
                                                                          await launch(
                                                                              url.toString());
                                                                        } else {
                                                                          Utility.showMessage(
                                                                              'Could not launch $url',
                                                                              MessageType.success,
                                                                              () => null,
                                                                              'Okay');
                                                                        }
                                                                      } else {
                                                                        var url =
                                                                            Uri.parse('http://${response['data']["user_visit_doctor"]['doctor']['website']}');
                                                                        if (await canLaunch(
                                                                            url.toString())) {
                                                                          await launch(
                                                                              url.toString());
                                                                        } else {
                                                                          Utility.showMessage(
                                                                              'Could not launch $url',
                                                                              MessageType.success,
                                                                              () => null,
                                                                              'Okay');
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        response['data']["user_visit_doctor"]['doctor']
                                                                            [
                                                                            'website'],
                                                                        style: TextStyles
                                                                            .extraBoldBlue13),
                                                                  ),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        'Date/Time',
                                                                        style: TextStyles
                                                                            .darkBlack15,
                                                                      ),
                                                                      Text(
                                                                        '${DateFormat('MMM dd, yyyy').format(DateTime.parse(response['data']["user_visit_doctor"]['date'].toString()))} at ${DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(response['data']["user_visit_doctor"]['time'].toString()))}',
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        'Notes',
                                                                        style: TextStyles
                                                                            .darkBlack15,
                                                                      ),
                                                                      Text(response['data']["user_visit_doctor"]
                                                                              [
                                                                              "note"]
                                                                          .toString()),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      if (imageList
                                                                              .length
                                                                              .toInt() >
                                                                          0)
                                                                        const Text(
                                                                          'Images/files',
                                                                          style:
                                                                              TextStyles.extraBoldBlue13,
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                if (imageList
                                                                        .length
                                                                        .toInt() >
                                                                    0)
                                                                  ...List.generate(
                                                                      imageList
                                                                          .length,
                                                                      (index) {
                                                                    return imageList[index].toString() !=
                                                                            'null'
                                                                        ? Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10),
                                                                            child: MediaPageViewLocalAndNetwork(
                                                                              mediFiles: imageList,
                                                                              enable: false,
                                                                            ))
                                                                        : Container();
                                                                  }),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                if (response['data']["user_visit_doctor"]
                                                                            [
                                                                            'user_visit_doctor_medicine']
                                                                        .length >
                                                                    0)
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      'Medicines from doctor',
                                                                      style: TextStyles
                                                                          .darkBlack15,
                                                                    ),
                                                                  ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ...List.generate(
                                                                    response['data']["user_visit_doctor"]
                                                                            [
                                                                            'user_visit_doctor_medicine']
                                                                        .length,
                                                                    (index) {
                                                                  var storeData =
                                                                      response['data']["user_visit_doctor"]
                                                                              [
                                                                              'user_visit_doctor_medicine']
                                                                          [
                                                                          index];
                                                                  print(
                                                                      response);
                                                                  return Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child: GlobalTextField().withLabel(
                                                                            maxLines: 3,
                                                                            editable: false,
                                                                            label: 'Name',
                                                                            hintText: 'Name',
                                                                            controller: TextEditingController(
                                                                              text: storeData['name'],
                                                                            )),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child: GlobalTextField().withLabel(
                                                                            maxLines: 100,
                                                                            editable: false,
                                                                            label: 'Purpose',
                                                                            hintText: 'Purpose',
                                                                            controller: TextEditingController(
                                                                              text: storeData['purpose'],
                                                                            )),
                                                                      ),
                                                                      if (storeData['image']
                                                                              .toString() !=
                                                                          'null')
                                                                        const Text(
                                                                          'Images/file',
                                                                          style:
                                                                              TextStyles.extraBoldBlue13,
                                                                        ),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      storeData['image'].toString() !=
                                                                              'null'
                                                                          ? storeData['image'].toString().toLowerCase().endsWith('g')
                                                                              ? InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.of(context).push(MaterialPageRoute(
                                                                                        builder: (_) => ImageView(
                                                                                              url: 'https://login.airmymd.com/${storeData['image']}',
                                                                                            )));
                                                                                  },
                                                                                  child: CachedNetworkImage(
                                                                                    errorWidget: (context, url, error) {
                                                                                      return Container();
                                                                                    },
                                                                                    height: 150,
                                                                                    width: Get.width,
                                                                                    imageUrl: 'https://login.airmymd.com/${storeData['image']}',
                                                                                    placeholder: (context, url) => const CupertinoActivityIndicator(),
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                )
                                                                              : storeData['image'].toString().endsWith('doc') || storeData['image'].toString().endsWith('pdf')
                                                                                  ? InkWell(
                                                                                      onTap: () {
                                                                                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ImageViewerScreen(images: [storeData['image']], initialIndex: index)));
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 200,
                                                                                        alignment: Alignment.topRight,
                                                                                        decoration: BoxDecoration(color: Colors.transparent, image: DecorationImage(image: AssetImage(storeData['image'].endsWith('pdf') ? 'assets/images/doc-icon.png' : 'assets/images/pdf-icon.png'))),
                                                                                      ),
                                                                                    )
                                                                                  : Container()
                                                                          : Container(),
                                                                      const SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  );
                                                                }),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 90,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    image: response['data']["user_visit_doctor"]
                                                                        ['doctor']
                                                                    ['image']
                                                                .toString()
                                                                .isEmpty ||
                                                            response['data']["user_visit_doctor"]
                                                                            ['doctor'][
                                                                        'image']
                                                                    .toString() ==
                                                                'null'
                                                        ? const DecorationImage(
                                                            image: AssetImage(
                                                              'assets/updated_icons/icon_default.png',
                                                            ),
                                                            scale: 1.3,
                                                          )
                                                        : DecorationImage(
                                                            onError: (exception,
                                                                stackTrace) {
                                                              Image.asset(
                                                                  'assets/images/tab_profile.png',
                                                                  fit: BoxFit
                                                                      .cover);
                                                            },
                                                            image:
                                                                CachedNetworkImageProvider(
                                                              'https://login.airmymd.com/${response['data']["user_visit_doctor"]['doctor']['image'].toString()}',
                                                            ),
                                                            fit: BoxFit.cover),
                                                    shape: BoxShape.circle),
                                                child: const Padding(
                                                    padding: EdgeInsets.all(8)),
                                              ),
                                            ],
                                          )),
                                    ));
                                  }
                                } catch (e) {
                                  print(e.toString());
                                }
                                // showInt = true;
                                // sendId = storeData[index]['id'].toString();
                                // setState(() {});
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) =>
                                //             const InvitationView()));
                              },

                              ///
                              child: ListTile(
                                leading: Container(
                                  width: 30 * 2,
                                  height: 30 * 2,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                      image: storeData[index]
                                              .photo
                                              .toString()
                                              .endsWith('g')
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                storeData[index]
                                                    .photo
                                                    .toString(),
                                              ),
                                            )
                                          : const DecorationImage(
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                'assets/images/tab_profile.png',
                                              ),
                                            )),
                                ),
                                // CircleAvatar(
                                //   onBackgroundImageError:
                                //       (exception, stackTrace) {
                                //     const AssetImage(
                                //       'assets/images/tab_profile.png',
                                //     );
                                //   },
                                //   backgroundImage: CachedNetworkImageProvider(
                                //       storeData[index].photo.toString(),
                                //       errorListener: () {
                                //     const AssetImage(
                                //       'assets/images/tab_profile.png',
                                //     );
                                //   }),
                                // ),
                                title: Row(
                                  children: [
                                    const Text(
                                      'Shared by : ',
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      storeData[index]
                                          .email
                                          .capitalizeFirst
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                subtitle: Text(formatUtcDateTime(
                                    DateTime.parse(storeData[index].url)
                                        .toLocal())),
                                trailing: InkWell(
                                    onTap: () {
                                      Utility.showAlertDialogue(
                                          'Are you sure you want to delete this?',
                                          'Delete', () async {
                                        Get.back();
                                        Utility.showLoader();
                                        try {
                                          var request = await http.delete(
                                            Uri.parse(
                                                'https://login.airmymd.com/api/invitation/${storeData[index].id.toString()}'),
                                            headers: {
                                              'Authorization':
                                                  'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
                                            },
                                          );
                                          print(
                                              'body is =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${request.body}');
                                          var response =
                                              jsonDecode(request.body);
                                          if (response['returnCode'] == 1) {
                                            storeData.removeAt(index);
                                            Utility.closeLoader();
                                            setState(() {});
                                          } else {
                                            Utility.showDialogue(
                                                response["returnMessage"]);
                                            Utility.closeLoader();
                                          }
                                        } catch (e) {
                                          Utility.closeLoader();
                                          Utility.showDialogue(e.toString());
                                        }
                                      });
                                    },
                                    child: const Icon(Icons.delete)),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      }),
                    ])
                  : Padding(
                      padding: EdgeInsets.only(top: Get.height / 3),
                      child: const Center(
                          child: Text('No invitations received yet')),
                    ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
