import 'package:airmymd/app/app.dart';

Widget addNewCardButtonWidget() {
  return GetBuilder<PaymentCardListController>(builder: (controller) {
    return FittedBox(
        child: GlobalButtons().primaryButton(
      text: 'Add New',
      onTap: NavigateTo.goToAddNewCardScreen,
    ));
  });
}
