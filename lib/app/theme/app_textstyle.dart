import 'package:airmymd/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle introPageHeading = TextStyles.extraBoldWhite30;
  static const TextStyle introPageSubHeading = TextStyles.whiteMedium22;
  static const TextStyle textFieldHint = TextStyles.greyPlain16;
  static const TextStyle textFieldInput = TextStyles.darkPlain14;
  static const TextStyle authenticationHeading = TextStyles.darkBlack22;
  static const TextStyle appBarHeading = TextStyles.darkWhite20;
  static const TextStyle authenticationSubHeading = TextStyles.darkPlain14;
  static const TextStyle buttonText = TextStyles.whiteMedium17;
  static const TextStyle authenticationPlain = TextStyles.darkPlain13;
  static const TextStyle authenticationBold = TextStyles.darkBold13;
  static const TextStyle helpText = TextStyles.extraBoldBlue13;
  static const TextStyle mainHeading = TextStyles.darkBlack15;
  static const TextStyle checkBoxTitle = TextStyles.darkPlain14;
  static const TextStyle doctorNameTitle = TextStyles.darkMedium17_800;
}

class TextStyles {
  static const TextStyle extraBoldWhite30 = TextStyle(
      color: AppColors.whiteColor, fontSize: 30, fontWeight: FontWeight.w800);

