import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/entities/enums.dart';

import '../../../domain/models/get_appointments_response.dart';

class AppointmentListController extends GetxController {
  AppointmentListController(this._appointmentListPresenter);
  final AppointmentListPresenter _appointmentListPresenter;

  var selectedButton = 'Upcoming Appointments';

  var doctorId = '';

  void onUpcomingButtonSelected() {
    selectedButton = 'Upcoming Appointments';
    update();
  }

  void onPastButtonSelected() {
    selectedButton = 'Past Appointments';
    update();
  }

  var todayDate =
      '${DateTime.now().year}- ${DateTime.now().month}- ${DateTime.now().day}';

  List<Past> upcomingAppointments = [];
  List<Past> pastAppointments = [];

  var upcomingAppointmentErrorText = '';
  var pastAppointmentErrorText = '';

  ///get appointment api call
  Future<void> getAllAppointments({
    bool isLoading = true,
  }) async {
    try {
      var response = await _appointmentListPresenter.getAllAppointments(
        isLoading: isLoading,
      );
      if (response.data != null) {
        upcomingAppointments.clear();
        pastAppointments.clear();
        if (response.data!.upcoming!.isEmpty) {
          upcomingAppointmentErrorText = 'No upcoming appointments';
        } else {
          upcomingAppointmentErrorText = '';
          upcomingAppointments = response.data!.upcoming!;
        }
        if (response.data!.past!.isEmpty) {
          pastAppointmentErrorText = 'No past appointments';
        } else {
          pastAppointmentErrorText = '';
          pastAppointments = response.data!.past!;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
    update();
  }

  Future<void> deleteAppointment({required int appointmentId}) async {
    Utility.showLoader();
    try {
      var response = await _appointmentListPresenter.deleteAppointmentUserModel(
        appointmentId: appointmentId,
      );

      if (response.data != null) {
        Utility.closeLoader();
        getAllAppointments();
      }
    } catch (e) {
      Utility.closeLoader();
      debugPrint(e.toString());
    }
    update();
  }

  Future<void> onRefreshAppointments() async => getAllAppointments(
        isLoading: false,
      );

  int rating = 0;
  var reviewController = TextEditingController();

  Future<void> addRating({
    required String doctorId,
  }) async {
    if (rating != 0) {
      var response = await _appointmentListPresenter.addReview(
        doctorId: doctorId,
        rating: rating.toString(),
        comment: reviewController.text,
        isLoading: false,
      );
      if (response.data != null) {
        doctorId = '';
        Utility.showMessage('Review added successfully', MessageType.success,
            () => Utility.closeDialog(), 'Okay');
        reviewController.clear();
        Utility.closeDialog();
        Get.back();
        getAllAppointments(isLoading: false);
      }
      Utility.closeDialog();
      update();
    }
  }

  Future<void> readNotification() async {
    var response = await _appointmentListPresenter.readNotification(
      isLoading: true,
    );
    if (response.data != null) {
      notificationCount = 0;
      update();
    }
  }

  Future<void> unreadMessages() async {
    var response = await _appointmentListPresenter.unreadMessages(
      isLoading: true,
    );
    if (response.data != null) {
      unreadMessage = response.data!;
    }
    update();
  }

  Future<void> readMessages() async {
    var response = await _appointmentListPresenter.readMessages(
      isLoadig: true,
    );
    if (response.data != null) {
      unreadMessage = 0;
      update();
    }
  }

  Future<void> getNotificationList() async {
    var response = await _appointmentListPresenter.getNotificationList(
      isLoading: false,
    );
    if (response.data != null) {
      notificationCount = response.data!.unreadCount!;
    }
    update();
  }

  Future<void> paymentRelease({
    required String bookingId,
  }) async {
    if (rating != 0) {
      FocusManager.instance.primaryFocus?.unfocus();
      var response = await _appointmentListPresenter.paymentRelease(
        bookingId: bookingId,
        isLoading: true,
      );
      if (response.data != null) {
        addRating(doctorId: doctorId);
      }
    } else {
      Utility.closeDialog();
      FocusManager.instance.primaryFocus?.unfocus();
      Utility.showInfoAndNavigateDialogue(
          'Please select one star as rating '
          'if you don\'t like the services', () {
        Utility.closeDialog();
        update();
      });
    }
  }

  @override
  void onInit() {
    getAllAppointments();
    super.onInit();
    getNotificationList();
    unreadMessages();
  }
}
