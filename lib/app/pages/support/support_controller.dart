import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';

class SupportController extends GetxController {
  SupportController(this._supportPresenter);
  final SupportPresenter _supportPresenter;
  var userName = '';
  var userEmail = '';
  var userPhone = '';

  var descriptionController = TextEditingController();

  var descriptionTextError = ''.obs;

  void enterDescription(String value) {
    if (value.isNotEmpty) {
      descriptionTextError.value = '';
    } else {
      descriptionTextError.value = 'Explain problem in short words';
    }
  }

  Future<void> userSupport() async {
    if (descriptionController.text.trim().isNotEmpty) {
      var response = await _supportPresenter.userSupport(
        isLoading: true,
        email: userEmail,
        phone: userPhone,
        name: userName,
        description: descriptionController.text,
      );
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      if (response.returnCode == 1) {
        descriptionController.clear();
        Utility.showMessage('Your problem is submitted successfuly',
            MessageType.success, () => Get.back(), 'Okay');
      }
    } else {
      descriptionTextError.value = 'Write your problem here';
    }
  }

  @override
  void onInit() {
    super.onInit();
    userName =
        '${Get.find<Repository>().getStringValue(LocalKeys.firstName)} ${Get.find<Repository>().getStringValue(LocalKeys.lastName)}';
    userEmail = Get.find<Repository>().getStringValue(LocalKeys.userEmail);
    userPhone = Get.find<Repository>().getStringValue(LocalKeys.userPhone);
  }
}
