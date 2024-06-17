import 'package:airmymd/app/app.dart';

class PaymentCardListScreen extends StatelessWidget {
  const PaymentCardListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Payment Methods',
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: PaymentCardListWidget(),
    );
  }
}
