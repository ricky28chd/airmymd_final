import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/repositories/localstorage_keys.dart';
import '../../../../domain/repositories/repository.dart';

import '../add_doctor/primary_care/primary_care_controllerr.dart';
import '../add_doctor/visit/visit_controller.dart';

class AddVisitController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var foodAllergyList = <Widget>[];
  bool imageSelectedOrNot = false;
  var nameControllerList = <TextEditingController>[];
  var commentControllerList = <TextEditingController>[];
  var medImgList = <String>[];

  Widget addFoodAllergies() {
    var foodNameController = TextEditingController();
    var commController = TextEditingController();

    nameControllerList.add(foodNameController);
    commentControllerList.add(commController);

    return allergiesFieldNew(
      foodNameController: foodNameController,
      commController: commController,
    );
  }

  void removeFoodAllergy(index) {
    try {
      foodAllergyList.removeAt(index);
      nameControllerList.removeAt(index);
      commentControllerList.removeAt(index);

      medImgList.removeAt(index);
    } catch (e) {}
    update();
  }

  TextEditingController controller = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  var storeData;
  bool isLoading = true;
  TimeOfDay? selectedTime;
  DateTime selectedDate = DateTime.now();
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;

      String formattedTime = pickedTime.format(context);

      timeController.text = formattedTime;

      print(formattedTime);
      print(pickedTime);
      update();
    }
  }

  List<String> imageList = [];
  pickImage() async {
    final statusSecond = await Permission.manageExternalStorage.request();
    final status = await Permission.storage.request();

    if (status.isGranted || statusSecond.isGranted) {
      // Storage permission granted, proceed to pick files.
      // isPermisionStatus = true;
      // setState(() {

      // });
    } else if (status.isDenied || statusSecond.isDenied) {
      // Permission denied, show a message to the user.
      Utility.showMessage(
        'Please grant permission to access storage for file operations.',
        MessageType.information,
        () => Get.back(),
        'OK',
      );
    } else if (status.isPermanentlyDenied || statusSecond.isPermanentlyDenied) {
      // Permission permanently denied, show a dialog to open app settings.
      Utility.showMessage(
        'Please enable storage permission in app settings to continue.',
        MessageType.information,
        () => openAppSettings(),
        'Open Settings',
      );
    } else {
      // Handle other cases if needed.
      Utility.showMessage(
        'An error occurred while requesting storage permission.',
        MessageType.information,
        () => Get.back(),
        'OK',
      );
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'doc', 'pdf'],
    );

    if (result != null) {
      // Process the picked files
      imageList.addAll(result.paths.map((e) => e.toString()));
      print('Files picked: $imageList');
      update();
    }
  }

  removeImageList(index) {
    imageList.removeAt(index);
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (DateTime newDateTime) {
            controller.text = DateFormat('MM-dd-yyyy')
                .format(DateTime.parse(newDateTime.toString()));
          },
        ),
      ),
    );
  }

  deleteVisit() async {
    print(storeVisitId);
    try {
      var headers = {
        'Authorization':
            'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
        'Accept': 'application/json',
      };
      Utility.showLoader();
      var request = await http.delete(
          Uri.parse(
              'https://dev.airmymd.com/api/speciality-visit-delete/$storeVisitId'),
          headers: headers);
      var response = json.decode(request.body);
      if (response['returnCode'] == 1) {
        await Get.put(PrimaryController()).getData();
        await Get.put(VisitController()).getData();

        Utility.closeLoader();

        Utility.showMessage(
            response['returnMessage'], MessageType.success, () => null, 'Okay');
        Get.back();
        update();
      } else {
        Utility.showMessage(response['returnMessage'], MessageType.success,
            () => Get.back(), 'Okay');
        Utility.closeLoader();
      }
    } catch (e) {
      print(e);
      Utility.showMessage(
          e.toString(), MessageType.success, () => Get.back(), 'Okay');
    }
  }

  String convertDateToUTC(String inputDate) {
    try {
      // Parse the input date string into a DateTime object.
      final inputFormat = DateFormat('yyyy-MM-dd');
      final date = inputFormat.parse(inputDate);

      // Convert the parsed date to UTC.
      final utcDate = date.toUtc();

      // Format the UTC date.
      final outputFormat = DateFormat('yyyy-MM-dd');
      return outputFormat.format(utcDate);
    } catch (e) {
      print('Error converting date to UTC: $e');
      return ''; // Return an empty string or handle the error as needed.
    }
  }

  var storeVisitId = 0;
  var selectedOption = Get.put(PrimaryController()).doctors.first.toString();
  addVisit() async {
    if (controller.text.isEmpty) {
      Utility.showMessage('Date field can\'t be empty', MessageType.success,
          () => Get.back(), 'Okay');
    } else if (timeController.text.isEmpty) {
      Utility.showMessage('Time field can\'t be empty', MessageType.success,
          () => Get.back(), 'Okay');
    } else {
      if (formKey.currentState!.validate()) {
        // Define the input format
        DateFormat inputFormat = DateFormat("h:mm a");

        // Parse the input string into a DateTime object
        DateTime dateTime = inputFormat.parse(timeController.text);

        // Define the output format
        DateFormat outputFormat = DateFormat("HH:mm:ss");

        // Format the DateTime object into the desired format
        String output = outputFormat.format(dateTime);
        print('the utc time =>>>>>>>>>>>>>>>>>>>>> $output');
        print(
            'the utc time =>>>>>>>>>>>>>>>>>>>>> ${outputFormat.format(dateTime)}');

        try {
          Utility.showLoader(color: Colors.black);
          var headers = {
            'Authorization':
                'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
            'Accept': 'application/json',
          };
          final originalDateFormat = DateFormat('MM-dd-yyyy');
          // Define the desired output date format
          final desiredDateFormat = DateFormat('yyyy-MM-dd');

          // Parse the original date string
          final parsedDate = originalDateFormat.parse(controller.text);

          // Format the parsed date to the desired output format
          print(
              'the utc date is =>>>>>>>>>>>>>>>>>>>>> ${desiredDateFormat.format(parsedDate.toLocal().toUtc())}');
          print(
              'the Withoututc date is =>>>>>>>>>>>>>>>>>>>>> ${desiredDateFormat.format(parsedDate)}');
          var request = http.MultipartRequest(
              'POST',
              Uri.parse(storeVisitId != 0
                  ? 'https://dev.airmymd.com/api/speciality-visit-update/$storeVisitId'
                  : 'https://dev.airmymd.com/api/add-visit/${Get.find<Repository>().getStringValue('specialistId')}'));

          request.fields.addAll({
            'doctor_id': Get.put(PrimaryController()).doctorId[index],
            'date': desiredDateFormat.format(parsedDate),
            'time': output,
            'note': notesController.text,
          });

          for (int i = 0; i < imageList.length; i++) {
            print('the prit t is no #${imageList[i]}');

            if (imageList[i]
                    .toString()
                    .replaceAll('(', '')
                    .replaceAll(')', '')
                    .isNotEmpty &&
                imageList[i]
                    .replaceFirst('(', '')
                    .replaceAll(')', '')
                    .startsWith('upload')) {
              print('one entering value');
              var response = await http.get(Uri.parse(
                  'https://dev.airmymd.com/${imageList[i].replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '')}'));
              print('one entering value');
              var image = response.bodyBytes;
              request.files.add(http.MultipartFile.fromBytes('image[$i]', image,
                  filename:
                      'https://dev.airmymd.com/${imageList[i].replaceAll('(', '').replaceAll(')', '')}'));
            } else {
              print('one entering value1 new one');
              if (imageList[i].toString().isNotEmpty) {
                request.files.addAll({
                  await http.MultipartFile.fromPath('image[$i]', imageList[i])
                });
              }
            }
          }
          for (int i = 0; i < medImgList.length; i++) {
            if (medImgList[i]
                    .replaceAll('(', '')
                    .replaceAll(')', '')
                    .replaceAll(' ', '')
                    .isNotEmpty &&
                medImgList[i]
                    .replaceFirst('(', '')
                    .replaceAll(')', '')
                    .replaceAll(' ', '')
                    .startsWith('https')) {
              var response = await http.get(Uri.parse(medImgList[i]
                  .replaceAll('(', '')
                  .replaceAll(')', '')
                  .replaceAll(' ', '')));
              var image = response.bodyBytes;
              request.files.add(http.MultipartFile.fromBytes(
                  'medicine[$i][file][$i]', image,
                  filename: medImgList[i]
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', '')
                      .replaceAll(' ', '')));
            } else {
              print('last one iam printing for the one ${medImgList[i]}');
              print('one entering value 3');
              if (medImgList[i].isNotEmpty) {
                print('one entering value2');
                request.files.addAll({
                  await http.MultipartFile.fromPath(
                      'medicine[$i][file][$i]', medImgList[i])
                });
              }
            }
          }

          for (int i = 0; i < nameControllerList.length; i++) {
            if (nameControllerList[i].text.isNotEmpty) {
              request.fields
                  .addAll({'medicine[$i][name]': nameControllerList[i].text});
            }
          }

          for (int i = 0; i < commentControllerList.length; i++) {
            if (commentControllerList[i].text.isNotEmpty) {
              request.fields.addAll(
                  {'medicine[$i][purpose]': commentControllerList[i].text});
            }
          }

          request.headers.addAll(headers);
          print(request.fields);

          http.StreamedResponse response = await request.send();

          var name = jsonDecode(await response.stream.bytesToString());
          print(response.statusCode);
          print(name['returnCode']);
          if (name['returnCode'] == 1) {
            print('under 200');
            await Get.put(PrimaryController()).getData();
            await Get.put(VisitController()).getData();

            Utility.closeLoader();

            Utility.showMessage(
                name['returnMessage'], MessageType.success, () => null, 'Okay');
            Get.back();
            update();
          } else {
            Utility.showMessage(name['returnMessage'], MessageType.success,
                () => Get.back(), 'Okay');
            Utility.closeLoader();
          }
          update();
        } catch (e) {
          Utility.closeLoader();
          print('value is $e');
          isLoading = false;
          update();

          Utility.showDialogue(e.toString());
        }
      }
    }
  }

  var index = 0;
  onchange(newValue) {
    index = Get.put(PrimaryController()).doctors.indexOf(newValue);
    print(Get.put(PrimaryController()).doctorId);
    print(
      Get.put(PrimaryController()).doctorId[index],
    );
    selectedOption = newValue;
    print(selectedOption);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}

