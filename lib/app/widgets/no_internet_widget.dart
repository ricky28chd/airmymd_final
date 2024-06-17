// coverage:ignore-file
import 'package:airmymd/app/app.dart';

/// Ui for No Internet widget
class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);
  static const noInternetWidgetKey = Key('no-internet-widget-key');
  @override
  Widget build(BuildContext context) => Scaffold(
        key: noInternetWidgetKey,
        backgroundColor: AppColors.whiteColor,
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
      );
}