  static const TextStyle mediumDark25 = TextStyle(
    color: AppColors.darkText,
    fontSize: 25,
    height: 1.1,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle mediumDark15 = TextStyle(
    fontSize: 15,
    color: AppColors.darkText,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle mediumDark15_500 = TextStyle(
    fontSize: 15,
    color: AppColors.darkText,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle whiteMedium20 = TextStyle(
      color: AppColors.whiteColor, fontSize: 20, fontWeight: FontWeight.w500);

  static const TextStyle whiteMedium22 = TextStyle(
      color: AppColors.whiteColor, fontSize: 22, fontWeight: FontWeight.w500);

  static const TextStyle whiteMedium17 = TextStyle(
      color: AppColors.whiteColor, fontSize: 17, fontWeight: FontWeight.w500);

  static const TextStyle darkMedium17 = TextStyle(
      color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.w500);

  static const TextStyle darkMedium17_800 = TextStyle(
      color: AppColors.darkText, fontSize: 17, fontWeight: FontWeight.w800);

  static const TextStyle darkBlack20 = TextStyle(
      color: AppColors.darkText, fontSize: 20, fontWeight: FontWeight.w800);
  static const TextStyle darkBlack18 = TextStyle(
      color: AppColors.darkText, fontSize: 15, fontWeight: FontWeight.w800);
  static const TextStyle darkBlack22 = TextStyle(
      color: AppColors.darkText, fontSize: 22, fontWeight: FontWeight.w800);

  static const TextStyle darkBlack35_500 = TextStyle(
      color: AppColors.darkText, fontSize: 35, fontWeight: FontWeight.w500);

  static const TextStyle darkBlack15 = TextStyle(
      color: AppColors.darkText, fontSize: 15, fontWeight: FontWeight.w800);

  static const TextStyle darkBlack16 = TextStyle(
      color: AppColors.darkText, fontSize: 16, fontWeight: FontWeight.w800);

  static const TextStyle darkHeavy18 = TextStyle(
      color: AppColors.darkText, fontSize: 18, fontWeight: FontWeight.w700);

  static const TextStyle boldYellow15 = TextStyle(
      color: Color(0xfffff14b), fontSize: 15, fontWeight: FontWeight.w800);

  static const TextStyle whiteBold15 = TextStyle(
      color: AppColors.whiteColor, fontSize: 15, fontWeight: FontWeight.w800);

  static const TextStyle darkWhite20 = TextStyle(
      color: AppColors.whiteColor, fontSize: 20, fontWeight: FontWeight.w800);
  static const TextStyle red20 = TextStyle(
      color: AppColors.redColor, fontSize: 20, fontWeight: FontWeight.w800);
  static const TextStyle darkPlain12 = TextStyle(
      color: AppColors.darkText, fontSize: 12, fontWeight: FontWeight.w400);

  static const TextStyle whitePlain12 = TextStyle(
      color: AppColors.whiteColor, fontSize: 12, fontWeight: FontWeight.w400);

  static const TextStyle greyPlain16 = TextStyle(
      color: AppColors.textFieldHintText,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  static const TextStyle greyPlain22 = TextStyle(
      color: Colors.blueGrey, fontSize: 22, fontWeight: FontWeight.w800);

  static const TextStyle black_13_400 = TextStyle(
      color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.w400);

  static const TextStyle black_16_400 = TextStyle(
      color: AppColors.darkText, fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle darkPlain14 = TextStyle(
      color: AppColors.dateTimeText, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle darkPlain15 = TextStyle(
      color: AppColors.dateTimeText, fontSize: 15, fontWeight: FontWeight.w400);

  static const TextStyle darkPlain20 = TextStyle(
      color: AppColors.dateTimeText, fontSize: 20, fontWeight: FontWeight.w400);

  static const TextStyle darkPlain14Address = TextStyle(
      color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle darkMedium14 = TextStyle(
      color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle darkMedium15 = TextStyle(
      color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle darkMediumWithHeight14 = TextStyle(
      color: AppColors.darkText,
      fontSize: 13,
      fontWeight: FontWeight.w500,
      height: 1.3);

  static const TextStyle darkPlain13 = TextStyle(
      color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.w400);

  static const TextStyle greyPlain13 = TextStyle(
      color: AppColors.greyText, fontSize: 13, fontWeight: FontWeight.w400);

  static const TextStyle greyMedium14 = TextStyle(
      color: AppColors.greyText, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle greyPlain15 = TextStyle(
      color: AppColors.greyText, fontSize: 15, fontWeight: FontWeight.w800);

  static const TextStyle darkBold13 = TextStyle(
      color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.w700);

  static const TextStyle darkMedium12 = TextStyle(
      color: AppColors.darkText, fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle lastMessagseText = TextStyle(
      color: AppColors.lastMessageText,
      fontSize: 13,
      fontWeight: FontWeight.w500);

  static const TextStyle timeText = TextStyle(
      color: AppColors.lastMessageText,
      fontSize: 10,
      fontWeight: FontWeight.w500);

  static const TextStyle extraBoldBlue13 = TextStyle(
      color: AppColors.primaryColor, fontSize: 13, fontWeight: FontWeight.w800);

  static const TextStyle pendingText = TextStyle(
      color: AppColors.pendingColor, fontSize: 13, fontWeight: FontWeight.w800);

  static const TextStyle acceptText = TextStyle(
      color: AppColors.acceptedColor,
      fontSize: 13,
      fontWeight: FontWeight.w800);

  static const TextStyle cancelledText = TextStyle(
      color: AppColors.redColor, fontSize: 13, fontWeight: FontWeight.w800);

  static const TextStyle rejectText = TextStyle(
      color: AppColors.rejectedColor,
      fontSize: 13,
      fontWeight: FontWeight.w800);

  static const TextStyle extraBoldBlue15 = TextStyle(
      color: AppColors.primaryColor, fontSize: 15, fontWeight: FontWeight.w800);
  static const TextStyle extraBoldBlue15Underline = TextStyle(
      decoration: TextDecoration.underline,
      color: AppColors.primaryColor,
      fontSize: 15,
      fontWeight: FontWeight.w800);
  static const TextStyle extraBoldBlue13Underline = TextStyle(
      decoration: TextDecoration.underline,
      color: AppColors.primaryColor,
      fontSize: 13,
      fontWeight: FontWeight.w800);
  static const TextStyle extraBoldRed13 = TextStyle(
      color: AppColors.redColor, fontSize: 13, fontWeight: FontWeight.w800);

  static const TextStyle plainDark15 = TextStyle(
      color: AppColors.darkText, fontSize: 15, fontWeight: FontWeight.w500);

  static const TextStyle primary_14_400 = TextStyle(
      color: AppColors.primaryColor, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle greyMainHeading = TextStyle(
      color: AppColors.greyColorMainHeading,
      fontSize: 15,
      fontWeight: FontWeight.w800);
}
