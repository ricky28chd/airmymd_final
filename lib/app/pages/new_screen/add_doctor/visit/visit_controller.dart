import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:airmymd/app/app.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import '../../../../../domain/repositories/localstorage_keys.dart';
import '../../../../../domain/repositories/repository.dart';

class VisitController extends GetxController {
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

    {
      final List<String> inputList = input.split(',');
      for (var value in inputList) {
        if (!regex.hasMatch(value) && !regex.hasMatch(value)) {
          return 'Invalid format. Enter valid email or phone number(s) separated by commas.';
        }
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

  // List<Calendar> calendars = [];
  var selectedButton = 'Upcoming Appointments';
  //final DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();

  var doctorId = '';

  Future<void> initializeApp() async {
    // await requestCalendarPermission();

    update();
  }

  void onUpcomingButtonSelected() {
    selectedButton = 'Upcoming Appointments';
    update();
  }

  void onPastButtonSelected() {
    selectedButton = 'Past Appointments';
    update();
  }

  var storeData;
  bool isLoading = true;
  getData() async {
    print(
        'id =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${Get.find<Repository>().getStringValue('specialistId')}');
    try {
      var request = await http.get(
        Uri.parse(
            'https://dev.airmymd.com/api/speciality-visitors/${Get.find<Repository>().getStringValue('specialistId')}'),
        headers: {
          'Authorization':
              'Bearer ${Get.find<Repository>().getStringValue(LocalKeys.authToken)}',
          "Content-Type": "application/json",
        },
      );
      var response = jsonDecode(request.body);
      print(response);
      storeData = response['data'];

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Utility.showDialogue(e.toString());
    }
  }

  Future<void> createCalendarAndAddEvent(
      context, date, title, note, email, url) async {
    try {
      final status = await Permission.calendar.request();
      print('the status is $status');
      if (status.isGranted) {
        final Event event = Event(
          title: title,
          description: note,
          location: 'Current Location',
          startDate: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS')
              .format(DateTime.parse(date))),
          endDate: DateTime.parse(date).add(const Duration(hours: 1)),
          iosParams: IOSParams(
            url: url,
            reminder: const Duration(
                hours:
                    1), // on iOS, you can set alarm notification after your event.
          ),
          androidParams: const AndroidParams(
              // on Android, you can add invite emails to your event.
              ),
        );

        var eve = Add2Calendar.addEvent2Cal(event).obs;
      } else if (status.isPermanentlyDenied) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text(
                'Please grant calendar permission to use this feature.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  openAppSettings(); // This opens the app settings page
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print("Error creating calendar and adding event: $e");
      Utility.showDialogue(e.toString());
    }
  }

  @override
  void onInit() async {
    getData();
    initializeApp();

    // TODO: implement onInit
    super.onInit();
  }
}
