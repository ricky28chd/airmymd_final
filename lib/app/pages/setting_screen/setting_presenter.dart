import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/logout_response.dart';
import 'package:airmymd/domain/models/notification_list_response.dart';
import 'package:airmymd/domain/models/push_notification_setting.dart';
import 'package:airmymd/domain/models/read_messages_response.dart';
import 'package:airmymd/domain/models/read_notification_response.dart';
import 'package:airmymd/domain/models/unread_messages_response.dart';
import '../../../domain/models/email_notification_setting.dart';

class UserSettingPresenter {
  UserSettingPresenter(this.authCases);
  final AuthCases authCases;

  Future<PushNotificationSetting> pushNotificationSetting({
    required String status,
    bool isLoading = false,
  }) =>
      authCases.pushNotificationSetting(
        status: status,
        isLoading: isLoading,
      );

  Future<EmailNotificationSetting> emailNotificationSetting({
    required String status,
    bool isLoading = false,
  }) =>
      authCases.emailNotificationSetting(
        status: status,
        isLoading: isLoading,
      );

  Future<ReadNotificationResponse> readNotification(
          {bool isLoading = false}) async =>
      authCases.readNotification(
        isLoading: isLoading,
      );

  Future<ReadMessagesResponse> readMessages({
    bool isLoadig = false,
  }) async =>
      authCases.readMessages(
        isLoading: isLoadig,
      );

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

  Future<LogoutResponse> logoutUser({
    required bool isLoading,
  }) async =>
      authCases.logoutUser(
        isLoading: isLoading,
      );
}
