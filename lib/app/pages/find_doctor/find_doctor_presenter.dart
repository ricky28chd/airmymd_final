import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/notification_list_response.dart';
import 'package:airmymd/domain/models/read_messages_response.dart';
import 'package:airmymd/domain/models/read_notification_response.dart';
import 'package:airmymd/domain/models/unread_messages_response.dart';

import '../../../domain/models/specialization_list_response.dart';

class FindDoctorPresenter {
  FindDoctorPresenter(this.authCases);
  final AuthCases authCases;

  Future<SpecializationListResponse> specializationUserModel({
    required String latitude,
    required String longitude,
    required bool isLoading,
  }) async =>
      authCases.specializationUserModel(
        latitude: latitude,
        longitude: longitude,
        isLoading: isLoading,
      );

  Future<ReadNotificationResponse> readNotification(
          {bool isLoading = false}) async =>
      authCases.readNotification(
        isLoading: isLoading,
      );

  Future<UnreadMessagesResponse> unreadMessages({
    required bool isLoading,
  }) async =>
      authCases.unreadMessages(
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
}
