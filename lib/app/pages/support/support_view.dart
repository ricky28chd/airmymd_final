import 'package:airmymd/app/app.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBackground,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          PageConstants.kHelp,
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: SupportWidget(),
    );
  }
}