Widget allergiesFieldNew(
    {required TextEditingController foodNameController,
    required TextEditingController commController,
    context}) {
  return GetBuilder<AddVisitController>(builder: (controller) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GlobalTextField().withLabel(
            context: context,
            textInputAction: TextInputAction.next,
            validator: (value) {
              for (int i = 0; i < controller.medImgList.length; i++) {
                if (commController.text.isNotEmpty ||
                    controller.medImgList[i].isNotEmpty) {
                  if (foodNameController.text.isEmpty) {
                    return 'Name field can\'t be left blank';
                  }
                } else {
                  return null;
                }
              }
              return null;
            },
            textCapitalization: TextCapitalization.sentences,
            hintText: 'Name',
            label: 'Name',
            controller: foodNameController,
          ),
          GlobalTextField().withLabel(
            maxLines: 3,
            context: context,
            validator: (value) {
              for (int i = 0; i < controller.medImgList.length; i++) {
                if (foodNameController.text.isNotEmpty ||
                    controller.medImgList[i].isNotEmpty) {
                  if (commController.text.isEmpty) {
                    return 'Purpose field can\'t be left blank';
                  }
                } else {
                  return null;
                }
              }
              return null;
            },
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            hintText: 'Purpose',
            label: 'Purpose',
            controller: commController,
          ),
          const SizedBox(
            height: 5,
          ),
        ]));
  });
}
