import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/notification_list_response.dart';
import 'package:airmymd/domain/models/read_messages_response.dart';
import 'package:airmymd/domain/models/read_notification_response.dart';
import 'package:airmymd/domain/models/unread_messages_response.dart';

import '../../../domain/models/delete_insurance_card_response.dart';
import '../../../domain/models/get_insurance_list_response.dart';

class InsuranceListPresenter {
  InsuranceListPresenter(this.authCases);
  final AuthCases authCases;

  Future<GetInsuranceResponse> getInsuranceList(
          {bool isLoading = false}) async =>
      authCases.getInsuranceList(
        isLoading: isLoading,
      );

  Future<DeleteInsuranceCard> deleteInsuranceCard({
    required String insuranceId,
    bool isLoading = false,
  }) async =>
      authCases.deleteInsuranceCard(
        insuranceId: insuranceId,
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
}
