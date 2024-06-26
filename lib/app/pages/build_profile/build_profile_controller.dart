// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, duplicate_ignore

import 'dart:io';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/data/data.dart';
import 'package:airmymd/data/helpers/api_wrapper.dart';
import 'package:airmymd/device/repositories/device_repositories.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BuildProfileController extends GetxController {
  BuildProfileController(this._buildProfilePresenter);
  final BuildProfilePresenter _buildProfilePresenter;

  ///[firstNameController]========================================================
  ///Variable stores first name of he user.
  var firstNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var otpController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  ///[firstNameError] will null if the value is valid.
  var firstNameError = ''.obs;
  var oldPasswordError = ''.obs;
  var newPasswordError = ''.obs;
  var confirmNewPasswordError = ''.obs;

  ///Method to validate Passwords field
  void enterOldPassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.length >= 8) {
        oldPasswordError.value = '';
      } else {
        oldPasswordError.value =
            'Old Password must be at least 8 characters long';
      }
    } else {
      oldPasswordError.value = 'Old Password can\'t be empty';
    }
    debugPrint('oldPassword ${oldPasswordController.text}');
    update();
  }

  void enterNewPassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.length >= 8) {
        newPasswordError.value = '';
      } else {
        newPasswordError.value =
            'New Password must be at least 8 characters long';
      }
    } else {
      newPasswordError.value = 'New Password can\'t be empty';
    }
    debugPrint('newPassword ${newPasswordController.text}');
    update();
  }

  void enterConfirmNewPassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value == newPasswordController.text) {
        confirmNewPasswordError.value = '';
      } else {
        confirmNewPasswordError.value =
            'Confirm New Password does not match the New Password';
      }
    } else {
      confirmNewPasswordError.value = 'Confirm New Password can\'t be empty';
    }
    debugPrint('confirmNewPassword ${confirmNewPasswordController.text}');
    update();
  }

  ///Method to validate first name field
  void enterFirstName(String value) {
    if (value.trim().isNotEmpty) {
      firstNameError.value = '';
    } else {
      firstNameError.value = 'First name can\'t be empty';
    }
    debugPrint('firstName ${firstNameController.text}');
    update();
  }

  void enterEmail(String value) {
    if (value.trim().isNotEmpty) {
      emailError.value = '';
    } else {
      emailError.value = 'Email can\'t be empty';
    }
    debugPrint('firstName ${firstNameController.text}');
  }

  void enterphone(String value) {
    // Get.find<DeviceRepository>()
    //     .saveValue(LocalKeys.userPhone, phoneController.text);
    if (value.trim().isNotEmpty) {
      phoneError.value = '';
    } else {
      phoneError.value = 'Phone can\'t be empty';
    }
    debugPrint('firstName ${firstNameController.text}');
  }

  void enterotp(String value) {
    if (value.trim().isNotEmpty) {
      otpError.value = '';
    } else {
      otpError.value = 'Otp can\'t be empty';
    }
    debugPrint('firstName ${firstNameController.text}');
  }

  ///[middleNameController]=========================================================
  var middleNameController = TextEditingController();

  ///[lastNameController]=========================================================
  var lastNameController = TextEditingController();

  ///[lastNameError] will null if the value is valid.
  var lastNameError = ''.obs;
  var emailError = ''.obs;
  var phoneError = ''.obs;
  var otpError = ''.obs;

  ///Method to validate first name field
  void enterLastName(String value) {
    if (value.trim().isNotEmpty) {
      lastNameError.value = '';
    } else {
      lastNameError.value = 'Last name can\'t be empty';
    }
    debugPrint('lastName ${lastNameController.text}');
  }

  ///[cityController]=========================================================
  var cityController = TextEditingController();

  ///[cityError] will null if the value is valid.
  var cityError = ''.obs;

  ///Method to validate first name field
  void enterCityName(String value) {
    if (value.trim().isNotEmpty) {
      cityError.value = '';
    } else {
      cityError.value = 'City name can\'t be empty';
    }
    debugPrint('City ${cityController.text}');
  }

  ///[stateController]=========================================================
  ///This will be the initial value, which will be empty at first time,
  ///after that the value will update with the help of
  ///updateDropDownValue function.
  // ignore: prefer_typing_uninitialized_variables
  var stateDropDownItem;

  ///[stateError] will null if the value is valid.
  var stateError = ''.obs;

  ///This function will help to update the values of [stateDropDownItem].
  void enterStateName(value) {
    stateDropDownItem = value;
    stateError.value = '';
    update();
  }

  ///[zipController]=========================================================
  var zipController = TextEditingController();

  ///[zipError] will null if the value is valid.
  var zipError = ''.obs;

  ///Method to validate first name field
  void enterZipCode(String value) {
    if (value.trim().isNotEmpty) {
      zipError.value = '';
    } else {
      zipError.value = 'ZipCode can\'t be empty';
    }
    debugPrint('Zip ${zipController.text}');
  }

  ///[heightController]=========================================================
  var heightController = TextEditingController();

  ///[heightError] will null if the value is valid.
  var heightError = ''.obs;

  ///height input formatter
  var heightMaskFormatter = MaskTextInputFormatter(
      mask: '#′ ##"',
      filter: {
        "#": RegExp(r'[0-10]'),
      },
      type: MaskAutoCompletionType.eager);

  ///Method to validate first name field
  void enterHeight(String value) {
    if (value.trim().isNotEmpty) {
      heightError.value = '';
    } else {
      heightError.value = 'Height can\'t be empty';
    }
    debugPrint('height ${heightController.text}');
  }

  ///[weightController]=========================================================
  var weightController = TextEditingController();

  ///[weightError] will null if the value is valid.
  var weightError = ''.obs;

  ///Method to validate first name field
  void enterWeight(String value) {
    if (value.trim().isNotEmpty) {
      weightError.value = '';
    } else {
      weightError.value = 'Weight can\'t be empty';
    }
    debugPrint('weight ${weightController.text}');
  }

  ///[genderController]=========================================================
  var genderDropDownItem;

  ///[weightError] will null if the value is valid.
  var genderError = ''.obs;

  ///Method to validate first name field
  void enterGender(value) {
    genderDropDownItem = value;
    genderError.value = '';
    update();
  }

  ///[ethnicityController]=========================================================
  var ethnicityDropDownItem;

  ///[ethnicityError] will null if the value is valid.
  var ethnicityError = ''.obs;

  ///Method to validate first name field
  void enterEthnicity(value) {
    ethnicityDropDownItem = value;
    ethnicityError.value = '';
    update();
  }

  ///[dobController]=========================================================
  var dobController = TextEditingController();

  ///[ethnicityError] will null if the value is valid.
  var dobError = ''.obs;

  ///Method to validate first name field
  void enterDob(String value) {
    if (value.trim().isNotEmpty) {
      dobError.value = '';
    } else {
      dobError.value = 'DOB can\t be empty';
    }
    debugPrint('DOB ${dobController.text}');
  }

  var profileImage = Get.find<Repository>().getStringValue('saveImage');

  File? image;
  Future getImage() async {
    profileImage = '';
    final image = (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (image == null) return;
    Get.find<Repository>().saveValue('saveImage', '');
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    update();
  }

  ///[maritalController]=========================================================
  var maritalStatusDropDownItem;

  ///[ethnicityError] will null if the value is valid.
  var maritalError = ''.obs;

  ///Method to validate first name field
  void enterMaritalStatus(value) {
    maritalStatusDropDownItem = value;
    maritalError.value = '';
    update();
  }

  ///Method will reset all the values of controller.
  void resetAllValues() {
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    cityController.clear();
    stateDropDownItem;
    zipController.clear();
    heightController.clear();
    weightController.clear();
    genderDropDownItem;
    ethnicityDropDownItem;
    dobController.clear();
    maritalStatusDropDownItem;
    update();
  }

  var navigateFrom =
      Get.arguments == null ? null : Get.arguments['NavigateFrom'];

  ///get all the local values save during the login process=====================

  void getFirstName() {
    var firstName = Get.find<Repository>().getStringValue(LocalKeys.firstName);
    firstNameController.text = firstName;
  }

  void getemail() {
    var email = Get.find<Repository>().getStringValue(LocalKeys.userEmail);
    emailController.text = email;
  }

  void getphone() {
    var phone = Get.find<Repository>().getStringValue(LocalKeys.userPhone);
    phoneController.text = phone;
  }

  void getMiddleName() {
    var middleName =
        Get.find<Repository>().getStringValue(LocalKeys.middleName);
    if (middleName.isNotEmpty) {
      middleNameController.text = middleName;
    } else {
      null;
    }
  }

  void getLastName() {
    var lastName = Get.find<Repository>().getStringValue(LocalKeys.lastName);
    if (lastName.isNotEmpty) {
      lastNameController.text = lastName;
    } else {
      null;
    }
  }

  void getCity() {
    var city = Get.find<Repository>().getStringValue(LocalKeys.city);
    if (city.isNotEmpty) {
      cityController.text = city;
    } else {
      null;
    }
  }

  void getState() {
    var stateName = Get.find<Repository>().getStringValue(LocalKeys.state);
    if (stateName.isNotEmpty) {
      stateDropDownItem = stateName;
    } else {
      stateDropDownItem;
    }
  }

  void getZip() {
    var zip = Get.find<Repository>().getStringValue(LocalKeys.zip);
    if (zip.isNotEmpty) {
      zipController.text = zip;
    } else {
      null;
    }
  }

  void getHeight() {
    var height = Get.find<Repository>().getStringValue(LocalKeys.height);
    if (height.isNotEmpty) {
      heightController.text = height;
    } else {
      null;
    }
  }

  void getWeight() {
    var weight = Get.find<Repository>().getStringValue(LocalKeys.weight);
    if (weight.isNotEmpty) {
      weightController.text = weight;
    } else {
      null;
    }
  }

  void getGender() {
    var genderName = Get.find<Repository>().getStringValue(LocalKeys.gender);
    if (genderName.isNotEmpty) {
      genderDropDownItem = genderName;
    } else {
      genderDropDownItem;
    }
  }

  void getEthnicity() {
    var ethnicity = Get.find<Repository>().getStringValue(LocalKeys.ethnicity);
    if (ethnicity.isNotEmpty) {
      ethnicityDropDownItem = ethnicity;
    } else {
      ethnicityDropDownItem;
    }
  }

  void getDob() {
    var dob = Get.find<Repository>().getStringValue(LocalKeys.dob);
    if (dob.isNotEmpty) {
      dobController.text = DateFormat('yMMMd').format(DateTime.parse(dob));
    } else {
      null;
    }
  }

  void getMaritalStatus() {
    var maritalStatusField =
        Get.find<Repository>().getStringValue(LocalKeys.maritalStatus);
    if (maritalStatusField.isNotEmpty) {
      maritalStatusDropDownItem = maritalStatusField;
    } else {
      maritalStatusDropDownItem;
    }
  }

  verifyEmailAndPassword() {
    if (Get.find<Repository>().getStringValue(LocalKeys.userEmail) !=
        emailController.text) {
      // NavigateTo.goToOtpScreen(routeFrom: routeFrom)
    }
  }

  void onChangePasswordButtonClicked() async {
    //  if (oldPasswordController.text.isEmpty) {
    //       oldPasswordError.value = 'Enter your old password';
    //     }
    if (newPasswordController.text.isEmpty) {
      newPasswordError.value = 'Enter your new password';
    }
    // if (confirmNewPasswordController.text.isEmpty) {
    //   confirmNewPasswordError.value = 'Enter your confirm new password';
    // }
    else {
      Utility.closeDialog();
      Utility.closeLoader();
      Utility.closeSnackBar();
      var data = {
        'password': newPasswordController.text,
        "user_id": Get.find<Repository>().getStringValue(LocalKeys.userId),
        // ""
      };
      var responseData = await ApiWrapper().makeRequest(
        'reset-password',
        Request.post,
        data,
        true,
        {"Content-Type": "application/json"},
      );

      if (responseData.hasError) {
        Utility.showInfoDialog(responseData, false);
      } else {
        NavigateTo.goToLoginScreen();
        Utility.showMessage('Password changed successfully',
            MessageType.success, () => Utility.closeSnackBar(), 'Okay');
      }
    }
  }

  ///Api call===================================================================
  ///Build profile Api call
  void onSaveButtonClicked() async {
    String parentId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.parentId)
        .toString();

    String childId = Get.find<DeviceRepository>()
        .getStringValue(LocalKeys.childId)
        .toString();

    if (firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        cityController.text.trim().isNotEmpty &&
        stateDropDownItem != null &&
        zipController.text.trim().isNotEmpty &&
        heightController.text.trim().isNotEmpty &&
        weightController.text.trim().isNotEmpty &&
        genderDropDownItem != null &&
        ethnicityDropDownItem != null &&
        dobController.text.isNotEmpty &&
        maritalStatusDropDownItem != null) {
      // ignore: unused_local_variable
      var response = await _buildProfilePresenter.profileUserModel(
        parentId: parentId.isEmpty ? '' : parentId,
        childId: childId.isEmpty ? '' : childId,
        profileImage: image != null ? image!.path : '',
        firstName: firstNameController.text,
        middleName: middleNameController.text,
        lastName: lastNameController.text,
        city: cityController.text,
        state: stateDropDownItem,
        zip: zipController.text,
        height: heightController.text,
        weight: weightController.text,
        gender: genderDropDownItem,
        ethnicity: ethnicityDropDownItem,
        dob: dobController.text,
        maritalStatus: maritalStatusDropDownItem,
        email: emailController.text,
        phone: phoneController.text,
      );
      if (navigateFrom == 'Setting Screen') {
        Get.find<AllProfileController>().getUserProfile(isLoading: false);
        Get.back();
        Get.back();
        Utility.showMessage(
          'Profile updated successfully',
          MessageType.success,
          () => Utility.closeSnackBar(),
          'Okay',
        );
      } else {
        NavigateTo.goToAllergiesScreen();
      }
    } else {
      if (navigateFrom == 'Setting Screen') {
        if (firstNameController.text.trim().isNotEmpty &&
            lastNameController.text.trim().isNotEmpty &&
            emailController.text.trim().isNotEmpty &&
            phoneController.text.trim().isNotEmpty &&
            cityController.text.trim().isNotEmpty &&
            stateDropDownItem != null &&
            zipController.text.trim().isNotEmpty &&
            heightController.text.trim().isNotEmpty &&
            weightController.text.trim().isNotEmpty &&
            genderDropDownItem != null &&
            ethnicityDropDownItem != null &&
            dobController.text.isNotEmpty &&
            maritalStatusDropDownItem != null) {
          var response = await _buildProfilePresenter.profileUserModel(
              parentId: parentId.isEmpty ? '' : parentId,
              childId: childId.isEmpty ? '' : childId,
              profileImage: '',
              firstName: firstNameController.text,
              middleName: middleNameController.text,
              lastName: lastNameController.text,
              city: cityController.text,
              state: stateDropDownItem,
              zip: zipController.text,
              height: heightController.text,
              weight: weightController.text,
              gender: genderDropDownItem,
              ethnicity: ethnicityDropDownItem,
              dob: apiHitDate,
              maritalStatus: maritalStatusDropDownItem,
              email: emailController.text,
              phone: phoneController.text);
          Get.find<AllProfileController>().getUserProfile(isLoading: false);
          Get.back();
          Get.back();
          Utility.showMessage(
            'Profile updated successfully',
            MessageType.success,
            () => Utility.closeSnackBar(),
            'Okay',
          );
        } else {}
      } else {
        if (firstNameController.text.isEmpty) {
          firstNameError.value = 'Enter your first name';
        }
        if (lastNameController.text.isEmpty) {
          lastNameError.value = 'Enter your last name';
        }
        if (emailController.text.isEmpty) {
          emailError.value = 'Enter your email ';
        }
        if (phoneController.text.isEmpty) {
          phoneError.value = 'Enter your phone';
        }
        if (cityController.text.isEmpty) {
          cityError.value = 'Enter your city name';
        }
        if (stateDropDownItem == null) {
          stateError.value = 'Select your state';
        }
        if (zipController.text.isEmpty) {
          zipError.value = 'Enter zipcode';
        }
        if (heightController.text.isEmpty) {
          heightError.value = 'Enter your height';
        }
        if (weightController.text.isEmpty) {
          weightError.value = 'Enter your weight';
        }
        if (genderDropDownItem == null) {
          genderError.value = 'Select your gender';
        }
        if (ethnicityDropDownItem == null) {
          ethnicityError.value = 'Select your ethnicity';
        }
        if (dobController.text.isEmpty) {
          dobError.value = 'Enter your date of birth';
        }
        if (maritalStatusDropDownItem == null) {
          maritalError.value = 'Enter your marital status';
        } else {
          if (firstNameController.text.isEmpty) {
            firstNameError.value = 'Enter your first name';
          }
          if (lastNameController.text.isEmpty) {
            lastNameError.value = 'Enter your last name';
          }
          if (cityController.text.isEmpty) {
            cityError.value = 'Enter your city name';
          }
          if (stateDropDownItem == null) {
            stateError.value = 'Select your state';
          }
          if (zipController.text.isEmpty) {
            zipError.value = 'Enter zipcode';
          }
          if (heightController.text.isEmpty) {
            heightError.value = 'Enter your height';
          }
          if (weightController.text.isEmpty) {
            weightError.value = 'Enter your weight';
          }
          if (genderDropDownItem == null) {
            genderError.value = 'Select your gender';
          }
          if (ethnicityDropDownItem == null) {
            ethnicityError.value = 'Select your ethnicity';
          }
          if (dobController.text.isEmpty) {
            dobError.value = 'Enter your dob(Date of birth)';
          }
          if (maritalStatusDropDownItem == null) {
            maritalError.value = 'Enter your marital status';
          }
        }
      }
    }
  }

  ///Calender Method============================================================
  ///variable stores default date shown in calender
  var initialDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  var apiHitDate = '';

  void selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month - 1, DateTime.now().day),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryColor,
                  onPrimary: AppColors.whiteColor,
                  onSurface: AppColors.blackColor,
                ),
              ),
              child: child!);
        });
    if (selected != null) {
      initialDate = selected;
      apiHitDate = DateFormat('yyyy-MM-dd').format(selected);
      dobController.text = DateFormat('yMMMd').format(selected);
      if (dobController.text.isNotEmpty) {
        dobError.value = '';
      }
    }
  }

  @override
  void onInit() {
    var email = Get.find<Repository>().getStringValue(LocalKeys.userEmail);
    emailController.text = email;

    var phone = Get.find<Repository>().getStringValue(LocalKeys.userPhone);
    print(phone);
    phoneController.text = phone;
    if (navigateFrom == 'Setting Screen') {
      profileImage = '';
      getFirstName();
      getMiddleName();
      getemail();
      getphone();
      getLastName();
      getCity();
      getState();
      getZip();
      getHeight();
      getWeight();
      getGender();
      getEthnicity();
      getDob();
      getMaritalStatus();
    }
    super.onInit();
    update();
  }
}

///height feild input formatter

class HeightFormatter extends TextInputFormatter {
  final String sample;
  final String seperator;
  HeightFormatter({
    required this.sample,
    required this.seperator,
  });
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) {
          return oldValue;
        }

        if (newValue.text.length < sample.length &&
            sample[newValue.text.length - 1] == seperator) {
          return TextEditingValue(
              text:
                  '${oldValue.text}\'${newValue.text.substring(newValue.text.length - 1)}"',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end + 1,
              ));
        }
      }
    }
    return newValue;
  }
}
