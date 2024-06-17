import 'package:airmymd/app/pages/splash/splash_controller.dart';
import 'package:airmymd/app/pages/splash/widgets/splash_widget.dart';
import 'package:airmymd/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<SplashController>(
      builder: (controller) => const Scaffold(
        backgroundColor: AppColors.primaryColor,
            body: SplashWidget(),
          ));
}
