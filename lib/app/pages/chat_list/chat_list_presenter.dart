import 'package:airmymd/domain/domain.dart';

import '../../../domain/models/coversation_list_response.dart';

class ChatListPresenter {
  ChatListPresenter(this.authCases);
  final AuthCases authCases;

  Future<GetConversationListResponse> getConversationList({
    bool isLoading = false,
  }) async =>
      await authCases.getConversationList(
        isLoading: isLoading,
      );
}
