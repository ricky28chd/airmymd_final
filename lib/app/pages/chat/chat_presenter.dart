import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/models/send_message_response.dart';
import 'package:airmymd/domain/models/user_conversation_response.dart';

class ChatPresenter {
  ChatPresenter(this.authCases);
  final AuthCases authCases;

  Future<GetUserConversationResponse> getMessages({
    required String userId,
    bool isLoading = false,
    required int pageNumber,
  }) async =>
      await authCases.getMessages(
        userId: userId,
        pageNumber: pageNumber,
        isLoading: isLoading,
      );

  Future<SendMessageResponse> sendMessage({
    required String userId,
    required String message,
    bool isLoading = false,
  }) async =>
      await authCases.sendMessage(
        userId: userId,
        message: message,
        isLoading: isLoading,
      );
}
