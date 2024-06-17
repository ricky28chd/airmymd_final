import 'package:airmymd/app/app.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book An Appointment',
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: const BookAppointmentWidget(),
    );
  }
}
