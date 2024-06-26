// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';
import 'package:airmymd/app/app.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../domain/entities/enums.dart';
import '../../domain/models/response_model.dart';

///This class can call all the APIs and handle error status code.
class ApiWrapper {
  ///Development url
  static String devurl = 'https://dev.airmymd.com/api/';

  ///live url
  static String liveurl = 'https://dev.airmymd.com/api/';
  final String baseUrl = devurl;

  ///Method to make call all types of request like get,post,put,delete.
  Future<ResponseModel> makeRequest(
    String url,
    Request request,
    dynamic data,
    bool isLoading,
    Map<String, String> headers, {
    String? field,
    String? filePath,
    List<String>? fileGroupPath,
    List<File>? noteImageFiles,
  }) async {
    ///Checking network available or not...
    if (await Utility.isNetworkAvailable()) {
      switch (request) {
        ///Method to call get type request.
        case Request.get:
          {
            print(
                'headers -=-=-=----=-=-=-=--=-=-=--=-=-=-=--=--=-=-==-- $headers');
            var uri = baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = await http
                  .get(Uri.parse(uri), headers: headers)
                  .timeout(const Duration(seconds: 30));
              Utility.closeLoader();
              Utility.printLog(uri);
              print(response.body);
              return returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"returnMessage":"Request Timed Out"}',
                  hasError: true);
            }
          }

