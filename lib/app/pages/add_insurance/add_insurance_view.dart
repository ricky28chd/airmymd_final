import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile.dart';

class AddInsuranceScreen extends StatelessWidget {
  const AddInsuranceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddInsuranceController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            PageConstants.kAddInsurance,
            style: AppTextStyle.appBarHeading,
          ),
          actions: [
            controller.navigateFrom == 'insuranceList' ||
                    controller.navigateFrom == 'paymentScreen'
                ? Container()
                : TextButton(
                    onPressed: () {
                      NavigateTo.goToHealthDashboard();
                    },
                    child: const Text(
                      'Skip All',
                      style: TextStyles.whiteBold15,
                    ))
          ],
        ),
        body: const AddInsuranceWidget(),
      );
    });
  }
}
