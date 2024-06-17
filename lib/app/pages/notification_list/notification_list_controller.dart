import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/models/notification_list_response.dart'
    as notify;

class NotificationListController extends GetxController {
  NotificationListController(this._notificationListPresenter);
  final NotificationListPresenter _notificationListPresenter;

  var reviewController = TextEditingController();

  List<notify.Notification> notifications = [];

  var errorText = '';

  Future<void> getNotificationList() async {
    var response = await _notificationListPresenter.getNotificationList(
      isLoading: true,
    );
    if (response.data != null) {
      notifications = response.data!.notifications!;
      notifications.isEmpty ? errorText = 'No Notifications' : errorText;
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotificationList();
  }
}
