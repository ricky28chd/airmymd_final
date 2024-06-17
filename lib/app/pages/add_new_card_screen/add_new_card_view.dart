import 'package:airmymd/app/app.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Add New Card',
          style: AppTextStyle.appBarHeading,
        ),
        centerTitle: true,
      ),
      body: const AddNewCardWidget(),
    );
  }
}
