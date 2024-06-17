import 'package:airmymd/app/app.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:airmymd/domain/repositories/repository.dart';

class SplashController extends GetxController {
  SplashController(this._splashPresenter);
  final SplashPresenter _splashPresenter;

  ///These variables holds the value stored in local data storage===============
  ///
  var userToken = Get.find<Repository>().getStringValue(LocalKeys.authToken);

  var userDefaultLocation =
      Get.find<Repository>().getStringValue(LocalKeys.location);

  var userDefaultLat =
      Get.find<Repository>().getStringValue(LocalKeys.latitude);

  var userFirstName =
      Get.find<Repository>().getStringValue(LocalKeys.firstName);

  ///ends here==================================================================

  void navigateToLogin() async {
    print('the user token is $userToken');
    Future.delayed(
      const Duration(seconds: 5),
      userToken.isEmpty
          ? NavigateTo.goToLoginScreen
          : userDefaultLocation.isEmpty || userDefaultLat.isEmpty
              ? NavigateTo.goToSetLocationScreen
              : userFirstName.isEmpty
                  ? NavigateTo.goToOffNamedBuildProfileScreen
                  : NavigateTo.goToHealthDashboard,
    );
  }

  Future<void> getNotificationList() async {
    var response = await _splashPresenter.getNotificationList(
      isLoading: false,
    );
    if (response.data != null) {
      notificationCount = response.data!.unreadCount!;
    }
    update();
  }

  Future<void> unreadMessages() async {
    var response = await _splashPresenter.unreadMessages(
      isLoading: false,
    );
    if (response.data != null) {
      unreadMessage = response.data!;
    }
    update();
  }

  @override
  onInit() async {
    print('on entering spalsh');
    if (userToken.isNotEmpty) {
      getNotificationList();
    }
    navigateToLogin();
    unreadMessages();

    super.onInit();
  }
}
