// ignore_for_file: missing_required_param

import 'dart:async';
import 'dart:io';

import 'package:airmymd/app/app.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ChatController extends GetxController {
  ChatController(this._chatPresenter);
  final ChatPresenter _chatPresenter;

  var lastPage = 0;
  var pageNum = 2;
  var atTopPos = false;
  var atEndPos = true;

  var sendMessageController = TextEditingController();
  var scrollController = ScrollController();

  Future<void> sendMessage({
    bool isLoading = false,
  }) async {
    Utility.showLoader();
    //FocusManager.instance.primaryFocus?.unfocus();
    // image = eraseImage;
    // chatImage = [];
    // scrollController.animateTo(scrollController.position.maxScrollExtent,
    //     curve: Curves.easeInOut, duration: const Duration(microseconds: 200));
    if (sendMessageController.text.isNotEmpty || image != null) {
      var response = await _chatPresenter.sendMessage(
        userId: userId,
        message: sendMessageController.text,
        isLoading: isLoading,
      );
      Utility.closeLoader();
      if (response.returnCode != 0) {
        image = eraseImage;
        chatImage = [];
        sendMessageController.clear();
        getChatDetails();
      }
    }
  }

  var userId = Get.arguments['userId'];
  var doctorImage = Get.arguments['doctorImage'];
  var doctorName = Get.arguments['doctorName'];

  Future<void> getChatDetails() async {
    //messages.clear();
    var response = await _chatPresenter.getMessages(
      userId: userId,
      pageNumber: (atTopPos && lastPage <= pageNum) ? pageNum : 1,
      isLoading: false,
    );
    if (response.data != null) {
      lastPage = response.data!.lastPage!;
      for (var val in response.data!.data!.reversed.toList()) {
        if (messages
            .where((e) => e.id.toString() == val.id.toString())
            .isEmpty) {
          List<String> mediaList =
              val.media!.isEmpty ? [] : val.media!.split(",");

          if (atTopPos) {
            messages.insert(
              0,
              ChatMessage(
                  id: val.id.toString(),
                  messageContent: val.message,
                  dateTime: val.createdAt,
                  messageType:
                      val.from.toString() == userId ? 'receiver' : 'sender',
                  mediaURL: mediaList),
            );
          } else {
            messages.add(ChatMessage(
                id: val.id.toString(),
                messageContent: val.message,
                dateTime: val.createdAt,
                messageType:
                    val.from.toString() == userId ? 'receiver' : 'sender',
                mediaURL: mediaList));
          }
        }
      }
    }
    update();
    if (atEndPos) {
      Future.delayed(const Duration(milliseconds: 0), () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            curve: Curves.bounceIn, duration: const Duration(microseconds: 0));
      });
    }
    if (atTopPos) {
      pageNum = pageNum + 1;
    }
  }

  Future<void> getPreviousChatDetails() async {
    //messages.clear();
    var response = await _chatPresenter.getMessages(
      userId: userId,
      pageNumber: pageNum,
      isLoading: false,
    );
    if (response.data != null) {
      lastPage = response.data!.lastPage!;
      for (var val in response.data!.data!.reversed.toList()) {
        if (messages
            .where((e) => e.id.toString() == val.id.toString())
            .isEmpty) {
          messages.insert(
              0,
              ChatMessage(
                  id: val.id.toString(),
                  messageContent: val.message,
                  dateTime: val.createdAt,
                  messageType:
                      val.from.toString() == userId ? 'receiver' : 'sender'));
        }
      }
      pageNum = pageNum + 1;
    }
    update();
  }

  File? image;
  File? eraseImage;
  Future getImage() async {
    final image = (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
    chatImage.add(image.path);

    update();
  }

  void goBackToChatList() async {
    Get.back();
    Get.find<ChatListController>().getCoversationList(isLoading: false);
  }

  // //////pusher listen////////
  // void listenChatChannel() {
  //   LaravelEcho.instance.private('chat').listen('.message.sent', (e) {
  //     if (e is PusherEvent) {
  //       if (e.data != null) {
  //         print('data is===========:::::::${jsonDecode(e.data!)}');
  //       }
  //     }
  //   }).error((err) {
  //     print('error:::::::::::::::$err');
  //   });
  // }

  var navigateFrom = Get.arguments['NavigateFrom'];

  @override
  void onInit() {
    super.onInit();
    messages.clear();
    getChatDetails();

    // Future.delayed(const Duration(milliseconds: 100), () {
    //   scrollController.animateTo(scrollController.position.maxScrollExtent,
    //       curve: Curves.bounceIn, duration: const Duration(microseconds: 200));
    // });
    //Setup the listener.
    // scrollController.addListener(() async {
    //   if (scrollController.position.atEdge) {
    //     atTopPos = false;
    //     atEndPos = false;
    //     bool isTop = scrollController.position.pixels == 0;
    //     if (isTop) {
    //       atTopPos = true;
    //     } else {
    //       atEndPos = true;
    //     }
    //   } else {
    //     atTopPos = false;
    //     atEndPos = false;
    //   }
    // });
    //listenChatChannel();
  }
}
