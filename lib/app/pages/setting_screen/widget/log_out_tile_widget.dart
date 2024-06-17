import 'package:airmymd/app/app.dart';

Widget logOutTileWidget(BuildContext context) {
  return GetBuilder<UserSettingController>(builder: (controller) {
    return ListTile(
        onTap: () {
          
          Utility.askToEnableServiceFromSetting(
              'Logout', 'Are you sure you want to logout', 
              onPressed: () {
            controller.logoutButtonClicked(context);
          });
        },
        contentPadding: const EdgeInsets.only(right: 10),
        title: const Text(
          'Log out',
          style: TextStyles.mediumDark15,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: Colors.black,
        ));
  });
}
