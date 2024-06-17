import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../../domain/repositories/localstorage_keys.dart';
import '../../../../../../domain/repositories/repository.dart';
import '../../../../../../main.dart';
import '../../../add_visit/add_visit_controller.dart';
import '../../primary_care/visit _view.dart';
import '../visit_controller.dart';
import 'package:http/http.dart' as http;

class VisidWidet extends StatefulWidget {
  const VisidWidet({super.key});

  @override
  State<VisidWidet> createState() => _VisidWidetState();
}

class _VisidWidetState extends State<VisidWidet> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisitController>(builder: (controller) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: controller.isLoading == false
              ? Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColors.textFieldHintText)),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.onUpcomingButtonSelected,
                              child: Container(
                                margin: const EdgeInsets.all(3.0),
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: controller.selectedButton ==
                                          'Upcoming Appointments'
                                      ? AppColors.primaryColor
                                      : AppColors.whiteColor,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Upcoming',
                                  style: controller.selectedButton ==
                                          'Upcoming Appointments'
                                      ? TextStyles.whiteBold15
                                      : TextStyles.greyPlain15,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.onPastButtonSelected,
                              child: Container(
                                margin: const EdgeInsets.all(3.0),
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: controller.selectedButton ==
                                          'Past Appointments'
                                      ? AppColors.primaryColor
                                      : AppColors.whiteColor,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Past ',
                                  style: controller.selectedButton ==
                                          'Past Appointments'
                                      ? TextStyles.whiteBold15
                                      : TextStyles.greyPlain15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller
                                .storeData[controller.selectedButton ==
                                        'Past Appointments'
                                    ? 'past'
                                    : 'upcoming']
                                .length >
                            0
                        ? SizedBox(
                            height: Get.height / 1.23,
                            width: Get.width,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(children: [
                                ...List.generate(
                                    controller
                                        .storeData[controller.selectedButton ==
                                                'Past Appointments'
                                            ? 'past'
                                            : 'upcoming']
                                        .length, (index) {
                                  var store = controller.storeData[
                                      controller.selectedButton ==
                                              'Past Appointments'
                                          ? 'past'
                                          : 'upcoming'];
                                  print(store[index]['doctor']['image']);
                                  DateTime time = DateFormat('HH:mm:ss')
                                      .parse(store[index]['time']);
                                  String formattedTime =
                                      DateFormat('h:mm a').format(time);
                                  return store[index]['doctor'] != null
                                      ? Column(
                                          children: [
                                            InkWell(
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
                                                    if (store[index]['image'] !=
                                                        null) {
                                                      var finalImageList =
                                                          store[index]['image']
                                                              .split(',')
                                                              .toList();
                                                      Get.put(AddVisitController())
                                                              .imageList =
                                                          finalImageList;
                                                    }

                                                    var converdImage = store[
                                                                index][
                                                            'user_visit_doctor_medicine']
                                                        .map((e) =>
                                                            'https://login.airmymd.com/${e['image']}');

                                                    List<String>
                                                        converdImagetoList =
                                                        converdImage
                                                            .toString()
                                                            .split(',')
                                                            .toList();
                                                    Get.put(AddVisitController())
                                                        .medImgList
                                                        .clear();
                                                    print(converdImagetoList);
                                                    for (int i = 0;
                                                        i <
                                                            converdImagetoList
                                                                .length;
                                                        i++) {
                                                      Get.put(AddVisitController())
                                                          .medImgList
                                                          .add(
                                                              converdImagetoList[
                                                                      i]
                                                                  .replaceAll(
                                                                      '(', '')
                                                                  .replaceAll(
                                                                      ')', '')
                                                                  .trim());
                                                      //  print(converdImagetoList[i]);
                                                      print(Get.put(
                                                              AddVisitController())
                                                          .medImgList);
                                                    }
                                                    //
                                                    Get.put(AddVisitController())
                                                            .storeVisitId =
                                                        store[index]['id'];

                                                    Get.put(AddVisitController())
                                                        .controller
                                                        .text = DateFormat(
                                                            'MM-dd-yyyy')
                                                        .format(DateTime.parse(
                                                            store[index]
                                                                ['date']));

                                                    Get.put(AddVisitController())
                                                        .timeController
                                                        .text = formattedTime;
                                                    Get.put(AddVisitController())
                                                            .notesController
                                                            .text =
                                                        store[index]['note'];

                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                UserVisitViewScreen(
                                                                  data: store[
                                                                          index]
                                                                      [
                                                                      'user_visit_doctor_medicine'],
                                                                )));
                                                  });
                                                } catch (e) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              UserVisitViewScreen(
                                                                data: store[
                                                                        index][
                                                                    'user_visit_doctor_medicine'],
                                                              )));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 0),
                                                child: Row(children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      image: store[index]['doctor']
                                                                      ['image']
                                                                  .toString()
                                                                  .isEmpty ||
                                                              store[index]['doctor']
                                                                          [
                                                                          'image']
                                                                      .toString() ==
                                                                  'null' ||
                                                              !store[index]
                                                                          ['doctor']
                                                                      ['image']
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
                                                              image: CachedNetworkImageProvider(
                                                                  'http://login.airmymd.com/${store[index]['doctor']['image']}'),
                                                              fit:
                                                                  BoxFit.cover),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  FittedBox(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Dr. ${store[index]['doctor']['first_name'].toString().capitalizeFirst} ${store[index]['doctor']['last_name'].toString().capitalizeFirst}',
                                                          style: TextStyles
                                                              .darkBlack18,
                                                        ),
                                                        Text(
                                                          '${formatDate(store[index]['date'])} at ${formatTime(store[index]['time'])}',
                                                          style: TextStyles
                                                              .darkMedium17,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                      onTap: () {
                                                        controller.createCalendarAndAddEvent(
                                                            context,
                                                            '${store[index]['date']} ${store[index]['time']}',
                                                            'Visit',
                                                            store[index]
                                                                ['note'],
                                                            store[index]
                                                                    ['doctor']
                                                                ['email'],
                                                            store[index]
                                                                    ['doctor']
                                                                ['website']);
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
                                                              width: double
                                                                  .infinity,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Form(
                                                                  key: controller
                                                                      .formKey,
                                                                  child: Column(
                                                                    children: [
                                                                      GlobalTextField()
                                                                          .withLabel(
                                                                              maxLines:
                                                                                  3,
                                                                              controller: controller
                                                                                  .email,
                                                                              inputFormat: [
                                                                                FilteringTextInputFormatter.deny(RegExp(r'\s+'))
                                                                              ],
                                                                              onChanged: (text) {
                                                                                controller.emailPhoneInput = text;
                                                                                controller.update();
                                                                              },
                                                                              validator: controller.validateEmailPhoneInput,
                                                                              label: 'Enter email or phone number with comma seprated',
                                                                              hintText: 'Enter email or phone number with comma seprated'),
                                                                      const SizedBox(
                                                                        height:
                                                                            40,
                                                                      ),
                                                                      GlobalButtons().primaryButton(
                                                                          text: 'Share',
                                                                          onTap: () async {
                                                                            if (controller.formKey.currentState!.validate()) {
                                                                              // Processing the comma-separated email and phone numbers
                                                                              controller.emailPhoneList = controller.emailPhoneInput.split(',');
                                                                              print(controller.emailPhoneList);
                                                                              controller.update();
                                                                              Get.back();
                                                                              Utility.showLoader();
                                                                              try {
                                                                                var request = await http.post(
                                                                                  Uri.parse('https://login.airmymd.com/api/invitations/${store[index]['id'].toString()}'),
                                                                                  body: {
                                                                                    'email_phone': controller.email.text,
                                                                                    'url': 'https://airmymdapp.page.link/visit?id=${store[index]['id']}'
                                                                                  },
                                                                                  headers: {
                                                                                    'Accept': 'application/json',
                                                                                    'Authorization': 'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
                                                                                  },
                                                                                );
                                                                                print(request.body);
                                                                                var response = jsonDecode(request.body);
                                                                                if (response['returnCode'] == 1) {
                                                                                  Utility.closeLoader();
                                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Visit info shared successfully')));
                                                                                  setState(() {});
                                                                                } else {
                                                                                  Utility.closeLoader();

                                                                                  // use_build_context_synchronously
                                                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
                                                                                }
                                                                              } catch (e) {
                                                                                Utility.closeLoader();
                                                                                Utility.showDialogue(e.toString());
                                                                                print(e);
                                                                              }
                                                                              await navigateWithDeepLink(false, 'https://airmymdapp.page.link/home/visit?id=${store[index]['id'].toString()}');
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
                                                      )),
                                                ]),
                                              ),
                                            ),
                                            const Divider()
                                          ],
                                        )
                                      : Container();
                                })
                              ]),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3),
                            child: Center(
                              child: Text(
                                controller.selectedButton == 'Past Appointments'
                                    ? 'No past visit'
                                    : 'No upcoming visit',
                                style: TextStyles.darkBlack15,
                              ),
                            ),
                          )
                  ],
                )
              : Padding(
                  padding: EdgeInsets.only(top: Get.height / 2),
                  child: const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.grey,
                      radius: 18,
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
