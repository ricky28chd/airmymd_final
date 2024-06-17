import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/device/repositories/device_repositories.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;

class UserSettingController extends GetxController {
  UserSettingController(this._userSettingPresenter);
  final UserSettingPresenter _userSettingPresenter;
  Future<void> logoutButtonClicked(BuildContext context) async {
    await logoutUser();
    Get.find<DeviceRepository>().clearBox();
    Get.find<DeviceRepository>().deleteAllSecuredValues();
    //  NavigateTo.goToLoginScreen();
  }
  /////////

  var pushNotification = false;

  var pushNotificationStatus = '';

  getPushNotification() {
    pushNotificationStatus =
        Get.find<Repository>().getStringValue(LocalKeys.pushNotification);
    update();
  }

  Future<void> pushNotificationStatusChange() async {
    await getPushNotification();
    var response = await _userSettingPresenter.pushNotificationSetting(
      status: pushNotificationStatus == "1" ? "0" : "1",
      isLoading: false,
    );

    if (response.data != null) {
      // Utility.showMessage(
      //   'Notification Status has been changed',
      //   MessageType.success,
      //   () => Utility.closeDialog(),
      //   'Okay',
      // );
    }
    update();
  }

  var emailNotification = false;

  var emailNotificationStatus = '';

  getEmailNotification() {
    emailNotificationStatus =
        Get.find<Repository>().getStringValue(LocalKeys.emailNotification);
    update();
  }

  Future<void> emailNotificationStatusChange() async {
    await getEmailNotification();
    var response = await _userSettingPresenter.emailNotificationSetting(
      status: emailNotificationStatus == '1' ? "0" : "1",
      isLoading: false,
    );

    if (response.data != null) {
      Utility.closeDialog();
      Utility.closeLoader();
      // Utility.showMessage(
      //   'Email Notification Status has been changed',
      //   MessageType.success,
      //   () => Utility.closeDialog(),
      //   'Okay',
      // );
    }
    update();
  }

  Future<void> readNotification() async {
    var response = await _userSettingPresenter.readNotification(
      isLoading: true,
    );
    if (response.data != null) {
      notificationCount = 0;
      update();
    }
  }

  Future<void> unreadMessages({bool isLoading = true}) async {
    var response = await _userSettingPresenter.unreadMessages(
      isLoading: isLoading,
    );
    if (response.data != null) {
      unreadMessage = response.data!;
    }
    update();
  }

  Future<void> readMessages() async {
    var response = await _userSettingPresenter.readMessages(
      isLoadig: true,
    );
    if (response.data != null) {
      unreadMessage = 0;
      update();
    }
  }

  // navigateToUrl({
  //   required String url,
  //   bool inApp = false,
  // }) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: inApp,
  //       forceWebView: true,
  //       enableJavaScript: true,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> getNotificationList() async {
    var response = await _userSettingPresenter.getNotificationList(
      isLoading: false,
    );
    if (response.data != null) {
      notificationCount = response.data!.unreadCount!;
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPushNotification();
    if (pushNotificationStatus == "1") {
      pushNotification = true;
    } else {
      pushNotification = false;
    }
    getEmailNotification();
    if (emailNotificationStatus == "1") {
      emailNotification = true;
    } else {
      emailNotification = false;
    }
    getNotificationList();
    unreadMessages(isLoading: false);
    update();
  }

  /// Epic credentials//
  final String clientId = '7a84c548-6fee-436e-9a2c-2582f8245cfb';
  final String redirectUri = 'com.project.airmymd://callback';
  final String discoveryUrl =
      'https://idp-prod.prod.ngo.nextgenaws.net/auth/realms/nextgen/protocol/openid-connect/auth/';

  Future<void> epicLogin() async {
    /*
    const FlutterAppAuth appAuth = FlutterAppAuth();

    try {
      final result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUri,
          discoveryUrl: discoveryUrl,
          scopes: ['openid', 'profile', 'email', 'offline_access', 'api'],
        ),
      );

      if (result!.accessToken!.isNotEmpty) {
        var params = {
          "grant_type": "authorization_code",
          "redirect_uri": redirectUri,
          "code": result.accessToken,
          "client_id": clientId,
          "state": "1234"
        };

        // Make POST request to get access token
        var response = await http.post(
            Uri.parse(
                "https://fhir.epic.com/interconnect-fhir-oauth/oauth2/token"),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",

              // "Accept-Type": "application/json"
            },
            body: params
            //body: json.encode(params),
            );

        print("\n----> ${response.body} ---->\n");

        if (response.statusCode == 200) {
          // Parse response data
          var data = response.body;
          print('data is ===>>>> $data');
        } else {
          print("Error: ${response.statusCode}");
        }
      }
      print('access token --===>>> ${result.accessToken}');
    } catch (e) {
      print('exception for epic is ====>>>> $e');
    }*/
  }

  Future<void> logoutUser() async {
    var response = await _userSettingPresenter.logoutUser(
      isLoading: true,
    );
    print('this is no use ${response.returnMessage}');
  }
}
