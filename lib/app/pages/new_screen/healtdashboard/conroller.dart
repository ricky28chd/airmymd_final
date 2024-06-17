import 'dart:async';
import 'dart:convert';

import 'package:airmymd/app/pages/pages.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/helpers/api_wrapper.dart';
import '../../../../domain/entities/enums.dart';
import '../../../../domain/repositories/localstorage_keys.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../utils/utility.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class HealthDashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController title = TextEditingController();
  PickedFile? image;
  String imagePath = '';
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    var xfile = await _picker.pickImage(source: ImageSource.gallery);
    imagePath = xfile!.path;
    // image = (await _picker.getImage(source: ImageSource.gallery))!;
    // imagePath = image!.path;
    update();
  }

  var storeData;
  bool isLoadings = true;
  addSpecialist() async {
    if (title.text.isEmpty) {
      Utility.showMessage('Title can\'t be left blank', MessageType.success,
          () => null, 'Okay');
    } else if (imagePath.isEmpty) {
      Utility.showMessage(
          'Please select icon ', MessageType.success, () => null, 'Okay');
    } else {
      try {
        Get.back();
        Utility.showLoader();
        var headers = {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
          "Content-Type": "application/json",
        };
        var request = http.MultipartRequest(
            'POST', Uri.parse('https://dev.airmymd.com/api/add-speciality'));
        request.fields.addAll({
          'title': title.text,
        });
        if (imagePath.isNotEmpty) {
          request.files
              .add(await http.MultipartFile.fromPath('logo', imagePath));
        }
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        var name = jsonDecode(await response.stream.bytesToString());
        print(name['returnMessage']);
        if (name['returnCode'] == 1) {
          await getData();
          imagePath = '';
          title.clear();

          print(name['returnMessage']);
          Utility.closeLoader();

          Utility.showMessage(
              'New Speciality added', MessageType.success, () => null, 'Okay');
        } else {
          Utility.showMessage(
              'Icon can\'t be empty', MessageType.success, () => null, 'Okay');
          Utility.closeLoader();
          print(response.reasonPhrase);
        }
      } catch (e) {
        Utility.closeLoader();
        Utility.showDialogue(e.toString());
      }
    }
  }

  var loading = true;
  var data;
  getDataArcive() async {
    try {
      var request = await http.get(
        Uri.parse('${ApiWrapper().baseUrl}speciality-archives'),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
          "Content-Type": "application/json",
        },
      );
      var response = jsonDecode(request.body);
      data = response['data'];
      if (response["returnCode"].toString() == '1') {
        print('the data is to be an ${data[0]['title']}');
        update();
      } else {
        Get.snackbar('Error', response['returnMessage']);
      }
      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
      print('the exception is $e');
    }
  }

  getData() async {
    try {
      var request = await http.get(
        Uri.parse('https://dev.airmymd.com/api/health-speciality'),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
          "Content-Type": "application/json",
        },
      );

      var response = jsonDecode(request.body);
      print(response);
      storeData =
          response['data'].where((item) => item['is_archive'] == '0').toList();

      isLoadings = false;
      update();
    } catch (e) {
      Utility.closeDialog();
      isLoadings = false;
      update();
      Utility.showDialogue(e.toString());
    }
  }

  @override
  void onInit() {
    getData();
    getDataArcive();

    // TODO: implement onInit
    super.onInit();
  }
}
