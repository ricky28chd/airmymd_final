import 'dart:convert';

import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/add_visit/add_visit_controller.dart';
import 'package:airmymd/domain/models/location_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' show Location;
import 'package:geocoding/geocoding.dart'
    show GeocodingPlatform, Placemark, locationFromAddress;
import 'dart:async';
import 'dart:io';

import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:photo_view/photo_view.dart';

import '../../domain/entities/enums.dart';
import '../../domain/models/response_model.dart';
import '../widgets/no_internet_widget.dart';

abstract class Utility {
  static void printDLog(String message) {
    Logger().d('${PageConstants.appName}: $message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printILog(dynamic message) {
    Logger().i('${PageConstants.appName}: $message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printLog(dynamic message) {
    Logger().log(Level.info, message);
  }

  /// Print error log.
  ///
  /// [message] : The message which needed to be print.
  static void printELog(String message) {
    Logger().e('${PageConstants.appName}: $message');
  }

  ///Method will return string if any error occurs.
  ///
  /// for at least one numeric digit.
  /// for at least one capital letter.
  /// for at least one special character and at least 6 digits.
  /// /// return [List<bool>] for each case.
  /// Validation logic
  /// r'^
  ///   (?=.*[A-Z])             // should contain at least one upper case
  ///   (?=.*?[0-9])            // should contain at least one digit
  ///  (?=.*?[!@#\$&*~]).{8,}   // should contain at least one Special character
  /// $
  /// This password method is only for reference, it will not gonna use in this
  /// project as no password required in whole project.
  static String? validatePassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        if (value.contains(RegExp(r'[A-Z]'))) {
          if (value.contains(RegExp(r'[0-9]'))) {
            if (value.length < 6) {
              return 'ShouldBe6Characters'.tr;
            } else {
              return null;
            }
          } else {
            return 'ShouldHaveOneDigit'.tr;
          }
        } else {
          return 'ShouldHaveOneUppercaseLetter'.tr;
        }
      } else {
        return 'shouldHaveOneSpecialCharacter'.tr;
      }
    } else {
      return 'PasswordRequired'.tr;
    }
  }

  /// Returns true if the internet connection is available.
  static Future<bool> isNetworkAvailable() async =>
      await InternetConnectionChecker().hasConnection;

  ///Print the details of the response.
  static void printResponseDetails(Response? response) {
    if (response != null) {
      var isOkay = response.isOk;
      var statusCode = response.statusCode;
      var method = response.request?.method ?? '';
      var path = response.request?.url.path ?? '';
      var query = response.request?.url.queryParameters ?? '';
      if (isOkay) {
        printLog(
            'Path:$path, Method:$method, Status Text:$statusCode, Query:$query');
      } else {
        printELog(
            'Path:$path, Method:$method, Status Text:$statusCode, Query:$query');
      }
    }
  }

  /// returns the date time in particular given format
  static String getWeekDayMonthNumYear(DateTime dateTime) =>
      DateFormat.yMMMMEEEEd().format(dateTime);

  /// get formatted [DateTime] eg. 12-01-2021
  static String getDayMonthYear(DateTime dateTime) =>
      '${getOnlyDate(dateTime)}-${DateFormat('MM').format(dateTime)}-${DateFormat.y().format(dateTime)}';

  /// get formatted [DateTime] eg. 12
  static String getOnlyDate(DateTime dateTime) =>
      DateFormat('dd').format(dateTime);

  /// get formatted [DateTime] eg. 12 Sep
  static String getDateAndMonth(DateTime dateTime) =>
      DateFormat('dd MMM').format(dateTime);

  /// get formatted [DateTime]
  static String getWeekDay(DateTime dateTime) =>
      DateFormat.EEEE().format(dateTime);

  ///Show Loader.
  static void showLoader({color = Colors.grey}) async {
    await Get.dialog(
        Center(
          child: CupertinoActivityIndicator(
            radius: 20,
            color: color,
          ),
        ),
        barrierColor: Colors.transparent,
        barrierDismissible: false);
  }

  ///Close Loader.
  static void closeLoader() {
    closeDialog();
  }

  ///Show info Dialogue. In which we can show a normal message like any
  ///information regarding anything.
  static void showDialogue(String message) async {
    return await Get.dialog(CupertinoAlertDialog(
      title: const Text('Info'),
      content: Text(message),
      actions: [TextButton(onPressed: Get.back, child: const Text('Okay'))],
    ));
  }

  ///Show info Dialogue. In which we can show a normal message like any
  ///information regarding anything.
  static void showInfoAndNavigateDialogue(
      String message, VoidCallback onPressed) async {
    await Get.dialog(CupertinoAlertDialog(
      title: const Text('Info'),
      content: Text(message),
      actions: [TextButton(onPressed: onPressed, child: const Text('Okay'))],
    ));
  }

  ///Show dialogue box as alert box, in which user have two choices yes or no
  ///for eg:-Are you sure you want to quit, Options are yes or no.
  static void showAlertDialogue(
      String? message, String? title, Function()? onPress) async {
    await Get.dialog(CupertinoAlertDialog(
      title: Text('$title'),
      content: Text('$message'),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPress,
            child: const Text('Yes')),
        const CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: closeDialog,
          child: Text('No'),
        )
      ],
    ));
  }

  /// Dialog to ask user to enable a service which is required to perform
  /// some operation.
  ///
  /// [title] : The title of the service required.
  /// [message] : The message of the service required.
  static void askToEnableServiceFromSetting(
    String title,
    String message, {
    required Function()? onPressed,
  }) {
    Get.dialog(CupertinoAlertDialog(
      title: Text(
        title,
        style: TextStyles.darkBlack20,
      ),
      content: Text(
        message,
        style: TextStyles.darkMedium14,
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: onPressed,
          isDefaultAction: true,
          child: const Text(
            "Yes",
            style: TextStyles.extraBoldBlue15,
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Get.back<void>();
          },
          child: const Text(
            "No",
            style: TextStyles.extraBoldBlue15,
          ),
        )
      ],
    ));
  }

  ///Close any open dialogue
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  ///Close any open snack bar.
  static void closeSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back<void>();
    }
  }

  ///show no internet dialogue if internet is not available.
  static Future<void> showNoInternetDialogue() async {
    await Get.dialog<void>(const NoInternetWidget(), barrierDismissible: false);
  }

  ///Show a floating snack Bar in which, Can show any [message] .
  ///
  /// [message]:message you need to show to the user.
  ///
  ///[messageType]:Type of the message for different background color.
  ///
  ///[onTap]:An event for onTap.
  ///
  ///[actionName]:The name for the action.
  static void showMessage(String? message, MessageType messageType,
      Function()? onTap, String actionName) {
    if (message == null || message.isEmpty) return;
    closeDialog();
    closeLoader();
    closeSnackBar();
    var backgroundColor = Colors.black;
    switch (messageType) {
      case MessageType.error:
        backgroundColor = Colors.red;
        break;
      case MessageType.information:
        backgroundColor = Colors.black.withOpacity(0.7);
        break;
      case MessageType.success:
        backgroundColor = AppColors.primaryColor;
        break;
      default:
        backgroundColor = Colors.black;
        break;
    }
    Future.delayed(const Duration(seconds: 0), () {
      Get.rawSnackbar(
          messageText: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          mainButton: TextButton(
            onPressed: onTap ?? Get.back,
            child:
                Text(actionName, style: const TextStyle(color: Colors.white)),
          ),
          backgroundColor: backgroundColor,
          margin: const EdgeInsets.all(15.0),
          borderRadius: 15,
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  ///Get current location and update the view.
  static Future<LocationDataLocal> getCurrentLocation() async {
    Placemark? locationDetails;
    double lat = 0.0;
    double long = 0.0;
    LocationPermission permission;
    var status = await Permission.location.serviceStatus.isEnabled;
    permission = await Geolocator.checkPermission();
    if (!status) {
      Utility.closeDialog();
    }

    print('i ma at stage 1=======================');
    if (permission == LocationPermission.denied) {
      print('i ma at stage 2=======================');
      Utility.closeLoader();
      Utility.askToEnableServiceFromSetting('Permission',
          'To see the correct location details, you have to give permission for location',
          onPressed: () {
        openAppSettings();
      });
    } else {
      print('i ma at stage 3=======================');
      var currentLocation = Location();
      var location = await currentLocation.getLocation();
      printLog('Lat:${location.latitude},Lang:${location.longitude}');
      lat = location.latitude ?? 0.0;
      long = location.longitude ?? 0.0;
      locationDetails = await getAddressThroughLatLng(lat, long);
    }

    return getLocationData(locationDetails, lat, long);
  }

  /// Get current location in string.
  static Future<LocationDataLocal> getCurrentLocationAndSave() async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    var locationDetails =
        await getAddressThroughLatLng(position.latitude, position.longitude);
    return getLocationData(
      locationDetails,
      position.latitude,
      position.longitude,
    );
  }

  /// Get current lat long of the device.
  static Future<Position> getCurrentLatLng() async =>
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  ///Get the location name by giving the lat and long.
  ///
  /// [latitude]:latitude of the location.
  /// [longitude]:longitude of the location.
  static Future<Placemark?> getAddressThroughLatLng(
      double? latitude, double? longitude) async {
    if (latitude != null && longitude != null) {
      var addresses = await GeocodingPlatform.instance!
          .placemarkFromCoordinates(latitude, longitude);
      print('addresses====+===============>>>>>$addresses');
      return addresses[0];
    }
    return null;
  }

  /// Get all location details from the address object.
  ///
  /// [locationDetails] : the location details got from geocoder.
  static LocationDataLocal getLocationData(
    Placemark? locationDetails,
    double lat,
    double long,
  ) =>
      LocationDataLocal(
        placeName: locationDetails?.name == 'Unnamed Road'
            ? locationDetails?.subLocality ?? ''
            : locationDetails?.name ?? '',
        addressLine1: locationDetails?.subLocality ?? '',
        addressLine2: locationDetails?.administrativeArea ?? '',
        area: locationDetails?.locality == ''
            ? locationDetails?.subLocality ?? ''
            : locationDetails?.locality ?? '',
        city: locationDetails?.subAdministrativeArea ?? '',
        postalCode: locationDetails?.postalCode ?? '',
        country: locationDetails?.country ?? '',
        latitude: lat,
        longitude: long,
      );

  static String getFormatedDate(String date) {
    var date = DateTime.parse('2018-04-10T04:00:00.000Z');
    return Utility.getDayMonthYear(date);
  }

  /// Show error dialog from response model, eg:- if response is not 200 and it has any error then
  /// this dialogue box show the error message from that response model.
  static void showInfoDialog(ResponseModel data,
      [bool isSuccess = false]) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text(isSuccess ? 'SUCCESS' : 'Error'),
        content: Text(
          jsonDecode(data.data)['returnMessage'],
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
  }
}

// Create a class to handle the shared VideoPlayerController

// Modify VideoWidget to accept the VideoControllerManager

class MediaPageViewLocalAndNetwork extends StatefulWidget {
  final List mediFiles;
  final bool? value;
  final VoidCallback? voidCallback;
  final bool enable;
  const MediaPageViewLocalAndNetwork(
      {super.key,
      required this.mediFiles,
      this.enable = true,
      this.value = true,
      this.voidCallback});
  @override
  _MediaPageViewLocalAndNetworkState createState() =>
      _MediaPageViewLocalAndNetworkState();
}

class _MediaPageViewLocalAndNetworkState
    extends State<MediaPageViewLocalAndNetwork> {
  PageController _pageController = PageController();
  int currentPage = 0;
  PDFDocument? doc;
  bool isLoadingPDF = false;

  bool isDownloading = false;
  double downloadProgress = 0.0;

  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildImageWidget(String imageUrl, index) {
    print('theimage url is =???=>>$imageUrl');
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ImageViewerScreen(
                      images: widget.mediFiles, initialIndex: index)));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: imageUrl.toLowerCase().endsWith('g')
              ? CachedNetworkImage(
                  imageUrl: 'http://login.airmymd.com/$imageUrl',
                  placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.grey,
                  )),
                  errorWidget: (context, url, error) {
                    print(']the error is $error');
                    return Image.file(
                      errorBuilder: (BuildContext, Object, StackTrace) {
                        return Container();
                      },
                      File(
                        imageUrl,
                      ),
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(
                    imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
        ));
  }

  // getSized() async {
  //   final fileSize = await getPdfFileSize(widget.mediFiles[currentPage]);
  //   print('the file size is $fileSize');
  //   if (fileSize > 15) {
  //     widget.mediFiles.removeAt(currentPage);
  //     Get.find<AddVisitController>().imageList.removeAt(currentPage);
  //     Get.snackbar('Error', 'file should be less than 20mb');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // getSized();
    return Stack(
      children: [
        if (isLoadingPDF)
          const Center(
              child: CupertinoActivityIndicator(
            color: Colors.grey,
          ))
        else if (widget.mediFiles.length.toInt() > 0)
          SizedBox(
            height: 200,
            width: Get.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.mediFiles.length,
              onPageChanged: (page) {
                currentPage = page;
                setState(() {});
              },
              itemBuilder: (context, index) {
                final item = widget.mediFiles[index];

                print('ietm $item');
                if (item.toString().toLowerCase().endsWith('g')) {
                  return _buildImageWidget(item, index);
                } else if (item.endsWith('pdf') || item.endsWith('doc')) {
                  return GestureDetector(
                    onTap: () async {
                      print('print here second');
                      try {
                        Utility.showLoader();
                        setState(() {
                          isLoadingPDF = true;
                        });

                        // Start a timer for the timeout
                        Timer timeoutTimer =
                            Timer(const Duration(seconds: 30), () {
                          if (mounted) {
                            Utility.closeLoader();
                            isLoadingPDF = false;
                            setState(() {});
                          }
                        });

                        if (item.toString().startsWith('https://')) {
                          try {
                            doc = await PDFDocument.fromURL(item).timeout(
                                const Duration(
                                    seconds:
                                        30)); // Set a timeout for fetching the PDF from URL
                            // Cancel the timeout timer since loading was successful
                            timeoutTimer.cancel();
                            Utility.closeLoader();
                            print('Document loaded successfully');
                          } on TimeoutException {
                            // Handling timeout
                            Utility.closeLoader();
                            isLoadingPDF = false;
                            setState(() {});

                            return;
                          } catch (error) {
                            // Cancel the timeout timer in case of an error
                            timeoutTimer.cancel();
                            Utility.closeLoader();
                            print('Error loading PDF document: $error');
                            return;
                          }
                        } else {
                          doc = await PDFDocument.fromFile(File(item));
                        }

                        if (doc != null) {
                          setState(() {
                            isLoadingPDF = false;
                          });

                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: const Text('Pdf View'),
                                ),
                                body: SafeArea(
                                  child: PDFViewer(document: doc!),
                                ),
                              ),
                            ),
                          );

                          // Your existing code after returning from the PDF screen.
                        } else {
                          setState(() {
                            isLoadingPDF = false;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          isLoadingPDF = false;
                        });

                        print("Error opening PDF: $e");
                      } finally {
                        Utility.closeLoader();
                      }
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(
                              widget.mediFiles[index].endsWith('doc')
                                  ? 'assets/images/doc-icon.png'
                                  : 'assets/images/pdf-icon.png'),
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        if (widget.enable == true && widget.mediFiles.isNotEmpty)
          InkWell(
            onTap: widget.value == true
                ? () {
                    Utility.showAlertDialogue(
                      'Are you sure yoy want to delete this?',
                      'Delete',
                      () {
                        try {
                          widget.mediFiles.removeAt(currentPage);
                          Get.find<AddVisitController>()
                              .imageList
                              .removeAt(currentPage);
                        } catch (e) {
                          widget.mediFiles.clear();
                        }
                        setState(() {});
                        Get.back();
                      },
                    );
                  }
                : widget.voidCallback,
            child: Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/images/close-round.png')),
          ),
        const SizedBox(
          height: 10,
        ),
        if (widget.mediFiles.length > 1)
          Positioned(
            bottom: 0, // Example position for bottom alignment
            right: Get.width / 2.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [..._buildPageIndicator()],
            ),
          )
      ],
    );
  }

  _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.mediFiles.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == i ? Colors.blueAccent : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}

