import 'package:airmymd/app/app.dart';

class GlobalButtons {
  Widget primaryButton({
    required String text,
    required GestureTapCallback onTap,
    Color color = AppColors.primaryColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        //padding: const EdgeInsets.symmetric(vertical: 10),
        height: 40,
        width: Get.width / 2,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyle.buttonText,
        ),
      ),
    );
  }
}
