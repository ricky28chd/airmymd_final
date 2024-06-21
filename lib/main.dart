import 'dart:async';
import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/profile_setting_screen/widget/inviattions.dart';
import 'package:airmymd/data/data.dart';
import 'package:airmymd/device/repositories/device_repositories.dart';
import 'package:airmymd/domain/repositories/repository.dart';
import 'package:airmymd/domain/services/common_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'PushNotificationService.dart';
import 'app/navigators/app_pages.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'domain/usecases/authcases.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

///The main method is the starting point for the project.
///My App is the root for the widget tree, A widget tree is
///the collection for all the widgets used in this project.
///
///
//////
var box = Hive.box('airmymd');
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox<dynamic>('airmymd');

    await initServices();
    FlutterAppBadger.removeBadge();
    FlutterAppBadger.updateBadgeCount(0);
    await Firebase.initializeApp();
    await PushNotificationService().setupInteractedMessage();
    FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(badge: false);

    runApp(const MyApp());
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    if (initialMessage != null) {
      // App received a notification when it was killed
    }
  } catch (exception) {
    Utility.printELog(exception.toString());
  }
}

Future<void> handleDynamicLinks() async {
  final PendingDynamicLinkData? data =
      await FirebaseDynamicLinks.instance.getInitialLink();
  print('onLink stream ID: ${FirebaseDynamicLinks.instance.onLink.hashCode}');
  final Uri? deepLink = data?.link;
  if (deepLink != null) {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (_) => const ViewInvitations()));
  }
  var isStory = deepLink!.pathSegments.contains('visit');
  print('story is $isStory');
  if (isStory) {
    final params = deepLink.queryParameters;
    print('parsmas $params');
    print('id is ${params['id']}');
    String id = deepLink.queryParameters['id'].toString();
    try {} catch (e) {
      print(e);
    }
    print('id is $id');
  }
  print(deepLink);
  print(data?.link.data);
  print(data?.link.path);
  print(data?.link.origin);
  print(data?.link.queryParameters['id']);
  print(data?.link.queryParameters['share']);
  print(data?.link.queryParameters['share/id']);
  print(data?.link.queryParametersAll);
  print(data?.link.hasQuery);
}

class Help {
  Help({required this.date, required this.message});
  final String date;
  final dynamic message;
}

List<Help> messageList = [];

//=================================================================================================
Future<void> initServices() async {
  Get.put(Repository(
    Get.put(
      DeviceRepository(),
      permanent: true,
    ),
    Get.put(
      DataRepository(
        Get.put(
          ConnectHelper(),
          permanent: true,
        ),
      ),
      permanent: true,
    ),
  ));

  ///Services.
  await Get.putAsync(() => CommonService().init());
  //onConnectPressed();
  Get.lazyPut(
      () => ChatController(
            Get.put(
              ChatPresenter(
                Get.put(
                  AuthCases(
                    Get.find(),
                  ),
                ),
              ),
            ),
          ),
      fenix: true);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    handleDynamicLinks();
    super.initState();
  }

  ThemeData myTheme() {
    return ThemeData(
        fontFamily: 'Avenir',
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: AppColors.primaryColor,
            centerTitle: true,
            elevation: 0,
            shadowColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
            )),
        scaffoldBackgroundColor: AppColors.whiteColor);
  }

  getToken() async {
    deviceToken = (await FirebaseMessaging.instance.getToken()).toString();
  }

  /// This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    getToken();
    return GetMaterialApp(
      scrollBehavior: MyBehavior(),
      theme: myTheme(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      getPages: AppPages.pages,
      initialBinding: FindDoctorBinding(),
      initialRoute: AppPages.initial,
    );
  }
}

///Scroll View glow is coming from [GlowingOverscrollIndicator] So , we make a
/// custom scrollBehaviour with [buildOverscrollIndicator], So we can remove
/// that glow from every childScrollView.
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

String prefex = 'https://airmymdapp.page.link';
String home = '/home?id=24';
Future<String> navigateWithDeepLink(bool short, String deepLinkUrl) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: prefex, // Firebase Dynamic Links domain
    link: Uri.parse(prefex + home), // The link URL with your parameters
  );

  Uri url;
  if (short) {
    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    url = shortLink.shortUrl;
  } else {
    url = await FirebaseDynamicLinks.instance.buildLink(parameters);
  }
  print(url);
  // Share.share('https://airmymdapp.page.link');
  prefex = url.toString();
  home = url.toString();
  print('the home is $home');
  return url.toString();
}
