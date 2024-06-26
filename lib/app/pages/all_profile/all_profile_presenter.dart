import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/get_user_profile_response.dart';
import 'package:airmymd/domain/models/notification_list_response.dart';
import 'package:airmymd/domain/models/parent_control_response.dart';
import 'package:airmymd/domain/models/read_messages_response.dart';
import 'package:airmymd/domain/models/read_notification_response.dart';
import 'package:airmymd/domain/models/unread_messages_response.dart';

class AllProfilePresenter {
  AllProfilePresenter(this.authCases);
  final AuthCases authCases;

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

  Future<GetUserProfileResponse> getUserProfile({
    required bool isLoading,
  }) =>
      authCases.getUserProfile(isLoading: isLoading);

  Future<ParentControlResponse> parentControl({
    required bool isLoading,
    required String userId,
  }) =>
      authCases.parentControl(
        isLoading: isLoading,
        userId: userId,
      );
}
