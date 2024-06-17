import 'package:airmymd/app/app.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorProfileController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            controller.specialization,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.appBarHeading,
          ),
        ),
        body: const DoctorProfileWidget(),
      );
    });
  }
}
