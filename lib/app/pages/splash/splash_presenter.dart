import 'package:airmymd/domain/models/unread_messages_response.dart';

import '../../../domain/models/notification_list_response.dart';
import '../../../domain/usecases/authcases.dart';

class SplashPresenter {
  SplashPresenter(this.authCases);
  final AuthCases authCases;

  ///get authToken from local.
  Future<String?> getSecureValue(String key) => authCases.getSecureValue(key);

  Future<GetNotificationList> getNotificationList({
    bool isLoading = false,
  }) async =>
      authCases.getNotificationList(
        isLoading: isLoading,
      );

  Future<UnreadMessagesResponse> unreadMessages({
    required bool isLoading,
  }) async =>
      authCases.unreadMessages(
        isLoading: isLoading,
      );
}
