import 'package:airmymd/app/app.dart';

class BuildProfileScreen extends StatelessWidget {
  const BuildProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildProfileController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            controller.navigateFrom == 'Setting Screen'
                ? 'Personal Information'
                : PageConstants.kBuildYourProfile,
            style: AppTextStyle.appBarHeading,
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: const BuildProfileWidget(),
      );
    });
  }
}
