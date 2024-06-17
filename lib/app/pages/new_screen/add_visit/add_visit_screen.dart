import 'package:airmymd/app/pages/new_screen/add_visit/widget/widget.dart';
import 'package:airmymd/app/pages/pages.dart';

import '../../../theme/app_textstyle.dart';

class AddVisitScreen extends StatelessWidget {
  const AddVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Visit',
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: const AddVisitWidget(),
    );
  }
}