        ///Method to call post type request.
        case Request.post:
          {
            var uri = baseUrl + url;

            try {
              if (isLoading) Utility.showLoader();
              print('this is data===================>>>>>>$data');
              Utility.printILog(uri);
              final response = await http
                  .post(Uri.parse(uri),
                      body: json.encode(data), headers: headers)
                  .timeout(const Duration(seconds: 30));
              Utility.closeDialog();

              print('this is body===================>>>>>>${response.body}');
              return returnResponse(response);
            } on TimeoutException catch (e) {
              print('error is =====>>>>>>${e.toString()}');
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"returnMessage":"Request timed out"}',
                  hasError: true);
            }
          }

        ///Method to call put type request.
        case Request.put:
          {
            var uri = baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = await http
                  .post(Uri.parse(uri), headers: headers)
                  .timeout(const Duration(seconds: 30));
              Utility.closeLoader();
              Utility.printLog(uri);
              print(response.body);
              return returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"returnMessage":"Request Timed Out"}',
                  hasError: true);
            }
          }

        ///Method to call delete type request.
        case Request.delete:
          {
            var uri = baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = await http
                  .post(Uri.parse(uri), headers: headers)
                  .timeout(const Duration(seconds: 30));
              Utility.closeLoader();
              Utility.printLog(uri);
              return returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"returnMessage":"Request Timed Out"}',
                  hasError: true);
            }
          }

        case Request.multiPartPost:
          {
            var uri = baseUrl + url;
            if (isLoading) Utility.showLoader();
            var name = File(filePath.toString());
            List<int> size = [];
            try {
              var request = http.MultipartRequest('POST', Uri.parse(uri))
                ..headers.addAll(headers)
                ..fields.addAll(data)
                ..files.add(http.MultipartFile(
                    field!,
                    File(filePath!).readAsBytes().asStream(),
                    File(filePath).lengthSync(),
                    filename: filePath.split("/").last));

              var streamedResponse = await request.send();
              Utility.closeDialog();
              var response = await http.Response.fromStream(streamedResponse);
              print('This is multipart response${response.body}');

              // response.stream.transform(utf8.decoder).listen((value) {
              //   print(value);
              //
              // });
              print(
                  'This is multipart streamed response${streamedResponse.toString()}');
              return returnResponse(response);
            } on TimeoutException catch (_) {
              return ResponseModel(
                  data: '{"returnMessage":"Request timed out"}',
                  hasError: true);
            }
          }

        case Request.multipartGroup:
          {
            var uri = baseUrl + url;
            if (isLoading) Utility.showLoader();
            var name = File(filePath.toString());
            List<int> size = [];
            try {
              var request = http.MultipartRequest('POST', Uri.parse(uri))
                ..headers.addAll(headers)
                ..fields.addAll(data);
              print(
                  'http exception is =============================== ${request.files}');
              print(
                  'group path================================================$fileGroupPath');
              List<http.MultipartFile> newList = [];

              for (var img in fileGroupPath!) {
                if (img != "") {
                  var multipartFile = await http.MultipartFile.fromPath(
                    field!,
                    File(img).path,
                    filename: img.split('/').last,
                  );
                  newList.add(multipartFile);
                }
              }

              print(
                  'field=====================================================$field');

              print(
                  'data =====================================================$data');
              print(
                  'new list =================================================$newList');
              request.files.addAll(newList);
              var streamedResponse = await request.send();
              Utility.closeDialog();
              var response = await http.Response.fromStream(streamedResponse);
              return returnResponse(response);
            } on TimeoutException catch (e) {
              print(e);
              return ResponseModel(
                  data: '{"returnMessage":"Request timed out"}',
                  hasError: true);
            } catch (e) {
              print(e);
              return ResponseModel(
                  data: '{"returnMessage":"Request timed out"}',
                  hasError: true);
            }
          }
      }
    }

    /// If there is no network available then instead of print can show the no internet widget too
    else {
      Get.dialog(Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logo,
                scale: 5,
              ),
              AppSizeBox.height_10,
              const Text(
                'Ooops!',
                style: TextStyles.greyPlain22,
              ),
              AppSizeBox.height_5,
              const Text(
                'No internet connection found\n Check your connection',
                textAlign: TextAlign.center,
                style: TextStyles.greyMedium14,
              ),
            ],
          ),
        ),
      ));
      return ResponseModel(
          data:
              '{"returnMessage":"No internet, please enable mobile data or wi-fi in your phone settings and try again"}',
          hasError: true,
          errorCode: 1000);
    }
  }

  /// Method to return the API response based upon the status code of the server
  Future<ResponseModel> returnResponse(http.Response response) async {
    if (response.statusCode == 200) {
      switch (jsonDecode(response.body)['returnCode']) {
        case 0:
          return ResponseModel(
              data: response.body,
              hasError: true,
              errorCode: response.statusCode);
        case 1:
          return ResponseModel(
            data: response.body,
            hasError: false,
            errorCode: response.statusCode,
          );
        case 5:
          return ResponseModel(
            data: response.body,
            hasError: true,
            errorCode: response.statusCode,
          );
        default:
          return ResponseModel(
              data: response.body,
              hasError: true,
              errorCode: response.statusCode);
      }
    } else {
      await Get.dialog(
        CupertinoAlertDialog(
          title: const Text('Server Error'),
          content: const Text(
            'Something went wrong, please try again after some time',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: Get.back,
              isDefaultAction: true,
              child: Text(
                'okay'.tr,
              ),
            ),
          ],
        ),
      );
      // Get.defaultDialog(
      //     title: 'Server Error',
      //     titleStyle: TextStyles.darkBlack16,
      //     content: const Text(
      //       'Something went wrong, please try again after some time',
      //       textAlign: TextAlign.center,
      //       style: TextStyles.plainDark15,
      //     ),
      //     cancel: GestureDetector(
      //       onTap: () {
      //         Utility.closeDialog();
      //         Get.back();
      //       },
      //       child: const Text(
      //         'Cancel',
      //         style: TextStyles.darkBlack15,
      //       ),
      //     ),
      //     onCancel: () {
      //       Utility.closeDialog();
      //       Get.back();
      //     });
      return ResponseModel(
          data: response.body, hasError: true, errorCode: response.statusCode);
    }
  }
}

// /// Method to return the API response based upon the status code of the server
// ResponseModel returnResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//     case 201:
//     case 202:
//     case 203:
//     case 205:
//     case 208:
//       return ResponseModel(
//           data: response.body,
//           hasError: false,
//           errorCode: response.statusCode);
//     case 400:
//     case 401:
//       return ResponseModel(
//         data: response.body,
//         hasError: true,
//         errorCode: response.statusCode,
//       );
//     case 406:
//       if (response.statusCode == 406) {
//         // connect
//       }
//       return ResponseModel(
//         data: response.body,
//         hasError: true,
//         errorCode: response.statusCode,
//       );
//     case 409:
//     case 500:
//     case 522:
//       return ResponseModel(
//           data: response.body,
//           hasError: true,
//           errorCode: response.statusCode);
//     default:
//       return ResponseModel(
//           data: response.body,
//           hasError: true,
//           errorCode: response.statusCode);
//   }
// }
//
