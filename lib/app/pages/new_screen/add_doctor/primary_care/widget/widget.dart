import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/add_doctor_controller.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/primary_care/primary_care_controllerr.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/visit/visit_controller.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../../../../domain/repositories/localstorage_keys.dart';
import '../../../../../../main.dart';
import '../../../add_visit/add_visit_controller.dart';
import '../visit _view.dart';

bool showInt = false;

class PrimaryCareWidget extends StatefulWidget {
  const PrimaryCareWidget({super.key});

  @override
  State<PrimaryCareWidget> createState() => _PrimaryCareWidgetState();
}

class _PrimaryCareWidgetState extends State<PrimaryCareWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GetBuilder<PrimaryController>(builder: (controller) {
          return controller.isLoading == false
              ? Column(children: [
                  Row(
                    children: [
                      const Text(
                        'Doctors',
                        style: TextStyles.darkBlack20,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          NavigateTo.goToAddDoctor();
                        },
                        child: const Icon(
                          Icons.add_circle_outline,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          NavigateTo.goToAddDoctor();
                        },
                        child: const Text(
                          'Add',
                          style: TextStyles.extraBoldBlue15,
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: Get.height / 2,
                    child: controller.storeData['doctors'].length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.storeData['doctors'].length,
                            itemBuilder: (context, index) {
                              print(controller.storeData['doctors'][index]
                                  ['image']);
                              var data = controller.storeData['doctors'];
                              return InkWell(
                                onTap: () async {
                                  Utility.showLoader();

                                  await controller.getDataById(controller
                                      .storeData['doctors'][index]['id']
                                      .toString());
                                  Utility.closeLoader();
                                  _doctorView(context);
                                },
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: data[index]['image']
                                                          .toString()
                                                          .isEmpty ||
                                                      data[index]['image']
                                                              .toString() ==
                                                          'null' ||
                                                      !data[index]['image']
                                                          .toString()
                                                          .toLowerCase()
                                                          .endsWith('g')
                                                  ? const DecorationImage(
                                                      image: AssetImage(
                                                        'assets/updated_icons/icon_default.png',
                                                      ),
                                                      fit: BoxFit.cover)
                                                  : DecorationImage(
                                                      onError: (exception,
                                                          stackTrace) {
                                                        Image.asset(
                                                          'assets/updated_icons/icon_default.png',
                                                        );
                                                      },
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        'https://dev.airmymd.com/${data[index]['image'].toString()}',
                                                      ),
                                                      fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dr. ${data[index]['first_name'].toString()} ${data[index]['last_name'].toString()}',
                                              style: TextStyles.darkBlack18,
                                            ),
                                            Text(
                                              data[index]['office_name']
                                                  .toString()
                                                  .toString(),
                                              style: TextStyles.darkMedium17,
                                            ),
                                            Text(
                                              '${data[index]['city'].toString().toString().toString()}, ${data[index]['state'].toString()}, ${data[index]['zip_code'].toString().toString().toString()}',
                                              style: TextStyles.darkMedium17,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider()
                                  ],
                                ),
                              );
                            })
                        : Center(
                            child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3),
                            child: InkWell(
                              onTap: () {
                                NavigateTo.goToAddDoctor();
                              },
                              child: const Text(
                                'Add a Doctor to Get Started',
                                style: TextStyles.darkBlack15,
                              ),
                            ),
                          )),
                  ),
                  if (controller.storeData['doctors'].length > 0)
                    Row(
                      children: [
                        const Text(
                          'Last Visit',
                          style: TextStyles.darkBlack20,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            if (controller.storeData['visitors'].length > 0) {
                              NavigateTo.goToVisit();
                            } else {
                              Get.put(AddVisitController()).storeVisitId = 0;
                              Get.put(AddVisitController())
                                  .notesController
                                  .clear();
                              Get.put(AddVisitController()).imageList.clear();
                              Get.put(AddVisitController()).controller.clear();
                              Get.put(AddVisitController())
                                  .timeController
                                  .clear();
                              Get.put(AddVisitController())
                                  .nameControllerList
                                  .clear();
                              Get.put(AddVisitController())
                                  .commentControllerList
                                  .clear();
                              Get.put(AddVisitController()).medImgList.clear();
                              Get.put(AddVisitController())
                                  .foodAllergyList
                                  .clear();
                              Get.put(AddVisitController())
                                  .foodAllergyList
                                  .clear();
                              Get.put(AddVisitController()).foodAllergyList.add(
                                  Get.put(AddVisitController())
                                      .addFoodAllergies());
                              Get.put(AddVisitController()).medImgList.add("");
                              Get.put(AddVisitController()).update();
                              NavigateTo.goToAddVisit();
                            }
                          },
                          child: controller.storeData['visitors'].length > 0
                              ? const Text(
                                  'View All',
                                  style: TextStyles.extraBoldBlue15Underline,
                                )
                              : const Text(
                                  'Add Visit',
                                  style: TextStyles.extraBoldBlue15Underline,
                                ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(children: [
                    ...List.generate(controller.storeData['visitors'].length,
                        (index) {
                      print(
                          'image is ${controller.storeData['visitors'][index]['doctor']['image']}');
                      var store = controller.storeData['visitors'];
                      DateTime time = DateFormat('HH:mm:ss').parse(
                          controller.storeData['visitors'][index]['time']);
                      String formattedTime = DateFormat('h:mm a').format(time);
                      return controller.storeData['visitors'][index]
                                  ['doctor'] !=
                              null
                          ? InkWell(
                              onTap: () {
                                try {
                                  setState(() {
                                    Get.put(AddVisitController())
                                        .notesController
                                        .clear();
                                    Get.put(AddVisitController())
                                        .imageList
                                        .clear();
                                    Get.put(AddVisitController())
                                        .controller
                                        .clear();
                                    Get.put(AddVisitController())
                                        .timeController
                                        .clear();
                                    Get.put(AddVisitController())
                                        .nameControllerList
                                        .clear();
                                    Get.put(AddVisitController())
                                        .commentControllerList
                                        .clear();
                                    Get.put(AddVisitController())
                                        .medImgList
                                        .clear();
                                    Get.put(AddVisitController())
                                        .foodAllergyList
                                        .clear();
                                    if (store[index]['image'] != null) {
                                      var finalImageList = store[index]['image']
                                          .split(',')
                                          .toList();
                                      Get.put(AddVisitController()).imageList =
                                          finalImageList;
                                    }

//
                                    Get.put(AddVisitController()).storeVisitId =
                                        store[index]['id'];

                                    Get.put(AddVisitController())
                                            .controller
                                            .text =
                                        DateFormat('MM-dd-yyyy').format(
                                            DateTime.parse(
                                                store[index]['date']));

                                    Get.put(AddVisitController())
                                        .timeController
                                        .text = formattedTime;
                                    Get.put(AddVisitController())
                                        .notesController
                                        .text = store[index]['note'];
                                    Get.put(AddVisitController())
                                        .notesController
                                        .text = store[index]['note'];

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => UserVisitViewScreen(
                                                  data: store[index][
                                                      'user_visit_doctor_medicine'],
                                                )));
                                  });
                                } catch (e) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => UserVisitViewScreen(
                                            data: store[index]
                                                ['user_visit_doctor_medicine'],
                                          )));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: controller.storeData['visitors'][index]
                                                          ['doctor']['image']
                                                      .toString()
                                                      .isEmpty ||
                                                  controller.storeData['visitors']
                                                              [index]['doctor']
                                                              ['image']
                                                          .toString() ==
                                                      'null' ||
                                                  !controller.storeData['visitors'][index]
                                                          ['doctor']['image']
                                                      .toString()
                                                      .toLowerCase()
                                                      .endsWith('g')
                                              ? const DecorationImage(
                                                  image: AssetImage(
                                                    'assets/updated_icons/icon_default.png',
                                                  ),
                                                  scale: 1.3,
                                                )
                                              : DecorationImage(
                                                  image: CachedNetworkImageProvider('http://login.airmymd.com/${controller.storeData['visitors'][index]['doctor']['image']}'),
                                                  fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. ${controller.storeData['visitors'][index]['doctor']['first_name'].toString().toString()} ${controller.storeData['visitors'][index]['doctor']['last_name'].toString().toString()}',
                                          style: TextStyles.darkBlack18,
                                        ),
                                        Text(
                                          '${formatDate(controller.storeData['visitors'][index]['date'])} at ${formatTime(controller.storeData['visitors'][index]['time'])}',
                                          style: TextStyles.darkMedium17,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container();
                    })
                  ])
                  //    : const Center(child: Text('Data not found'))
                ])
              : Padding(
                  padding: EdgeInsets.only(top: Get.height / 2),
                  child: const Center(
                      child: CupertinoActivityIndicator(
                    radius: 18,
                    color: Colors.grey,
                  )),
                );
        }),
      ),
    );
  }

  Future<dynamic> _doctorView(BuildContext context) {
    return Get.bottomSheet(
        ignoreSafeArea: false,
        isScrollControlled: true,
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 150),
          child: GetBuilder<PrimaryController>(builder: (controller) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.put(AddDoctorControler()).doctorId =
                                        controller.storeDataById['doctor']['id']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .officeNameController
                                            .text =
                                        controller.storeDataById['doctor']
                                            ['office_name'];
                                    Get.put(AddDoctorControler())
                                            .fNameController
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['first_name']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .lastController
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['last_name']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .addressConroller
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['address']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .cityConroller
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['city']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .selectedOption =
                                        controller.storeDataById['doctor']
                                                ['state']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .zipConroller
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['zip_code']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .emailController
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['email']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .phoneController
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['phone_number']
                                            .toString();
                                    Get.put(AddDoctorControler())
                                            .websiteController
                                            .text =
                                        controller.storeDataById['doctor']
                                                ['website']
                                            .toString();
                                    if (controller.storeDataById['doctor']
                                            ['image']
                                        .toString()
                                        .toLowerCase()
                                        .toString()
                                        .endsWith('g')) {
                                      Get.put(AddDoctorControler()).imagePath =
                                          'https://dev.airmymd.com/${controller.storeDataById['doctor']['image']}'
                                              .toString();
                                    }

                                    NavigateTo.goToAddDoctor();
                                  },
                                  child: Image.asset(
                                    'assets/images/icon_edit_profile (1).png',
                                    scale: 4.0,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Utility.showAlertDialogue(
                                        'Are you sure you want to delete this doctor?',
                                        'Alert', () {
                                      Get.back();

                                      Utility.showLoader();
                                      controller.delteDataById(controller
                                          .storeDataById['doctor']['id']
                                          .toString());
                                      Utility.closeLoader();
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Image.asset(
                                        scale: 4.0,
                                        'assets/images/icon_delete (1).png'),
                                  ),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: SizedBox(
                                width: Get.width,
                                child: Column(
                                  children: [
                                    // Text(
                                    //   'Dr. ${controller.storeDataById['doctor']['first_name'].toString()} ${controller.storeDataById['doctor']['last_name'].toString()}',
                                    //   style: TextStyles.darkBlack18,
                                    // ),
                                    Text(
                                      controller.storeDataById['doctor']
                                              ['office_name']
                                          .toString()
                                          .toString(),
                                      style: TextStyles.darkMedium17,
                                    ),
                                    Text(
                                      '${controller.storeDataById['doctor']['city'].toString().toString().toString()}, ${controller.storeDataById['doctor']['state'].toString()}, ${controller.storeDataById['doctor']['zip_code'].toString().toString().toString()}',
                                      style: TextStyles.darkMedium17,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var urls =
                                            'mailto:${controller.storeDataById['doctor']['email']}';
                                        if (await canLaunch(urls)) {
                                          await launch(urls);
                                        } else {
                                          Utility.showMessage(
                                              'Invalid address',
                                              MessageType.success,
                                              () => null,
                                              'Okay');
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/updated_icons/icon_email (1).png',
                                            scale: 4.0,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              controller.storeDataById['doctor']
                                                  ['email'],
                                              style: TextStyles.extraBoldBlue13)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          var url =
                                              controller.storeDataById['doctor']
                                                  ['phone_number'];
                                          final Uri launchUri = Uri(
                                            scheme: 'tel',
                                            path: url,
                                          );
                                          await launchUrl(launchUri);
                                        } catch (e) {
                                          Utility.showMessage(
                                              e.toString(),
                                              MessageType.success,
                                              () => null,
                                              'Okay');
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/updated_icons/icon_phone.png',
                                            scale: 4.0,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              controller.storeDataById['doctor']
                                                  ['phone_number'],
                                              style: TextStyles.extraBoldBlue13)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (controller.storeDataById['doctor']
                                            ['website'] !=
                                        null)
                                      InkWell(
                                        onTap: () async {
                                          if (controller.storeDataById['doctor']
                                                  ['website']
                                              .toString()
                                              .startsWith('https')) {
                                            var url = Uri.parse(controller
                                                    .storeDataById['doctor']
                                                ['website']);
                                            if (await canLaunch(
                                                url.toString())) {
                                              await launch(url.toString());
                                            } else {
                                              Utility.showMessage(
                                                  'Could not launch $url',
                                                  MessageType.success,
                                                  () => null,
                                                  'Okay');
                                            }
                                          } else {
                                            var url = Uri.parse(
                                                'http://${controller.storeDataById['doctor']['website']}');
                                            if (await canLaunch(
                                                url.toString())) {
                                              await launch(url.toString());
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
                                            controller.storeDataById['doctor']
                                                ['website'],
                                            style: TextStyles.extraBoldBlue13),
                                      ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors
                                                    .textFieldHintText)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: controller
                                                    .onUpcomingButtonSelected,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(3.0),
                                                  padding:
                                                      const EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: controller
                                                                .selectedButton ==
                                                            'Upcoming Appointments'
                                                        ? AppColors.primaryColor
                                                        : AppColors.whiteColor,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Upcoming',
                                                    style: controller
                                                                .selectedButton ==
                                                            'Upcoming Appointments'
                                                        ? TextStyles.whiteBold15
                                                        : TextStyles
                                                            .greyPlain15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: controller
                                                    .onPastButtonSelected,
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(3.0),
                                                  padding:
                                                      const EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: controller
                                                                .selectedButton ==
                                                            'Past Appointments'
                                                        ? AppColors.primaryColor
                                                        : AppColors.whiteColor,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'Past ',
                                                    style: controller
                                                                .selectedButton ==
                                                            'Past Appointments'
                                                        ? TextStyles.whiteBold15
                                                        : TextStyles
                                                            .greyPlain15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (controller.storeDataById['visitors'] !=
                                        null)
                                      controller
                                                  .storeDataById['visitors'][
                                                      controller.selectedButton ==
                                                              'Past Appointments'
                                                          ? 'past'
                                                          : 'upcoming']
                                                  .length >
                                              0
                                          ? Column(
                                              children: List.generate(
                                                  controller
                                                      .storeDataById['visitors']
                                                          [
                                                          controller.selectedButton ==
                                                                  'Past Appointments'
                                                              ? 'past'
                                                              : 'upcoming']
                                                      .length, (index) {
                                              var store = controller
                                                      .storeDataById['visitors']
                                                  [controller.selectedButton ==
                                                          'Past Appointments'
                                                      ? 'past'
                                                      : 'upcoming'];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${DateFormat('MMM dd, yyyy').format(DateTime.parse(store[index]['date']))} at ${DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(store[index]['time']))}',
                                                        style: TextStyles
                                                            .darkMedium17,
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                      onTap: () {
                                                        Get.put(VisitController())
                                                            .createCalendarAndAddEvent(
                                                                context,
                                                                '${store[index]['date']} ${store[index]['time']}',
                                                                'Visit',
                                                                store[index]
                                                                    ['note'],
                                                                controller.storeDataById[
                                                                        'doctor']
                                                                    ['email'],
                                                                controller.storeDataById[
                                                                        'doctor']
                                                                    [
                                                                    'website']);
                                                      },
                                                      child: Image.asset(
                                                        'assets/updated_icons/icon_calendar.png',
                                                        scale: 4.0,
                                                      )),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.bottomSheet(
                                                          backgroundColor:
                                                              Colors.white,
                                                          SizedBox(
                                                            height: 200,
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Form(
                                                                key: controller
                                                                    .formKey,
                                                                child: Column(
                                                                  children: [
                                                                    GlobalTextField()
                                                                        .withLabel(
                                                                            maxLines:
                                                                                3,
                                                                            inputFormat: [
                                                                              FilteringTextInputFormatter.deny(RegExp(r'\s+'))
                                                                            ],
                                                                            controller: controller
                                                                                .email,
                                                                            onChanged:
                                                                                (text) {
                                                                              controller.emailPhoneInput = text;
                                                                              controller.update();
                                                                            },
                                                                            validator: controller
                                                                                .validateEmailPhoneInput,
                                                                            label:
                                                                                'Enter email or phone number with comma seprated',
                                                                            hintText:
                                                                                'Enter email or phone number with comma seprated'),
                                                                    const SizedBox(
                                                                      height:
                                                                          40,
                                                                    ),
                                                                    GlobalButtons()
                                                                        .primaryButton(
                                                                            text:
                                                                                'Share',
                                                                            onTap:
                                                                                () async {
                                                                              if (controller.formKey.currentState!.validate()) {
                                                                                // Processing the comma-separated email and phone numbers
                                                                                controller.emailPhoneList = controller.emailPhoneInput.split(',');
                                                                                print(controller.emailPhoneList);
                                                                                controller.update();
                                                                                Get.back();
                                                                                Utility.showLoader();
                                                                                try {
                                                                                  var request = await http.post(
                                                                                    Uri.parse('https://dev.airmymd.com/api/invitations/${store[index]['id'].toString()}'),
                                                                                    body: {
                                                                                      'email_phone': controller.email.text,
                                                                                      'url': 'https://airmymdapp.page.link/visit?id=${store[index]['id']}'
                                                                                    },
                                                                                    headers: {
                                                                                      'Accept': 'application/json',
                                                                                      'Authorization': 'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
                                                                                    },
                                                                                  );
                                                                                  print(store[index]['id']);
                                                                                  print('the body is ${request.body}');
                                                                                  var response = jsonDecode(request.body);
                                                                                  if (response['returnCode'] == 1) {
                                                                                    Utility.closeLoader();

                                                                                    Utility.closeLoader();
                                                                                    Get.back();
                                                                                    // ignore: use_build_context_synchronously
                                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Visit info shared successfully')));
                                                                                  } else {
                                                                                    Utility.closeLoader();

                                                                                    // use_build_context_synchronously
                                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
                                                                                  }
                                                                                } catch (e) {
                                                                                  Get.back();
                                                                                  Utility.closeLoader();
                                                                                  Utility.showDialogue(e.toString());

                                                                                  print(e);
                                                                                }
                                                                                await navigateWithDeepLink(false, 'https://airmymdapp.page.link/home/?id=${store[index]['id'].toString()}');
                                                                                controller.email.clear();
                                                                              }
                                                                            })
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ));
                                                    },
                                                    child: Image.asset(
                                                      'assets/updated_icons/icon_share (1).png',
                                                      scale: 4.0,
                                                    ),
                                                  ),
                                                ]),
                                              );
                                            }))
                                          : Text(
                                              controller.selectedButton ==
                                                      'Past Appointments'
                                                  ? 'No past visit'
                                                  : 'No upcoming visit',
                                              style: TextStyles.darkBlack15,
                                            )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      image: controller.storeDataById['doctor']['image']
                                  .toString()
                                  .isEmpty ||
                              controller.storeDataById['doctor']['image']
                                      .toString() ==
                                  'null' ||
                              !controller.storeDataById['doctor']['image']
                                  .toString()
                                  .toLowerCase()
                                  .toString()
                                  .endsWith('g')
                          ? const DecorationImage(
                              image: AssetImage(
                                'assets/updated_icons/icon_default.png',
                              ),
                              scale: 1.3,
                            )
                          : DecorationImage(
                              onError: (exception, stackTrace) {
                                Image.asset('assets/images/tab_profile.png',
                                    fit: BoxFit.cover);
                              },
                              image: CachedNetworkImageProvider(
                                'https://dev.airmymd.com/${controller.storeDataById['doctor']['image'].toString()}',
                              ),
                              fit: BoxFit.cover),
                      shape: BoxShape.circle),
                  child: const Padding(padding: EdgeInsets.all(8)),
                ),
              ],
            );
          }),
        ));
  }
}
