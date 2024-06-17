import 'package:airmymd/app/app.dart';

Widget insuranceListButtonWidget() {
  return GetBuilder<InsuranceListController>(builder: (controller) {
    return FittedBox(
        child: GlobalButtons().primaryButton(
      text: 'Add New',
      onTap: () {
        NavigateTo.goToAddInsuranceScreen(
          id: "0",
          navigateFrom: 'insuranceList',
        );
      },
    ));
  });
}
