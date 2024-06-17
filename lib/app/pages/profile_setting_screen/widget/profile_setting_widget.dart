import 'package:airmymd/app/app.dart';

class ProfileSettingWidget extends StatelessWidget {
  const ProfileSettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileSettingController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  NavigateTo.goToBuildProfileScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Build Your Profile',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToInsuranceListScreen();
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Insurance',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToAllergiesScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Allergies',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToMedicalHistoryScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Medical History',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToSurgeriesScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Surgeries',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToMedicationScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Medication',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToSexualHealthScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Sexual Health',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToHealthHabitsScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Health Habits',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToGeneralHealthScreen(
                      navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'General Health',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToTobaccoScreen(navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Tobacco',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToAlcoholScreen(navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Alcohol',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  NavigateTo.goToDrugScreen(navigateFrom: 'Setting Screen');
                },
                child: const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Drugs',
                      style: TextStyles.mediumDark15,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
