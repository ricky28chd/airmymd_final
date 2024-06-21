import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/show_html_data.dart';
import 'package:airmymd/device/repositories/device_repositories.dart';
import 'package:airmymd/domain/domain.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:airmymd/web_view_page.dart';
import 'package:flutter_size/flutter_size.dart';
// import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> epicLogin(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PaitentsLoginScreen()));
    // if (!await launchUrl(
    //     Uri.parse(
    //         'https://nativeapi.nextgen.com/nge/prod/nge-oauth/authorize?client_id=7a84c548-6fee-436e-9a2c-2582f8245cfb&redirect_uri=com.project.airmymd://callback&response_type=code'),
    //     mode: LaunchMode.inAppWebView)) {
    //   "==> error in launch ==>".logPrint;
    // }

    // final result = await http.get(
    //     Uri.parse(
    //       'https://nativeapi.nextgen.com/nge/prod/nge-oauth/authorize?client_id=7a84c548-6fee-436e-9a2c-2582f8245cfb&redirect_uri=com.project.airmymd://callback&response_type=code',
    //     ),
    //     headers: {'Content-Type': 'application/x-www-form-urlencoded'});

    // // final result = await http.get(Uri.parse(
    // //     'https://nativeapi.nextgen.com/nge/prod/nge-oauth/authorize/login?sessionId=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZXNzaW9uSWQiOiIwZTJiNTEyZi0yNmNiLTQ1M2MtOTY3YS1hYzM5YTY4MzQwNDAiLCJyZWRpcmVjdF91cmkiOiJjb20ucHJvamVjdC5haXJteW1kOi8vY2FsbGJhY2siLCJyZXNwb25zZV90eXBlIjoiY29kZSIsInJlc3BvbnNlX21vZGUiOiJxdWVyeSIsInNjb3BlcyI6WyJ1c2VyL0FsbGVyZ3lJbnRvbGVyYW5jZS5yZWFkIiwicGF0aWVudC9BbGxlcmd5SW50b2xlcmFuY2UucmVhZCIsIm9mZmxpbmVfYWNjZXNzIiwicGF0aWVudC9DYXJlUGxhbi5yZWFkIiwidXNlci9DYXJlUGxhbi5yZWFkIiwidXNlci9DYXJlVGVhbS5yZWFkIiwicGF0aWVudC9DYXJlVGVhbS5yZWFkIiwidXNlci9Eb2N1bWVudFJlZmVyZW5jZS5yZWFkIiwicGF0aWVudC9Eb2N1bWVudFJlZmVyZW5jZS5yZWFkIiwidXNlci9Db25kaXRpb24ucmVhZCIsInBhdGllbnQvQ29uZGl0aW9uLnJlYWQiLCJ1c2VyL1BhdGllbnQucmVhZCIsInBhdGllbnQvUGF0aWVudC5yZWFkIiwicGF0aWVudC9EaWFnbm9zdGljUmVwb3J0LnJlYWQiLCJ1c2VyL0RpYWdub3N0aWNSZXBvcnQucmVhZCIsImxhdW5jaC9lbmNvdW50ZXIiLCJmaGlyVXNlciIsInBhdGllbnQvR29hbC5yZWFkIiwidXNlci9Hb2FsLnJlYWQiLCJwYXRpZW50L0ltbXVuaXphdGlvbi5yZWFkIiwidXNlci9JbW11bml6YXRpb24ucmVhZCIsInVzZXIvRGV2aWNlLnJlYWQiLCJwYXRpZW50L0RldmljZS5yZWFkIiwicGF0aWVudC9PYnNlcnZhdGlvbi5yZWFkIiwidXNlci9PYnNlcnZhdGlvbi5yZWFkIiwidXNlci9Mb2NhdGlvbi5yZWFkIiwicGF0aWVudC9Mb2NhdGlvbi5yZWFkIiwicGF0aWVudC9NZWRpY2F0aW9uT3JkZXIucmVhZCIsInVzZXIvTWVkaWNhdGlvbk9yZGVyLnJlYWQiLCJ1c2VyL01lZGljYXRpb25SZXF1ZXN0LnJlYWQiLCJwYXRpZW50L01lZGljYXRpb25SZXF1ZXN0LnJlYWQiLCJ1c2VyL01lZGljYXRpb25TdGF0ZW1lbnQucmVhZCIsInBhdGllbnQvTWVkaWNhdGlvblN0YXRlbWVudC5yZWFkIiwidXNlci9NZWRpY2F0aW9uLnJlYWQiLCJwYXRpZW50L01lZGljYXRpb24ucmVhZCIsIm9ubGluZV9hY2Nlc3MiLCJvcGVuaWQiLCJ1c2VyL09yZ2FuaXphdGlvbi5yZWFkIiwicGF0aWVudC9Pcmdhbml6YXRpb24ucmVhZCIsImxhdW5jaC9wYXRpZW50IiwicGF0aWVudC9QcmFjdGl0aW9uZXJSb2xlLnJlYWQiLCJ1c2VyL1ByYWN0aXRpb25lclJvbGUucmVhZCIsInBhdGllbnQvUHJvY2VkdXJlLnJlYWQiLCJ1c2VyL1Byb2NlZHVyZS5yZWFkIiwidXNlci9Qcm92ZW5hbmNlLnJlYWQiLCJwYXRpZW50L1Byb3ZlbmFuY2UucmVhZCIsInVzZXIvUHJhY3RpdGlvbmVyLnJlYWQiLCJwYXRpZW50L1ByYWN0aXRpb25lci5yZWFkIiwicGF0aWVudC9SZWxhdGVkUGVyc29uLnJlYWQiLCJ1c2VyL1JlbGF0ZWRQZXJzb24ucmVhZCIsInVzZXIvRW5jb3VudGVyLnJlYWQiLCJwYXRpZW50L0VuY291bnRlci5yZWFkIl0sInN0YXRlIjpudWxsLCJjbGllbnRfaWQiOiI3YTg0YzU0OC02ZmVlLTQzNmUtOWEyYy0yNTgyZjgyNDVjZmIiLCJhdWRpZW5jZSI6bnVsbCwiZXhwIjoxNzE4ODcxMDc1LCJjbGllbnRfbmFtZSI6IkFpck15bWQiLCJhcHBfbmFtZSI6IkFpcm15bWQifQ.6duknKylGIqFfYmWIWXlW2Y07kybVKmKIfN7urr3jak'));

    // "==> result: ${result.body}==>".logPrint;

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => PaitentsLoginScreen(
    //               htmlData: result.body,
    //             )));

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
