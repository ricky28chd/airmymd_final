// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/utils/list_data_for_project.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/enums.dart';

class AddInsuranceController extends GetxController {
  AddInsuranceController(this._addInsurancePresenter);
  final AddInsurancePresenter _addInsurancePresenter;

  var insuranceId = Get.arguments['id'];
  var navigateFrom = Get.arguments['navigateFrom'];
  var memberId = Get.arguments['memberId'];
  var groupNumber = Get.arguments['groupNumber'];
  var providerName = Get.arguments['providerName'];
  var insuranceImage = Get.arguments['image'];

  ///variable will hold the member id of the user's insurance
  var memberNumberController = TextEditingController();
  var memberError = ''.obs;

  void enterMemberId(String value) {
    if (value.isNotEmpty) {
      memberError.value = '';
    } else {
      memberError.value = 'Member id can\'t be empty';
    }
  }

  ///variable will hold the group number of the user's insurance
  var groupNumberController = TextEditingController();
  var groupError = ''.obs;
  void enterGroupNumber(String value) {
    if (value.isNotEmpty) {
      groupError.value = '';
    } else {
      groupError.value = 'Group number can\'t be empty';
    }
  }

  ///This will be the initial value, which will be empty at first time,
  ///after that the value will update with the help of
  ///updateDropDownValue function.

  var dropItem;
  var dropDownItem;

  var dropDownError = ''.obs;

  ///This function will help to update the values of dropdown.
  void updateDropDownValue(value) {
    dropDownItem = value;
    if (dropDownItem != null) {
      dropDownError.value = '';
    }
    update();
  }

  var otherInsuranceController = TextEditingController();

  var otherInsuranceControllerError = ''.obs;

  void enterOtherInsurance(String value) {
    if (value.isNotEmpty) {
      otherInsuranceControllerError.value = '';
    } else {
      otherInsuranceControllerError.value =
          'Please enter the name of other insurance provider here';
    }
  }

