import 'package:airmymd/app/app.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: const NotificationListWidget(),
    );
  }
}
