import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/primary_care/primary_care_controllerr.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../domain/repositories/localstorage_keys.dart';

class AddDoctorControler extends GetxController {
  String selectedOption = 'Alabama';
  var doctorId;
  TextEditingController officeNameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lastController = TextEditingController();
  TextEditingController addressConroller = TextEditingController();
  TextEditingController cityConroller = TextEditingController();
  TextEditingController stateConroller = TextEditingController();
  TextEditingController zipConroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? firstNameValidator(String? text) {
    print('is valid or not');
    if (fNameController.text.isEmpty) {
      return 'First name field can\'t be left blank';
    } else {
      return null;
    }
  }

  String? organisationNameValidator(String? text) {
    print('is valid or not');
    if (officeNameController.text.isEmpty) {
      return 'Office name field can\'t be left blank';
    } else {
      return null;
    }
  }

  String? lastControllerValidator(String? text) {
    if (lastController.text.isEmpty) {
      return 'Last name field can\'t be left blank';
    } else {
      return null;
    }
  }

  String? emailNameValidator(String? text) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    if (emailController.text.isEmpty) {
      return 'Email field can\'t be left blank';
    } else if (emailValid == false) {
      return 'Please enter valid email address';
    } else {
      return null;
    }
  }

  String? phoneValidator(String? text) {
    if (phoneController.text.isEmpty) {
      return 'Phone field can\'t be left blank';
    } else if (phoneController.text.length.toString() != '10') {
      return 'Phone field must be 10 digint long';
    } else {
      return null;
    }
  }

  String? addressValidator(String? text) {
    if (addressConroller.text.isEmpty) {
      return 'Address field can\'t be left blank';
    } else {
      return null;
    }
  }

  String? cityValidator(String? text) {
    if (cityConroller.text.isEmpty) {
      return 'City field can\'t be left blank';
    } else {
      return null;
    }
  }

  String? staeValidator(String? text) {
    if (stateConroller.text.isEmpty) {
      return 'State field can\'t be left blank';
    } else {
      return null;
    }
  }

  String? zipValidator(String? text) {
    if (zipConroller.text.isEmpty) {
      return 'Zip field can\'t be left blank';
    } else {
      return null;
    }
  }

  String? websiteValidator(String? text) {
    final urlRegExp = RegExp(
      r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}"
      r"(:[0-9]{1,5})?(\/.*)?$",
      caseSensitive: false,
      multiLine: false,
    );
    if (websiteController.text.isEmpty) {
      return 'Website field can\'t be left blank';
    } else if (!urlRegExp.hasMatch(websiteController.text)) {
      return 'Please enter a valid Website url';
    } else {
      return null;
    }
  }

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

  addDotor() async {
    try {
      Utility.showLoader(color: Colors.black);
      var headers = {
        'Authorization':
            'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
        "Content-Type": "application/json",
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(doctorId != null
              ? 'https://dev.airmymd.com/api/speciality-doctor-update/$doctorId'
              : 'https://dev.airmymd.com/api/add-speciality-doctor/${Get.find<Repository>().getStringValue('specialistId')}'));
      request.fields.addAll({
        'office_name': officeNameController.text,
        'first_name': fNameController.text,
        'last_name': lastController.text,
        'address': addressConroller.text,
        'city': cityConroller.text,
        'state': selectedOption,
        'zip_code': zipConroller.text,
        'email': emailController.text,
        'phone_number': phoneController.text,
        'website': websiteController.text
      });
      print(request.fields);
      if (imagePath.toString().isNotEmpty && imagePath.startsWith('https:')) {
        var response = await http.get(Uri.parse(imagePath.toString()));
        var image = response.bodyBytes;
        request.files.add(http.MultipartFile.fromBytes('image', image,
            filename: imagePath.toString()));
      } else {
        if (imagePath.toString().isNotEmpty) {
          request.files
              .add(await http.MultipartFile.fromPath('image', imagePath));
        }
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      var name = jsonDecode(await response.stream.bytesToString());
      print(name['returnMessage']);
      if (name['returnCode'] == 1) {
        await Get.put(PrimaryController()).getData();
        Utility.closeLoader();
        print('enter');
        print(name['returnMessage']);
        Get.back();
        Utility.showMessage(
            name['returnMessage'], MessageType.success, () => null, 'Okay');

        update();
      } else {
        Utility.showMessage(
            name['returnMessage'], MessageType.error, () => null, 'Okay');
        Utility.closeLoader();
        print(response.reasonPhrase);
      }
    } catch (e) {
      Utility.closeLoader();
      Utility.showDialogue(e.toString());
    }

    Get.put(PrimaryController()).getData();
  }
}
