import 'package:airmymd/app/pages/new_screen/add_doctor/widget/add_doctor_widget.dart';
import 'package:airmymd/app/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Doctor',
          style: AppTextStyle.appBarHeading,
        ),
      ),
      body: const AddDoctorWidget(),
    );
  }
}
