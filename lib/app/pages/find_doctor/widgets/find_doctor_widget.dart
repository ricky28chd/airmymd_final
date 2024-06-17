import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FindDoctorWidget extends StatelessWidget {
  const FindDoctorWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FindDoctorController>(builder: (controller) {
      return CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: Padding(
            padding: AppPadding.mainScreenPadding,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizeBox.height_3,
                    const Text(
                      PageConstants.kLetsFindYourDoctor,
                      style: TextStyles.mediumDark25,
                    ),
                    AppSizeBox.height_3,
                    SizedBox(
                      height: Get.height * 0.05,
                      child: TextFormField(
                        controller: controller.searchFeildController,
                        onChanged: (value) => controller.runFilter(value),
                        style: AppTextStyle.textFieldInput,
                        cursorColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 3),
                          filled: true,
                          fillColor: AppColors.containerBackground,
                          hintText: 'Search by speciality',
                          hintStyle: TextStyles.black_13_400,
                          prefixIcon: Image.asset(
                            AppImages.searchIcon,
                            color: Color(0xff383E45),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            maxHeight: 15,
                            minHeight: 15,
                            minWidth: 30,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                        ),
                      ),
                    ),
                    AppSizeBox.height_3,
                    const Text(
                      PageConstants.kSpeciality,
                      style: TextStyles.darkHeavy18,
                    ),
                  ],
                ),
                AppSizeBox.height_2,
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.onRefresh,
                    displacement: 80,
                    backgroundColor: AppColors.primaryColor,
                    color: AppColors.whiteColor,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child:
                          //  controller.specializationList.isEmpty
                          //     ? SizedBox(
                          //         height: Get.height / 2,
                          //         child: Center(
                          //             child: Text(
                          //           controller.specialistError,
                          //           textAlign: TextAlign.center,
                          //         )))
                          //     :
                          controller.emptyResult != ''
                              ? SizedBox(
                                  height: Get.height / 2,
                                  child: Center(
                                      child: Text(
                                    controller.emptyResult,
                                    textAlign: TextAlign.center,
                                  )))
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: RefreshIndicator(
                                          onRefresh: controller.onRefresh,
                                          child: ListView.separated(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .specializationList.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return index.isEven
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        NavigateTo
                                                            .goToGoogleMapScreen(
                                                          specialization: controller
                                                              .specializationList[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          longitude: controller
                                                              .longitude,
                                                          latitude: controller
                                                              .latitude,
                                                        );
                                                        controller.update();
                                                      },
                                                      child: Card(
                                                        elevation: 5,
                                                        shadowColor: AppColors
                                                            .containerBackground,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          height:
                                                              Get.height * 0.22,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                    color: AppColors
                                                                        .containerBackground,
                                                                    spreadRadius:
                                                                        3,
                                                                    blurRadius:
                                                                        3),
                                                              ]),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AppSizeBox
                                                                  .height_1,
                                                              CachedNetworkImage(
                                                                imageUrl: controller
                                                                    .specializationList[
                                                                        index]
                                                                    .icon
                                                                    .toString(),
                                                                height: 45,
                                                                width: 45,
                                                              ),
                                                              AppSizeBox
                                                                  .height_1,
                                                              Text(
                                                                controller
                                                                    .specializationList[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyles
                                                                    .mediumDark15,
                                                              ),
                                                              AppSizeBox
                                                                  .height_1,
                                                              Text(
                                                                '${controller.specializationList[index].count} Specialists',
                                                                style: TextStyles
                                                                    .greyPlain13,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return AppSizeBox.height_2;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppSizeBox.width_7,
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: ListView.separated(
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .specializationList.length,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return index.isOdd
                                                ? GestureDetector(
                                                    onTap: () {
                                                      NavigateTo
                                                          .goToGoogleMapScreen(
                                                        specialization: controller
                                                            .specializationList[
                                                                index]
                                                            .name
                                                            .toString(),
                                                        longitude: controller
                                                            .longitude,
                                                        latitude:
                                                            controller.latitude,
                                                      );
                                                    },
                                                    child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      shadowColor: AppColors
                                                          .containerBackground,
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      15),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          height:
                                                              Get.height * 0.20,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              AppSizeBox
                                                                  .height_1,
                                                              CachedNetworkImage(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                imageUrl: controller
                                                                    .specializationList[
                                                                        index]
                                                                    .icon
                                                                    .toString(),
                                                                height: 45,
                                                                width: 45,
                                                              ),
                                                              AppSizeBox
                                                                  .height_1,
                                                              Text(
                                                                controller
                                                                    .specializationList[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                style: TextStyles
                                                                    .mediumDark15,
                                                              ),
                                                              AppSizeBox
                                                                  .height_1,
                                                              Text(
                                                                '${controller.specializationList[index].count} Specialists',
                                                                style: TextStyles
                                                                    .greyPlain13,
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                  )
                                                : Container();
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return AppSizeBox.height_2;
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]);
    });
  }
}
