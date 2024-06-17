import 'package:airmymd/app/app.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: AppTextStyle.appBarHeading,
        ),
        automaticallyImplyLeading: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: SearchDoctor(),
        ),
      ),
      body: const ChatListWidget(),
    );
  }
}
