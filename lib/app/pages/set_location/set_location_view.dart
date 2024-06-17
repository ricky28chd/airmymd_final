import 'package:airmymd/app/app.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SetLocationScreen extends StatelessWidget {
  const SetLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetLocationController>(builder: (controller) {
      return Scaffold(
        body: SetLocationWidget(),
      );
    });
  }
}
