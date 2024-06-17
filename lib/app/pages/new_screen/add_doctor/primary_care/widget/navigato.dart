import 'dart:convert';

import '../../../../../../domain/entities/enums.dart';
import '../../../../../../domain/repositories/localstorage_keys.dart';
import '../../../../../../domain/repositories/repository.dart';
import '../../../../../../main.dart';
import '../../../../../app.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/primary_care/widget/widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../../profile_setting_screen/widget/inviattions.dart';
import '../../visit/visit_controller.dart';
import '../primary_care_controllerr.dart';

class InvitationView extends StatefulWidget {
  const InvitationView({super.key});

  @override
  State<InvitationView> createState() => _InvitationViewState();
}

class _InvitationViewState extends State<InvitationView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var cot = Get.put(PrimaryController());
      await Future.delayed(const Duration(seconds: 1));
      if (showInt == true) {
        Utility.showLoader();

        await cot.getDataById(sendId);

        Utility.closeLoader();
        Get.bottomSheet(FittedBox(
          fit: BoxFit.cover,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: GetBuilder<PrimaryController>(builder: (controller) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 300,
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    Text(
                                      'Dr. ${controller.storeDataById['doctor']['first_name'].toString()} ${controller.storeDataById['doctor']['last_name'].toString()}',
                                      style: TextStyles.darkBlack18,
                                    ),
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
                                                                navigatorKey
                                                                    .currentContext,
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
                                                                    GlobalTextField().withLabel(
                                                                        controller: controller.email,
                                                                        onChanged: (text) {
                                                                          controller.emailPhoneInput =
                                                                              text;
                                                                          controller
                                                                              .update();
                                                                        },
                                                                        validator: controller.validateEmailPhoneInput,
                                                                        label: 'Enter email or phone number with comma seprated',
                                                                        hintText: 'Enter email or phone number with comma seprated'),
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
                                                                                    Uri.parse('https://login.airmymd.com/api/invitations/${store[index]['id'].toString()}'),
                                                                                    body: {
                                                                                      'email_phone': controller.email.text,
                                                                                      'url': 'https://airmymd.page.link/visit?id=${store[index]['id']}'
                                                                                    },
                                                                                    headers: {
                                                                                      'Authorization': 'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
                                                                                    },
                                                                                  );
                                                                                  print(request.body);
                                                                                  var response = jsonDecode(request.body);
                                                                                  if (response['returnCode'] == 1) {
                                                                                    Utility.closeLoader();
                                                                                    await navigateWithDeepLink(false, 'https://airmymdapp.page.link/home/?id=${store[index]['id'].toString()}');
                                                                                    Get.back();
                                                                                    Utility.closeLoader();
                                                                                    Get.back();
                                                                                    Utility.showInfoDialog(response["returnMessage"]);
                                                                                  }
                                                                                } catch (e) {
                                                                                  Utility.closeLoader();
                                                                                  Utility.showDialogue(e.toString());
                                                                                  print(e);
                                                                                }
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
                                    'null'
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
                                  'https://login.airmymd.com/${controller.storeDataById['doctor']['image'].toString()}',
                                ),
                                fit: BoxFit.cover),
                        shape: BoxShape.circle),
                    child: const Padding(padding: EdgeInsets.all(8)),
                  ),
                ],
              );
            }),
          ),
        ));
      }
      print("WidgetsBinding");
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
