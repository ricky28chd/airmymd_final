import 'package:airmymd/app/app.dart';


class BuildProfileWidget extends StatelessWidget {
  const BuildProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileFields(context),
            AppSizeBox.height_10,
            buildProfileButton(context),
            // AppSizeBox.height_2,
            // buildChangePasswordButton(context),
            AppSizeBox.height_5,
          ],
        ),
      ),
    );
  }
}
