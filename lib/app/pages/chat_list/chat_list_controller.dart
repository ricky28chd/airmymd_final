import 'package:airmymd/app/app.dart';
import '../../../domain/models/coversation_list_response.dart';

class ChatListController extends GetxController {
  ChatListController(this._chatListPresenter);
  final ChatListPresenter _chatListPresenter;

  List<Datum> conversationList = [];

  List<Datum> srverConversationList = [];

  var errorText = '';

  Future<void> getCoversationList({bool isLoading = true}) async {
    conversationList.clear();
    var response = await _chatListPresenter.getConversationList(
      isLoading: isLoading,
    );
    if (response.data != null) {
      conversationList = response.data!;
      conversationList.isNotEmpty
          ? errorText = ''
          : errorText = 'No Chat Found';

      srverConversationList = conversationList;
    }
    update();
  }

  var searchFeildController = TextEditingController();
  // This function is called whenever the text field changes
  void runFilter(String enteredKeyword) {
    List<Datum> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = srverConversationList;
    } else {
      results = srverConversationList
          .where((user) =>
              user.profile!.firstName
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              user.profile!.lastName
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    conversationList = results;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    getCoversationList();

    // try {
    //   LaravelEcho.init(
    //       token:
    //           Get.find<DeviceRepository>().getStringValue(LocalKeys.authToken));
    // } catch (e) {
    //   print('error:========================$e');
    // }
  }
}
