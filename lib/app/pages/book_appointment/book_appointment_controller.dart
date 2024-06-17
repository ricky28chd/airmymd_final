// ignore_for_file: depend_on_referenced_packages

import 'package:airmymd/app/app.dart';
import 'package:airmymd/data/data.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/get_user_profile_response.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:intl/intl.dart';

class BookAppointmentController extends GetxController {
  BookAppointmentController(this._bookAppointmentPresenter);
  final BookAppointmentPresenter _bookAppointmentPresenter;

  ///localVariables==============================================local variables

  /// Users list --========

  List<ChildUsers> childUsers = [];

  /// Selected child id====
  String? selectedChildId;

  /// Update select child dropdown
  void updateChildId(value) {
    selectedChildId = value;

    update();
  }

  ///Variable carries the doctor id coming from doctor detail page.
  var doctorId = Get.arguments['doctorId'] ?? 0;

  ///Variable carries the fees coming from doctor detail page.
  var doctorFees = Get.arguments['fees'] ?? '';

  ///Variable carries the reason for user want to make appointment
  var reasonController = TextEditingController();

  /// User type ======
  UserType? userType;

  ///Calender===========================================================Calender

  ///variable will store current day.
  var focusDay = DateTime.now();

  ///variable will store selected day by user.
  var selectedDay = DateTime.now();

  ///Method to update the changes when user select any date.
  Future<void> selectNewDate(DateTime selectDate, DateTime focusedDay) async {
    selectedSlot.clear();
    focusDay = focusedDay;
    selectedDay = selectDate;
    getTimeSlot();
    update();
  }

  /// Update user type radio button
  Future<void> updateUserType(UserType? value) async {
    userType = value;
    if (userType == UserType.Family) {
      var response =
          await _bookAppointmentPresenter.getUserProfile(isLoading: true);
      if (response.returnCode == 1) {
        childUsers = response.childUsers;
      }
    }
    update();
  }

  ///Available Slots=============================================Available Slots

  ///Variable will carry selected index by the user.
  var selectedSlot = [];

  ///Method to clear and add index so the buttons can toggle.
  void selectSlot(index) {
    if (selectedSlot.isNotEmpty) {
      selectedSlot.clear();
      selectedSlot.add(index);
    } else {
      selectedSlot.add(index);
    }
    update();
  }

  List<String> timeSlots = [];

  var timeSlotError = '';

  Future<void> getTimeSlot() async {
    var apiSentDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    var response = await _bookAppointmentPresenter.getTimeSlot(
      doctorId: doctorId.toString(),
      bookingDate: apiSentDate,
      isLoading: true,
    );
    if (response.data != null) {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      DateFormat df = DateFormat("yyyy-MM-dd h:mm a");

      if (response.data!.slotStartTime!.isNotEmpty) {
        timeSlots.clear();
        for (var i = 0; i < response.data!.slotStartTime!.length; i++) {
          String serverTimeStr =
              "$formattedDate ${response.data!.slotStartTime![i]}";

          DateTime serverTime = df.parse(serverTimeStr);
          if (formatter.format(selectedDay) != formatter.format(now)) {
            timeSlotError = '';
            timeSlots.add(response.data!.slotStartTime![i]);
          } else if (serverTime.isAfter(DateTime.now())) {
            timeSlotError = '';
            timeSlots.add(response.data!.slotStartTime![i]);
            // timeSlots = response.data!.slotStartTime!;
          } else {
            timeSlotError =
                'All slots are booked for the day, Please choose another date';
          }
        }
      } else {
        timeSlots.clear();
        timeSlotError =
            'Slots are not available for this date please \nchoose another one';
      }

      update();
    }
  }

  void onContinueButtonClicked() {
    if (selectedSlot.isNotEmpty && userType != null) {
      if (userType == UserType.Family) {
        Get.find<Repository>().saveValue(LocalKeys.childId, selectedChildId);
        if (selectedChildId != null) {
          NavigateTo.goToPaymentScreen(
            doctorId: doctorId,
            bookingDate: DateFormat("yyyy-MM-dd").format(selectedDay),
            bookingTime: selectedSlot.join('').toString(),
            reason: reasonController.text,
            fees: doctorFees ?? '',
          );
        } else {
          Utility.showMessage(
            'Please select Family member',
            MessageType.information,
            () => Utility.closeLoader(),
            'Okay',
          );
        }
      } else {
        Get.find<Repository>().saveValue(LocalKeys.childId, '');
        NavigateTo.goToPaymentScreen(
          doctorId: doctorId,
          bookingDate: DateFormat("yyyy-MM-dd").format(selectedDay),
          bookingTime: selectedSlot.join('').toString(),
          reason: reasonController.text,
          fees: doctorFees ?? '',
        );
      }
    } else if (selectedSlot.isEmpty) {
      Utility.showMessage(
        'Please select time slot first',
        MessageType.information,
        () => Utility.closeLoader(),
        'Okay',
      );
    } else if (userType == null) {
      Utility.showMessage(
        'Please select User first',
        MessageType.information,
        () => Utility.closeLoader(),
        'Okay',
      );
    }
  }

  @override
  void onInit() {
    getTimeSlot();
    print('user type is =-=--=-=-=-=-=-=-=-=');
    super.onInit();
  }
}
