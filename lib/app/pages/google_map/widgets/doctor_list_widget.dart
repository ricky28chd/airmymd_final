import 'package:airmymd/app/app.dart';


class DoctorListWidget extends StatelessWidget {
  const DoctorListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: doctorListField(),
    );
  }
}
