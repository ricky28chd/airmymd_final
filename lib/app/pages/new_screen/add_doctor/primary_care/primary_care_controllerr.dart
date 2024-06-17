import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:http/http.dart' as http;

import '../../../../../domain/repositories/localstorage_keys.dart';
import '../../../../../domain/repositories/repository.dart';

class PrimaryController extends GetxController {
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String emailPhoneInput = '';
  List<String> emailPhoneList = [];
  String? validateEmailPhoneInput(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter email or phone number(s)';
    }

    final regex = RegExp(
        r'^\s*([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}|[\d,]+)\s*$');
    final List<String> inputList = input.split(',');
    for (var value in inputList) {
      if (!regex.hasMatch(value) && !regex.hasMatch(value)) {
        return 'Invalid format. Enter valid email or phone number(s) separated by commas.';
      }
    }

    return null;
  }

  bool isValidEmail(String email) {
    // Implement your email validation logic here
    return true;
  }

  bool isValidPhoneNumber(String phone) {
    // Implement your phone number validation logic here
    return true;
  }

  var selectedButton = 'Upcoming Appointments';
  void onUpcomingButtonSelected() {
    selectedButton = 'Upcoming Appointments';
    update();
  }

  void onPastButtonSelected() {
    selectedButton = 'Past Appointments';
    update();
  }

  var foodAllergyList = <Widget>[];
  var commentControllerList = <TextEditingController>[];
  var nameControllerList = <TextEditingController>[];
  var toDateControllerList = <TextEditingController>[];
  var fromListController = <TextEditingController>[];
  Widget addFoodAllergies({String title = "", String comment = "", context}) {
    var foodNameController = TextEditingController();
    var commController = TextEditingController();
    var toDate = TextEditingController();
    var fromDate = TextEditingController();

    nameControllerList.add(foodNameController);
    commentControllerList.add(commController);
    toDateControllerList.add(toDate);
    fromListController.add(fromDate);
    foodNameController.text = title;
    commController.text = comment;
    return allergiesField(
        context: context,
        foodNameController: foodNameController,
        commController: commController,
        toDate: toDate,
        fromDate: fromDate);
  }

  void removeFoodAllergy(index) {
    foodAllergyList.removeAt(index);
    update();
  }

  var storeData;
  bool isLoading = true;
  List<String> doctors = [];
  List<String> doctorId = [];
  getData() async {
    try {
      var request = await http.get(
        Uri.parse(
            'https://dev.airmymd.com/api/speciality-doctors/${Get.find<Repository>().getStringValue('specialistId')}'),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
          "Content-Type": "application/json",
        },
      );
      var response = jsonDecode(request.body);
      print(response);
      storeData = response['data'];
      doctors.clear();
      doctorId.clear();
      for (int i = 0; i < response['data']['doctors'].length; i++) {
        if (!doctors.contains(response['data']['doctors'][i]['first_name'])) {
          doctors.add(
              'Dr. ${response['data']['doctors'][i]['first_name'].toString().capitalizeFirst} ${response['data']['doctors'][i]['last_name'].toString().capitalizeFirst}');
        }
        if (!doctors.contains(response['data']['doctors'][i]['id'])) {
          doctorId.add(response['data']['doctors'][i]['id'].toString());
        }
        print('the doctor id $doctorId');
      }
      await Future.delayed(const Duration(seconds: 2));
      print(doctors);
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Utility.showDialogue(e.toString());
    }
  }

  delteDataById(String id) async {
    try {
      Utility.showLoader();
      var request = await http.delete(
        Uri.parse(
          'https://login.airmymd.com/api/speciality-doctor-delete/$id',
        ),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
          "Content-Type": "application/json",
        },
      );

      var response = jsonDecode(request.body);
      await getData();
      Utility.closeLoader();
      Get.back();
      update();
    } catch (e) {
      Utility.closeLoader();
      Utility.showDialogue(e.toString());
    }
  }

  var storeDataById;

  getDataById(String id) async {
    try {
      //Utility.showLoader();
      var request = await http.get(
        Uri.parse(
          'https://dev.airmymd.com/api/speciality-view-doctor/$id',
        ),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
          "Content-Type": "application/json",
        },
      );

      var response = jsonDecode(request.body);
      print(response);
      storeDataById = response['data'];

      // Utility.closeLoader();
      update();
    } catch (e) {
      // Utility.closeLoader();
      Utility.showDialogue(e.toString());
    }
  }

  @override
  void onInit() async {
    await getData();

    // TODO: implement onInit
    super.onInit();
  }
}

Widget allergiesField({
  required TextEditingController foodNameController,
  required TextEditingController commController,
  required TextEditingController toDate,
  required TextEditingController fromDate,
  required BuildContext context,
}) {
  return GetBuilder<ProfileSettingController>(builder: (controller) {
    return Container(
        alignment: Alignment.topCenter,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GlobalTextField().withLabel(
            context: context,
            textInputAction: TextInputAction.next,
            hintText: 'Employer Name',
            controller: foodNameController,
          ),
          GlobalTextField().withLabel(
            context: context,
            textInputAction: TextInputAction.next,
            hintText: 'Position',
            controller: commController,
          ),
          GlobalTextField().withLabel(
            context: context,
            textInputAction: TextInputAction.next,
            hintText: 'From Date',
            controller: fromDate,
          ),
          GlobalTextField().withLabel(
            context: context,
            textInputAction: TextInputAction.next,
            hintText: 'To Date',
            controller: toDate,
          ),
        ]));
  });
}
