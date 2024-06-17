import 'package:airmymd/domain/domain.dart';
import '../../../domain/models/notification_list_response.dart';

class NotificationListPresenter {
  NotificationListPresenter(this.authCases);
  final AuthCases authCases;

  Future<GetNotificationList> getNotificationList({
    bool isLoading = false,
  }) async =>
      authCases.getNotificationList(
        isLoading: isLoading,
      );

  
}