  File? eraseImage;
  File? image;
  Future getImage() async {
    insuranceImage = eraseImage;
    final image = (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    update();
  }

  ///Reset all values.
  void resetAllValues() {
    memberNumberController.clear();
    groupNumberController.clear();
    dropDownItem = dropItem;
    image = eraseImage;
    insuranceId = '';
    update();
  }

  Future<void> onSaveButtonClicked() async {
    print(image);
    if (image != null &&
        dropDownItem != null &&
        dropDownItem != 'Other' &&
        memberNumberController.text.isNotEmpty &&
        groupNumberController.text.isNotEmpty) {
      var response = await _addInsurancePresenter.addInsuranceResponse(
          id: insuranceId,
          provider: dropDownItem,
          phone: memberNumberController.text,
          groupNumber: groupNumberController.text,
          filePath: image!.path);
      if (response.data != null) {
        if (navigateFrom == 'insuranceList' && insuranceId == "0") {
          Get.find<InsuranceListController>().getInsuranceList();
          Get.back();
          resetAllValues();
        } else if (navigateFrom == 'insuranceList' && insuranceId != "0") {
          await Get.find<InsuranceListController>().getInsuranceList();
          Get.back();
          Utility.showMessage(
            'Insurance updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
          resetAllValues();
        } else if (navigateFrom == 'paymentScreen' && insuranceId == "0") {
          Get.find<PaymentController>().getInsuranceList();
          Get.back();
          resetAllValues();
        } else {
          NavigateTo.goToFindDoctorScreen();
        }
      }
    } else if (navigateFrom != 'insuranceList' || insuranceImage == null) {
      Utility.showMessage(
        'Please select insurance image',
        MessageType.information,
        () => Utility.closeSnackBar(),
        'Okay',
      );
    } else if (dropDownItem == null) {
      dropDownError.value = 'Please select provider name';
    } else if (memberNumberController.text.isEmpty) {
      memberError.value = 'Please enter member id';
    } else if (groupNumberController.text.isEmpty) {
      groupError.value = 'Please enter group number';
    } else if (dropDownItem == 'Other' &&
        otherInsuranceController.text.trim().isNotEmpty) {
      if (navigateFrom == 'insuranceList' && insuranceId != "0") {
        if (insuranceImage != null) {
          await _addInsurancePresenter.addInsuranceResponse(
              id: insuranceId,
              provider: otherInsuranceController.text,
              phone: memberNumberController.text,
              groupNumber: groupNumberController.text,
              filePath: '');
          Get.find<InsuranceListController>().getInsuranceList();
          Get.back();
        }
      } else if (image != null &&
          dropDownItem != null &&
          dropDownItem == 'Other' &&
          otherInsuranceController.text.isNotEmpty &&
          memberNumberController.text.isNotEmpty &&
          groupNumberController.text.isNotEmpty) {
        var response = await _addInsurancePresenter.addInsuranceResponse(
            id: insuranceId,
            provider: otherInsuranceController.text,
            phone: memberNumberController.text,
            groupNumber: groupNumberController.text,
            filePath: image!.path);
        if (response.data != null) {
          if (navigateFrom == 'insuranceList' && insuranceId == "0") {
            Get.find<InsuranceListController>().getInsuranceList();
            Get.back();
            resetAllValues();
          } else if (navigateFrom == 'insuranceList' && insuranceId != "0") {
            await Get.find<InsuranceListController>().getInsuranceList();
            Get.back();
            Utility.showMessage(
              'Insurance updated successfully',
              MessageType.success,
              () => Utility.closeSnackBar(),
              'Okay',
            );
            resetAllValues();
          } else if (navigateFrom == 'paymentScreen' && insuranceId == "0") {
            Get.find<PaymentController>().getInsuranceList();
            Get.back();
            resetAllValues();
          } else {
            NavigateTo.goToFindDoctorScreen();
          }
        }
      } else {
        if (image == null) {
          Utility.showMessage(
            'Please select insurance image',
            MessageType.information,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        }
        if (dropDownItem != null) {
          dropDownError.value = '';
        } else {
          dropDownError.value = 'Please select provider name';
        }
        if (memberNumberController.text.isEmpty) {
          memberError.value = 'Please enter member id';
        }
        if (groupNumberController.text.isEmpty) {
          groupError.value = 'Please enter group number';
        }
        if (otherInsuranceController.text.isEmpty) {
          otherInsuranceControllerError.value = 'Please enetr insurance name';
        }
      }
      if (dropDownItem != null) {
        dropDownError.value = '';
      } else {
        dropDownError.value = 'Please select provider name';
      }
      if (memberNumberController.text.isEmpty) {
        memberError.value = 'Please enter member id';
      }
      if (groupNumberController.text.isEmpty) {
        groupError.value = 'Please enter group number';
      }
    } else if (navigateFrom == 'insuranceList' && insuranceId != "0") {
      if (insuranceImage != null) {
        await _addInsurancePresenter.addInsuranceResponse(
            id: insuranceId,
            provider: dropDownItem,
            phone: memberNumberController.text,
            groupNumber: groupNumberController.text,
            filePath: '');
        Get.find<InsuranceListController>().getInsuranceList();
        Get.back();
      } else if (image == null) {
        Utility.showMessage(
          'Please select insurance image',
          MessageType.information,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      }
      if (dropDownItem != null) {
        dropDownError.value = '';
      } else {
        dropDownError.value = 'Please select provider name';
      }
      if (memberNumberController.text.isEmpty) {
        memberError.value = 'Please enter member id';
      }
      if (groupNumberController.text.isEmpty) {
        groupError.value = 'Please enter group number';
      }
    } else if (otherInsuranceController.text.trim().isEmpty) {
      otherInsuranceControllerError.value = 'The value can\'t be empty';
    }
  }

  void assignValues() {
    if (memberId != null) {
      memberNumberController.text = memberId;
    }
    if (groupNumber != null) {
      groupNumberController.text = groupNumber;
    }
    if (providerName != null) {
      for (var i = 0; i < insuranceProviders.length; i++) {
        if (insuranceProviders.contains(providerName)) {
          dropDownItem = providerName;
        } else {
          dropDownItem = 'Other';
          otherInsuranceController.text = providerName;
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    assignValues();
  }
}
