import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/new_screen/add_doctor/primary_care/widget/widget.dart';
import 'package:airmymd/domain/repositories/repository.dart';

class PrimaryCareScreen extends StatefulWidget {
  const PrimaryCareScreen({super.key});

  @override
  State<PrimaryCareScreen> createState() => _PrimaryCareScreenState();
}

class _PrimaryCareScreenState extends State<PrimaryCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.find<Repository>().getStringValue(
            'specialistTitle',
          ),
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: const PrimaryCareWidget(),
    );
  }
}
