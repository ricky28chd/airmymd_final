import 'package:airmymd/app/pages/walkthrough/widgets/walkthrough_widget.dart';
import 'package:airmymd/app/theme/theme_export.dart';
import 'package:flutter/material.dart';


class WalkThroughScreen extends StatelessWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: AppColors.blackColor,
      body: WalkThroughWidget(),
    );
  }
}


