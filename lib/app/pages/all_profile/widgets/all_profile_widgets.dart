import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/all_profile/all_profile_controller.dart';
import 'package:airmymd/app/pages/pages.dart';
import 'package:airmymd/domain/repositories/localstorage_keys.dart';
import 'package:airmymd/domain/repositories/repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class AllProfilePage extends StatefulWidget {
  const AllProfilePage({super.key});

  @override
  State<AllProfilePage> createState() => _AllProfilePageState();
}

class _AllProfilePageState extends State<AllProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProfileController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: controller.patientProfile == null
                ? const SizedBox()
                : Column(
                    children: [
                      // GlobalDropDown(
                      //   items: controller.childUsers
                      //       .map((user) =>
                      //           user.childPatientProfile.firstName.toString())
                      //       .toList(),
                      //   hintText: 'Switch Account',
                      //   // errorText: controller.dropDownError.value == ''
                      //   //     ? null
                      //   //     : controller.dropDownError.value,
                      //   dropDownItem: controller.activeUser,
                      //   onChanged: (value) {
                      //     var selectedUser = controller.childUsers.firstWhere(
                      //         (user) =>
                      //             user.childPatientProfile.firstName == value);
                      //     controller.updateDropDownValue(selectedUser
                      //         .childPatientProfile.firstName
                      //         .toString());
                      //   },
                      // ),
                      AppSizeBox.height_3,
                      // Parent Profile
                      GestureDetector(
                        onTap: () {
                          controller.clearLocalValues();
//-----------------------------------------

                          Get.find<Repository>().saveValue(LocalKeys.parentId,
                              controller.patientProfile!.userId.toString());
                          Get.find<Repository>()
                              .saveValue(LocalKeys.childId, '');
                          NavigateTo.goToBuildProfileScreen();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.add_circle_outline,
                              color: AppColors.primaryColor,
                            ),
                            AppSizeBox.width_1,
                            const Text('Add', style: TextStyles.primary_14_400)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          controller.clearLocalValues();
                          final patientProfile = controller.patientProfile;
                          // Assign values to the controller

                          Get.find<Repository>().saveValue(
                              LocalKeys.location, patientProfile!.fullAddress);
                          Get.find<Repository>().saveValue(
                              LocalKeys.latitude, patientProfile.latitude);
                          Get.find<Repository>().saveValue(
                              LocalKeys.longitude, patientProfile.longitude);
                          Get.find<Repository>().saveValue(
                              LocalKeys.userEmail, patientProfile.email);
                          Get.find<Repository>().saveValue(
                              LocalKeys.userPhone, patientProfile.phone);
                          Get.find<Repository>().saveValue(
                              LocalKeys.firstName, patientProfile.firstName);
                          Get.find<Repository>().saveValue(
                              LocalKeys.middleName, patientProfile.middleName);
                          Get.find<Repository>().saveValue(
                              LocalKeys.lastName, patientProfile.lastName);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.city, patientProfile.city);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.state, patientProfile.state);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.zip, patientProfile.zip);
                          Get.find<Repository>().saveValue(
                              LocalKeys.height, patientProfile.height);
                          Get.find<Repository>().saveValue(
                              LocalKeys.weight, patientProfile.weight);
                          Get.find<Repository>().saveValue(
                              LocalKeys.gender, patientProfile.gender);
                          Get.find<Repository>().saveValue(
                              LocalKeys.ethnicity, patientProfile.ethnicity);
                          Get.find<Repository>().saveValue(
                              LocalKeys.dob, patientProfile.dob.toString());
                          Get.find<Repository>().saveValue(
                              LocalKeys.maritalStatus,
                              patientProfile.maritialStatus);
                          Get.find<Repository>().saveValue(
                              LocalKeys.medicalHistory,
                              patientProfile.medicalHistory);
                          Get.find<Repository>().saveValue(
                              LocalKeys.surgeries, patientProfile.surgeries);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.year, patientProfile.year);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.age, patientProfile.age);
                          // print(
                          //     'sexual health is =====${patientProfile.sexualHealth.isEmpty}');
                          Get.find<Repository>().saveValue(
                              LocalKeys.sexualHealth,
                              patientProfile.sexualHealth);
                          Get.find<Repository>().saveValue(
                              LocalKeys.habits, patientProfile.habits);
                          Get.find<Repository>().saveValue(
                              LocalKeys.general, patientProfile.general);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.skin, patientProfile.skin);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.eyes, patientProfile.eyes);
                          Get.find<Repository>().saveValue(
                              LocalKeys.cigarette, patientProfile.cigarette);
                          Get.find<Repository>().saveValue(
                              LocalKeys.tobacco, patientProfile.tobacco);
                          Get.find<Repository>().saveValue(
                              LocalKeys.streetDrug, patientProfile.streetDrug);
                          Get.find<Repository>().saveValue(
                              LocalKeys.needleDrug, patientProfile.needleDrug);
                          Get.find<Repository>().saveValue(
                              LocalKeys.drinkAlcohol,
                              patientProfile.drinkAlcohol);
                          Get.find<Repository>().saveValue(
                              LocalKeys.howMany, patientProfile.howMany);
                          Get.find<Repository>().saveValue(
                              LocalKeys.drinksInDay,
                              patientProfile.drinksInDay);
                          Get.find<Repository>().saveValue(
                              LocalKeys.cutDown, patientProfile.cutDown);
                          Get.find<Repository>().saveValue(
                              LocalKeys.feltGuilty, patientProfile.feltGuilty);
                          Get.find<Repository>().saveValue(
                              LocalKeys.morningDrink,
                              patientProfile.morningDrink);
                          Get.find<Repository>().saveValue(
                              LocalKeys.profileImage,
                              patientProfile.profilePhotoUrl);
                          Get.find<Repository>().saveValue(
                              LocalKeys.pushNotification,
                              patientProfile.pushNotification);
                          Get.find<Repository>().saveValue(
                              LocalKeys.emailNotification,
                              patientProfile.emailNotification);
                          Get.find<Repository>()
                              .saveValue(LocalKeys.parentId, '');
                          Get.find<Repository>()
                              .saveValue(LocalKeys.childId, '');

                          // Wait for a short duration to ensure the values are assigned
                          await Future.delayed(
                              const Duration(milliseconds: 100));

                          // Navigate to the ProfileSettingWidget
                          NavigateTo.goToProfileSettingScreen();
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: AppColors.containerBackground,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) {
                                        return const Icon(Icons.people_sharp);
                                      },
                                      imageUrl: controller
                                          .patientProfile!.profilePhotoUrl
                                          .toString())),
                            ),
                            AppSizeBox.width_5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.patientProfile!.firstName
                                      .toString(),
                                  style: TextStyles.darkBlack22,
                                ),
                                AppSizeBox.height_003,
                                controller.patientProfile!.dob.isEmpty
                                    ? const SizedBox()
                                    : Text(
                                        //'Jun 09, 1980',
                                        DateFormat('MMM dd, yyyy').format(
                                            DateTime.parse(controller
                                                .patientProfile!.dob
                                                .toString())),
                                        style: TextStyles.black_16_400,
                                      ),
                                AppSizeBox.height_003,
                                Text(
                                  controller.patientProfile!.userType
                                              .toString() ==
                                          'user'
                                      ? 'Self'
                                      : '',
                                  style: TextStyles.black_16_400,
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                      AppSizeBox.height_3,
                      GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            contentPadding: EdgeInsets.zero,
                            titlePadding: EdgeInsets.zero,
                            title: '',
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Select Account',
                                        style: TextStyles.darkHeavy18,
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          color: AppColors.greyText,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                AppSizeBox.height_1,
                                const Divider(),
                                Container(
                                    child: Column(
                                  children: [
                                    for (var val in controller.childUsers)
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.parentControl(
                                                  userId:
                                                      val.childId.toString());
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .containerBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child:
                                                            CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorWidget:
                                                                    (context,
                                                                        url,
                                                                        error) {
                                                                  return const Icon(
                                                                      Icons
                                                                          .people_sharp);
                                                                },
                                                                imageUrl: val
                                                                    .childPatientProfile
                                                                    .profilePhotoUrl)),
                                                  ),
                                                  AppSizeBox.width_3,
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${val.childPatientProfile.firstName} ${val.childPatientProfile.lastName}',
                                                        style: TextStyles
                                                            .darkHeavy18,
                                                      ),
                                                      val.userType == 'user'
                                                          ? const Text(
                                                              'Parent',
                                                              style: TextStyles
                                                                  .darkMedium14,
                                                            )
                                                          : Text(
                                                              val.userType,
                                                              style: TextStyles
                                                                  .darkMedium14,
                                                            )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons.arrow_forward,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                  ],
                                ))
                              ],
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            'Switch Account',
                            style: TextStyles.whiteBold15,
                          ),
                        ),
                      ),

                      AppSizeBox.height_2,
                      // Family Profile
                      controller.childUsers.isEmpty
                          ? const SizedBox()
                          : const Text(
                              'Family Member',
                              style: TextStyles.darkBlack15,
                            ),
                      AppSizeBox.height_3,
                      Expanded(
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: controller.childUsers.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 30,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  controller.clearLocalValues();
                                  final childProfile = controller
                                      .childUsers[index].childPatientProfile;
                                  // Assign values to the controller

                                  Get.find<Repository>().saveValue(
                                      LocalKeys.location,
                                      childProfile!.fullAddress);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.latitude,
                                      childProfile.latitude);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.longitude,
                                      childProfile.longitude);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.userEmail,
                                      controller.childUsers[index].email);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.userPhone,
                                      controller.childUsers[index].phone);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.firstName,
                                      childProfile.firstName);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.middleName,
                                      childProfile.middleName);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.lastName,
                                      childProfile.lastName);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.city, childProfile.city);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.state, childProfile.state);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.zip, childProfile.zip);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.height, childProfile.height);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.weight, childProfile.weight);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.gender, childProfile.gender);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.ethnicity,
                                      childProfile.ethnicity);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.dob,
                                      childProfile.dob.toString());
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.maritalStatus,
                                      childProfile.maritialStatus);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.medicalHistory,
                                      childProfile.medicalHistory);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.surgeries,
                                      childProfile.surgeries);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.year, childProfile.year);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.age, childProfile.age);
                                  // print(
                                  //     'sexual health is =====${childProfile.sexualHealth.isEmpty}');
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.sexualHealth,
                                      childProfile.sexualHealth);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.habits, childProfile.habits);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.general, childProfile.general);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.skin, childProfile.skin);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.eyes, childProfile.eyes);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.cigarette,
                                      childProfile.cigarette);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.tobacco, childProfile.tobacco);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.streetDrug,
                                      childProfile.streetDrug);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.needleDrug,
                                      childProfile.needleDrug);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.drinkAlcohol,
                                      childProfile.drinkAlcohol);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.howMany, childProfile.howMany);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.drinksInDay,
                                      childProfile.drinksInDay);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.cutDown, childProfile.cutDown);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.feltGuilty,
                                      childProfile.feltGuilty);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.morningDrink,
                                      childProfile.morningDrink);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.profileImage,
                                      childProfile.profilePhotoUrl);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.pushNotification,
                                      childProfile.pushNotification);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.emailNotification,
                                      childProfile.emailNotification);
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.parentId,
                                      controller.childUsers[index].parentId
                                          .toString());
                                  Get.find<Repository>().saveValue(
                                      LocalKeys.childId,
                                      controller.childUsers[index].childId
                                          .toString());

                                  // Wait for a short duration to ensure the values are assigned
                                  await Future.delayed(
                                      const Duration(milliseconds: 100));

                                  // Navigate to the ProfileSettingWidget
                                  NavigateTo.goToProfileSettingScreen();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.textFieldBorder),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.containerBackground,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const Icon(
                                                      Icons.people_sharp);
                                                },
                                                imageUrl: controller
                                                    .childUsers[index]
                                                    .childPatientProfile
                                                    .profilePhotoUrl
                                                    .toString())),
                                      ),
                                      Text(
                                        controller
                                            .childUsers[index]
                                            .childPatientProfile
                                            .firstName
                                            .capitalizeFirst
                                            .toString(),
                                        style: TextStyles.darkBlack15,
                                      ),
                                      controller
                                                  .childUsers[index]
                                                  .childPatientProfile
                                                  .userType ==
                                              'user'
                                          ? Text(
                                              'Parent',
                                              style: TextStyles.black_13_400,
                                            )
                                          : Text(
                                              controller
                                                  .childUsers[index]
                                                  .childPatientProfile
                                                  .userType
                                                  .capitalizeFirst
                                                  .toString(),
                                              style: TextStyles.black_13_400,
                                            )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
