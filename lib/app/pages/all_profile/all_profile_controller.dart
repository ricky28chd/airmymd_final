import 'package:airmymd/app/constants/page_constants.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';
import 'package:airmymd/app/pages/new_screen/healtdashboard/conroller.dart';
import 'package:airmymd/app/pages/pages.dart';
import 'package:airmymd/app/utils/utility.dart';
import 'package:airmymd/domain/models/get_user_profile_response.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:airmymd/domain/repositories/repository.dart';

class AllProfileController extends GetxController {
  AllProfileController(this._allProfilePresenter);
  final AllProfilePresenter _allProfilePresenter;

  TextEditingController email = TextEditingController();
  String emailPhoneInput = '';
  List<String> emailPhoneList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? validateEmailPhoneInput(String? input) {
    if (input == null || input.isEmpty) {
      return 'Email field can\'t be left blank';
    }

    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final List<String> inputList = input.split(',');
    for (var value in inputList) {
      if (!regex.hasMatch(value) && !regex.hasMatch(value)) {
        return 'Invalid format. Enter valid email separated by commas.';
      }
    }

    return null;
  }

  Future<void> readNotification() async {
    var response = await _allProfilePresenter.readNotification(
      isLoading: true,
    );
    if (response.data != null) {
      notificationCount = 0;
      update();
    }
  }

  Future<void> unreadMessages({
    bool isLoading = true,
  }) async {
    var response =
        await _allProfilePresenter.unreadMessages(isLoading: isLoading);
    if (response.data != null) {
      unreadMessage = response.data!;
    }
    update();
  }

  Future<void> readMessages() async {
    var response = await _allProfilePresenter.readMessages(
      isLoadig: true,
    );
    if (response.data != null) {
      unreadMessage = 0;
      update();
    }
  }

  Future<void> getNotificationList() async {
    var response = await _allProfilePresenter.getNotificationList(
      isLoading: false,
    );
    if (response.data != null) {
      notificationCount = response.data!.unreadCount!;
    }
    update();
  }

  PatientProfile? patientProfile;
  List<ChildUsers> childUsers = [];

  Future<void> getUserProfile({bool isLoading = true}) async {
    var response =
        await _allProfilePresenter.getUserProfile(isLoading: isLoading);
    if (response.returnCode == 1) {
      Get.find<Repository>()
          .saveValue(LocalKeys.userEmail, response.patientProfile.email);
      Get.find<Repository>()
          .saveValue(LocalKeys.userPhone, response.patientProfile.phone);
      Utility.closeLoader();
      patientProfile = response.patientProfile;
      childUsers = response.childUsers;
    }
    update();
  }

  void clearLocalValues() async {
    Get.find<Repository>().saveValue(LocalKeys.location, '');
    Get.find<Repository>().saveValue(LocalKeys.latitude, '');
    Get.find<Repository>().saveValue(LocalKeys.longitude, '');
    // Get.find<Repository>().saveValue(LocalKeys.userEmail, '');
    //Get.find<Repository>().saveValue(LocalKeys.userPhone, '');
    Get.find<Repository>().saveValue(LocalKeys.firstName, '');
    Get.find<Repository>().saveValue(LocalKeys.middleName, '');
    Get.find<Repository>().saveValue(LocalKeys.lastName, '');
    Get.find<Repository>().saveValue(LocalKeys.city, '');
    Get.find<Repository>().saveValue(LocalKeys.state, '');
    Get.find<Repository>().saveValue(LocalKeys.zip, '');
    Get.find<Repository>().saveValue(LocalKeys.height, '');
    Get.find<Repository>().saveValue(LocalKeys.weight, '');
    Get.find<Repository>().saveValue(LocalKeys.gender, '');
    Get.find<Repository>().saveValue(LocalKeys.ethnicity, '');
    Get.find<Repository>().saveValue(LocalKeys.dob, '');
    Get.find<Repository>().saveValue(LocalKeys.maritalStatus, '');
    Get.find<Repository>().saveValue(LocalKeys.medicalHistory, '');
    Get.find<Repository>().saveValue(LocalKeys.surgeries, '');
    Get.find<Repository>().saveValue(LocalKeys.year, '');
    Get.find<Repository>().saveValue(LocalKeys.age, '');
    // print(
    //     'sexual health is =====${patientProfile.sexualHealth.isEmpty}');
    Get.find<Repository>().saveValue(LocalKeys.sexualHealth, '');
    Get.find<Repository>().saveValue(LocalKeys.habits, '');
    Get.find<Repository>().saveValue(LocalKeys.general, '');
    Get.find<Repository>().saveValue(LocalKeys.skin, '');
    Get.find<Repository>().saveValue(LocalKeys.eyes, '');
    Get.find<Repository>().saveValue(LocalKeys.cigarette, '');
    Get.find<Repository>().saveValue(LocalKeys.tobacco, '');
    Get.find<Repository>().saveValue(LocalKeys.streetDrug, '');
    Get.find<Repository>().saveValue(LocalKeys.needleDrug, '');
    Get.find<Repository>().saveValue(LocalKeys.drinkAlcohol, '');
    Get.find<Repository>().saveValue(LocalKeys.howMany, '');
    Get.find<Repository>().saveValue(LocalKeys.drinksInDay, '');
    Get.find<Repository>().saveValue(LocalKeys.cutDown, '');
    Get.find<Repository>().saveValue(LocalKeys.feltGuilty, '');
    Get.find<Repository>().saveValue(LocalKeys.morningDrink, '');
    Get.find<Repository>().saveValue(LocalKeys.profileImage, '');
    update();
  }

  Future<void> parentControl({
    required String userId,
  }) async {
    var response = await _allProfilePresenter.parentControl(
      isLoading: true,
      userId: userId,
    );
    if (response.returnCode == 1) {
      Get.delete<HealthDashboardController>();
      getUserProfile(isLoading: false);
      Get.back();
      Utility.closeDialog();
    }
  }

  var activeUser;

  ///This function will help to update the values of dropdown.
  void updateDropDownValue(value) {
    activeUser = value;
    if (activeUser != null) {
      var selectedUser = childUsers
          .firstWhere((user) => user.childPatientProfile.firstName == value);
      parentControl(userId: selectedUser.childId.toString());
    }
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getUserProfile();
    getNotificationList();
    unreadMessages(isLoading: false);
  }
}
