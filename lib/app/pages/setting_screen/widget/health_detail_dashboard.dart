import 'package:airmymd/app/app.dart';

class HealthDetailDashboard extends StatefulWidget {
  const HealthDetailDashboard({super.key});

  @override
  State<HealthDetailDashboard> createState() => _HealthDetailDashboardState();
}

class _HealthDetailDashboardState extends State<HealthDetailDashboard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserSettingController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text(
            'Health Detail',
            style: AppTextStyle.appBarHeading,
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: AppPadding.mainScreenPadding,
              child: RefreshIndicator(
                onRefresh: () async {
                  // controller.getData();
                },
                child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSizeBox.height_3,
                            const Text(
                              'Health Dashboard',
                              style: TextStyles.mediumDark25,
                              textScaleFactor: 1.1,
                            ),
                            AppSizeBox.height_3,
                            Row(
                              children: [
                                const Text(
                                  'Portal',
                                  style: TextStyles.darkHeavy18,
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                        isDismissible: false,
                                        enableDrag: false,
                                        backgroundColor: Colors.white,
                                        SizedBox(
                                          width: Get.width,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: const Text(
                                                      'Add Portal',
                                                      style: TextStyles
                                                          .darkBlack18,
                                                    ),
                                                    trailing: InkWell(
                                                      onTap: () {
                                                        // controller.title.clear();
                                                        // controller.imagePath = '';
                                                        // controller.update();
                                                        Get.back();
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  GlobalTextField().withLabel(
                                                      context: context,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      // controller: 'Title here',
                                                      label: 'Title',
                                                      hintText: 'Title'),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      //controller.pickImage();
                                                    },
                                                    child: const Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Select Icon',
                                                        style: TextStyles
                                                            .extraBoldBlue15Underline,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // if (controller
                                                  //     .imagePath.isNotEmpty)
                                                  //   Image.file(
                                                  //     File(controller.imagePath),
                                                  //     height: 90,
                                                  //     width: 90,
                                                  //     fit: BoxFit.cover,
                                                  //   ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  GlobalButtons().primaryButton(
                                                      text: 'Add',
                                                      onTap: () {
                                                        // FocusScope.of(context)
                                                        //     .unfocus();
                                                        // controller
                                                        //     .addSpecialist();
                                                      })
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Add Portal',
                                        style: TextStyles.extraBoldBlue15,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        AppSizeBox.height_2,
                        SizedBox(
                          height: Get.height / 1.65,
                          width: Get.width,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                healthDetailDashboardTile(
                                    logoImage:
                                        'assets/health_portal_logo/mychart-logo.png',
                                    onTap: () {
                                      controller.epicLogin(context);
                                    }),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                healthDetailDashboardTile(
                                    logoImage:
                                        'assets/health_portal_logo/Athenahealth-Logo.png'),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                healthDetailDashboardTile(
                                    logoImage:
                                        'assets/health_portal_logo/baylor_logo.png')
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          )
        ]),
      );
    });
  }
}

Widget healthDetailDashboardTile({
  required String logoImage,
  GestureTapCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: Get.height * 0.15,
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.3),
            ),
          ]),
      child: Image.asset(
        logoImage,
        fit: BoxFit.cover,
      ),
    ),
  );
}
