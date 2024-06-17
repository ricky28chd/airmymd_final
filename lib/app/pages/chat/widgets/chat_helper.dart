import 'package:flutter/cupertino.dart';

class ChatMessage {
  String? id;
  String? messageContent;
  String? messageType;
  String? dateTime;
  List<String>? mediaURL;

  ChatMessage(
      {@required this.id,
      @required this.messageContent,
      @required this.messageType,
      @required this.dateTime,
      @required this.mediaURL});
}

List<ChatMessage> messages = [];
