import 'package:airmymd/app/pages/otp/widgets/otp_widgets.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OtpWidget(),
    );
  }
}
