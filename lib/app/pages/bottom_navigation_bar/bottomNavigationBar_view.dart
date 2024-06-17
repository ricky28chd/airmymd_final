// ignore_for_file: file_names

import 'package:airmymd/app/app.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage(
      {super.key,
      this.image1 = AppImages.searchIcon,
      this.image2 = AppImages.profileIcon,
      this.image3 = AppImages.calenderIcon,
      this.image4 = AppImages.insuranceIcon,
      this.image5 = AppImages.settingIcon});
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: AppColors.containerBackground,
            blurRadius: 3,
            spreadRadius: 2)
      ]),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Utility.closeDialog();
              Utility.closeLoader();
              Utility.closeSnackBar();
              NavigateTo.goToFindDoctorScreen();
            },
            child: Image.asset(
              image1,
              height: Get.height * 0.03,
            ),
          ),
          GestureDetector(
            onTap: () {
              Utility.closeDialog();
              Utility.closeLoader();
              Utility.closeSnackBar();
              NavigateTo.goToAllProfileScreen();
            },
            child: Image.asset(
              image2,
              height: Get.height * 0.03,
            ),
          ),
          GestureDetector(
            onTap: () {
              Utility.closeDialog();
              Utility.closeLoader();
              Utility.closeSnackBar();
              NavigateTo.goToAppointmentListScreen();
            },
            child: Image.asset(
              image3,
              height: Get.height * 0.03,
            ),
          ),
          GestureDetector(
            onTap: () {
              Utility.closeDialog();
              Utility.closeLoader();
              Utility.closeSnackBar();
              NavigateTo.goToHealthDashboard();
            },
            child: Image.asset(
              image4,
              height: Get.height * 0.033,
            ),
          ),
          GestureDetector(
            onTap: () {
              Utility.closeDialog();
              Utility.closeLoader();
              Utility.closeSnackBar();
              NavigateTo.goToUserSettingScreen();
            },
            child: Image.asset(
              image5,
              height: Get.height * 0.03,
            ),
          )
        ],
      ),
    );
  }
}
