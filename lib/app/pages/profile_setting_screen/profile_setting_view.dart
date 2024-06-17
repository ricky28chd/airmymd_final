import 'package:airmymd/app/app.dart';

import 'package:http/http.dart' as http;

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<ProfileSettingController>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text(
              'Profile',
              style: AppTextStyle.appBarHeading,
            ),
          ),
          body: const ProfileSettingWidget(),
        );
      }),
    );
  }
}