class ImageViewerScreen extends StatefulWidget {
  final List images;
  final int initialIndex;

  const ImageViewerScreen(
      {super.key, required this.images, required this.initialIndex});

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  PDFDocument? pdfDocument;

  bool isLoadingPDF = false;
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp]);
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: AppColors.primaryColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(),
        ),
        body: SafeArea(
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            controller: PageController(initialPage: widget.initialIndex),
            onPageChanged: (index) {
              print('index is ${widget.images[index]}');
            },
            itemBuilder: (context, index) {
              String item = widget.images[index];
              if (item.endsWith('pdf') || item.endsWith('doc')) {
                return GestureDetector(
                    onTap: () async {
                      print('print here second');
                      try {
                        Utility.showLoader();
                        setState(() {
                          isLoadingPDF = true;
                        });

                        // Start a timer for the timeout
                        Timer timeoutTimer =
                            Timer(const Duration(seconds: 30), () {
                          if (mounted) {
                            Utility.closeLoader();
                            isLoadingPDF = false;
                            setState(() {});
                          }
                        });

                        if (item.toString().startsWith('https://')) {
                          try {
                            pdfDocument = await PDFDocument.fromURL(
                                    'https://login.airmymd.com$item')
                                .timeout(const Duration(
                                    seconds:
                                        30)); // Set a timeout for fetching the PDF from URL
                            // Cancel the timeout timer since loading was successful
                            timeoutTimer.cancel();
                            Utility.closeLoader();
                            print('Document loaded successfully');
                          } on TimeoutException {
                            // Handling timeout
                            Utility.closeLoader();
                            isLoadingPDF = false;
                            setState(() {});

                            return;
                          } catch (error) {
                            // Cancel the timeout timer in case of an error
                            timeoutTimer.cancel();
                            Utility.closeLoader();
                            print('Error loading PDF document: $error');
                            return;
                          }
                        } else {
                          pdfDocument = await PDFDocument.fromFile(File(item));
                        }

                        if (pdfDocument != null) {
                          setState(() {
                            isLoadingPDF = false;
                          });

                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: const Text('Pdf View'),
                                ),
                                body: SafeArea(
                                  child: PDFViewer(document: pdfDocument!),
                                ),
                              ),
                            ),
                          );

                          // Your existing code after returning from the PDF screen.
                        } else {
                          setState(() {
                            isLoadingPDF = false;
                          });
                        }
                      } catch (e) {
                        pdfDocument = await PDFDocument.fromFile(File(item));
                        setState(() {
                          isLoadingPDF = false;
                        });

                        print("Error opening PDF: $e");
                      } finally {
                        pdfDocument = await PDFDocument.fromFile(File(item));
                        Utility.closeLoader();
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage(item.endsWith('pdf')
                                    ? 'assets/images/pdf-icon.png'
                                    : 'assets/images/doc-icon.png'))),
                      ),
                    ));
              } else {
                return Center(
                    child: PhotoView(
                  enablePanAlways: true,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  initialScale: PhotoViewComputedScale.contained,
                  imageProvider: CachedNetworkImageProvider(
                    'https://login.airmymd.com/${widget.images[index]}',
                  ),
                  errorBuilder: (BuildContext, Object, StackTrace) {
                    return Image.file(File(widget.images[index]),
                        fit: BoxFit.cover);
                  },
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<int> getPdfFileSize(String filePath) async {
  try {
    final file = File(filePath);
    final fileExists = await file.exists();

    if (fileExists) {
      final fileStat = await file.stat();
      return fileStat.size;
    } else {
      throw const FileSystemException('File does not exist.');
    }
  } catch (e) {
    print('Error getting PDF file size: $e');
    return -1; // Return -1 or handle the error as needed.
  }
}

String formatDate(String date) {
  final inputFormat = DateFormat("yyyy-MM-dd");
  final outputFormat = DateFormat("MMMM dd, yyyy");

  try {
    final dateTimeUTC = inputFormat.parse(date); // Parse as UTC
    final dateTimeLocal = dateTimeUTC.toLocal(); // Convert to local timezone
    return outputFormat.format(dateTimeLocal);
  } catch (e) {
    return 'Invalid date format';
  }
}

String formatTime(String time) {
  final inputFormat = DateFormat("HH:mm:ss");
  final outputFormat = DateFormat("h:mm a");

  try {
    final timeOfDay = inputFormat.parse(time);
    return outputFormat.format(timeOfDay.toLocal());
  } catch (e) {
    return 'Invalid time format';
  }
}
