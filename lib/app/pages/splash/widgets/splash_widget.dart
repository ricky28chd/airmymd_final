import 'package:airmymd/app/app.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AppImages.splash,height: Get.height*0.20,),
    );
  }
}
