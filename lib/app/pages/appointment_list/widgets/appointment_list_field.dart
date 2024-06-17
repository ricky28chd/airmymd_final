// ignore_for_file: depend_on_referenced_packages

import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

Widget upcomingAppointmentWidget() {
  return GetBuilder<AppointmentListController>(builder: (controller) {
    return controller.upcomingAppointments.isEmpty
        ? RefreshIndicator(
            onRefresh: controller.onRefreshAppointments,
            color: AppColors.primaryColor,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: Get.height / 1.5,
                width: Get.width,
                child: Center(
                    child: Text(controller.upcomingAppointmentErrorText)),
              ),
            ),
          )
        : RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: controller.onRefreshAppointments,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(BottomSheet(
                        constraints:
                            BoxConstraints(maxHeight: Get.height / 2.1),
                        backgroundColor: Colors.transparent,
                        onClosing: () {},
                        builder: (context) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: AppointmentDetailSheet(
                                appointmentFor: controller
                                    .upcomingAppointments[index].patientName
                                    .toString(),
                                bookingStatus: Text(
                                  controller.upcomingAppointments[index].status!
                                      .capitalizeFirst
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: controller.upcomingAppointments[index]
                                              .status
                                              .toString() ==
                                          'cancelled'
                                      ? TextStyles.cancelledText
                                      : controller.upcomingAppointments[index]
                                                  .status
                                                  .toString() ==
                                              'pending'
                                          ? TextStyles.pendingText
                                          : controller
                                                      .upcomingAppointments[
                                                          index]
                                                      .status
                                                      .toString() ==
                                                  'rejected'
                                              ? TextStyles.rejectText
                                              : TextStyles.acceptText,
                                ),
                                doctorName:
                                    'Dr. ${controller.upcomingAppointments[index].doctor!.firstName!.capitalizeFirst} ${controller.upcomingAppointments[index].doctor!.lastName!.capitalizeFirst}',
                                bookingTimeDate:
                                    '${DateFormat("yMMMd").format(controller.upcomingAppointments[index].bookingDate!)} at'
                                    ' ${controller.upcomingAppointments[index].bookingTime}',
                                decorationImage: controller
                                            .upcomingAppointments[index]
                                            .doctor!
                                            .profileImage ==
                                        null
                                    ? const DecorationImage(
                                        scale: 2,
                                        image:
                                            AssetImage(AppImages.profileIcon),
                                      )
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            '${controller.upcomingAppointments[index].doctor!.profileImage}'),
                                      ),
                                appointmentReason: controller
                                        .upcomingAppointments[index].reason
                                        .toString()
                                        .isEmpty
                                    ? 'Not mentioned'
                                    : controller.upcomingAppointments[index].reason
                                        .toString(),
                                chatButtonWidget: controller.upcomingAppointments[index].status.toString() == 'pending' ||
                                        controller.upcomingAppointments[index].status.toString() ==
                                            'completed'
                                    ? Container()
                                    : controller.upcomingAppointments[index].status.toString() ==
                                            'rejected'
                                        ? Container()
                                        : GlobalButtons().primaryButton(
                                            text: 'Chat',
                                            onTap: () {
                                              NavigateTo.goToChatScreen(
                                                  userdId: controller
                                                      .upcomingAppointments[
                                                          index]
                                                      .doctor!
                                                      .userId
                                                      .toString(),
                                                  image: controller
                                                      .upcomingAppointments[
                                                          index]
                                                      .doctor!
                                                      .profileImage
                                                      .toString(),
                                                  doctorName:
                                                      '${controller.upcomingAppointments[index].doctor!.firstName} ${controller.upcomingAppointments[index].doctor!.lastName}');
                                            }),
                                cancelButtonWidget: controller.upcomingAppointments[index].status.toString() ==
                                            'rejected' ||
                                        controller.upcomingAppointments[index].status.toString() == 'completed'
                                    ? Container()
                                    : GlobalButtons().primaryButton(
                                        text: 'Cancel Appointment',
                                        onTap: () {
                                          Get.back();
                                          Utility.askToEnableServiceFromSetting(
                                              'Cancel',
                                              'Are you sure you want to Cancel this appointment',
                                              onPressed: () {
                                            controller.deleteAppointment(
                                                appointmentId: controller
                                                    .upcomingAppointments[index]
                                                    .id!
                                                    .toInt());
                                            Get.back();
                                          });
                                        },
                                        color: AppColors.redColor)),
                          );
                        }));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width * 0.19,
                        height: Get.height * 0.09,
                        decoration: BoxDecoration(
                            image: controller.upcomingAppointments[index]
                                        .doctor!.profileImage ==
                                    null
                                ? const DecorationImage(
                                    scale: 2.0,
                                    image: AssetImage(AppImages.profileIcon))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(controller
                                        .upcomingAppointments[index]
                                        .doctor!
                                        .profileImage
                                        .toString())),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.containerBackground)),
                      ),
                      AppSizeBox.width_3,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. ${controller.upcomingAppointments[index].doctor!.firstName.toString()}'
                            ' ${controller.upcomingAppointments[index].doctor!.lastName.toString()}',
                            style: AppTextStyle.doctorNameTitle,
                          ),
                          AppSizeBox.height_005,
                          Text(
                            '${DateFormat("yMMMd").format(controller.upcomingAppointments[index].bookingDate!)} at'
                            ' ${controller.upcomingAppointments[index].bookingTime}',
                            style: TextStyles.darkPlain14,
                          ),
                          AppSizeBox.height_005,
                          Row(
                            children: [
                              controller.upcomingAppointments[index].status
                                          .toString() !=
                                      'completed'
                                  ? Text(
                                      controller.upcomingAppointments[index]
                                          .status!.capitalizeFirst
                                          .toString(),
                                      style: controller
                                                  .upcomingAppointments[index]
                                                  .status
                                                  .toString() ==
                                              'pending'
                                          ? TextStyles.pendingText
                                          : controller
                                                      .upcomingAppointments[
                                                          index]
                                                      .status
                                                      .toString() ==
                                                  'rejected'
                                              ? TextStyles.rejectText
                                              : controller
                                                          .upcomingAppointments[
                                                              index]
                                                          .status
                                                          .toString() ==
                                                      'canceled'
                                                  ? TextStyles.cancelledText
                                                  : TextStyles.acceptText,
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      controller.upcomingAppointments[index].status
                                      .toString() ==
                                  'rejected' ||
                              controller.upcomingAppointments[index].status
                                      .toString() ==
                                  'completed'
                          ? controller.upcomingAppointments[index].status
                                          .toString() !=
                                      'completed' &&
                                  controller.upcomingAppointments[index]
                                          .paymentType ==
                                      'card'
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    appointmentId = controller
                                        .upcomingAppointments[index].id!;
                                    Get.bottomSheet(BottomSheet(
                                        constraints: BoxConstraints(
                                            maxHeight: Get.height / 2.0),
                                        backgroundColor: Colors.transparent,
                                        onClosing: () {},
                                        builder: (context) {
                                          return addRatingWidget(onTap: () {
                                            controller.doctorId = controller
                                                .upcomingAppointments[index]
                                                .doctorId
                                                .toString();
                                            controller.paymentRelease(
                                                bookingId:
                                                    appointmentId.toString());
                                          });
                                        }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'Complete',
                                        style: TextStyles.whitePlain12,
                                      ),
                                    ),
                                  ),
                                )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppSizeBox.width_2,
                                GestureDetector(
                                  onTap: () {
                                    Utility.askToEnableServiceFromSetting(
                                        'Cancel',
                                        'Are you sure you want to cancel this appointment?',
                                        onPressed: () {
                                      controller.deleteAppointment(
                                          appointmentId: controller
                                              .upcomingAppointments[index].id!
                                              .toInt());
                                    });
                                  },
                                  child: Image.asset(
                                    AppImages.cancelBooking,
                                    scale: 2.5,
                                  ),
                                ),
                                controller.upcomingAppointments[index].status
                                            .toString() ==
                                        'pending'
                                    ? AppSizeBox.width_1
                                    : AppSizeBox.width_5,
                                controller.upcomingAppointments[index].status
                                            .toString() ==
                                        'pending'
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          NavigateTo.goToChatScreen(
                                              userdId: controller
                                                  .upcomingAppointments[index]
                                                  .doctor!
                                                  .userId
                                                  .toString(),
                                              image: controller
                                                  .upcomingAppointments[index]
                                                  .doctor!
                                                  .profileImage
                                                  .toString(),
                                              doctorName:
                                                  '${controller.upcomingAppointments[index].doctor!.firstName} ${controller.upcomingAppointments[index].doctor!.lastName}');
                                        },
                                        child: Image.asset(
                                          AppImages.messgeImageFilled,
                                          scale: 2.5,
                                        ),
                                      ),
                              ],
                            )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: controller.upcomingAppointments.length,
            ),
          );
  });
}

Widget pastAppointmentWidget() {
  return GetBuilder<AppointmentListController>(builder: (controller) {
    return controller.pastAppointments.isEmpty
        ? SizedBox(
            height: Get.height / 2.1,
            width: Get.width,
            child: Center(child: Text(controller.pastAppointmentErrorText)),
          )
        : RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: controller.onRefreshAppointments,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(BottomSheet(
                        constraints:
                            BoxConstraints(maxHeight: Get.height / 1.5),
                        backgroundColor: Colors.transparent,
                        onClosing: () {},
                        builder: (context) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: AppointmentDetailSheet(
                                appointmentFor: controller
                                    .pastAppointments[index].patientName
                                    .toString(),
                                bookingStatus: Text(
                                  controller.pastAppointments[index].status!
                                      .capitalizeFirst
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: controller
                                              .pastAppointments[index].status
                                              .toString() ==
                                          'cancelled'
                                      ? TextStyles.cancelledText
                                      : controller.pastAppointments[index]
                                                  .status
                                                  .toString() ==
                                              'pending'
                                          ? TextStyles.pendingText
                                          : controller.pastAppointments[index]
                                                      .status
                                                      .toString() ==
                                                  'rejected'
                                              ? TextStyles.rejectText
                                              : TextStyles.acceptText,
                                ),
                                doctorName:
                                    'Dr. ${controller.pastAppointments[index].doctor!.firstName!.capitalizeFirst} ${controller.pastAppointments[index].doctor!.lastName!.capitalizeFirst}',
                                bookingTimeDate:
                                    '${DateFormat("yMMMd").format(controller.pastAppointments[index].bookingDate!)} at'
                                    ' ${controller.pastAppointments[index].bookingTime}',
                                decorationImage: controller
                                            .pastAppointments[index]
                                            .doctor!
                                            .profileImage ==
                                        null
                                    ? const DecorationImage(
                                        scale: 2,
                                        image:
                                            AssetImage(AppImages.profileIcon),
                                      )
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            '${controller.pastAppointments[index].doctor!.profileImage}'),
                                      ),
                                appointmentReason: controller
                                        .pastAppointments[index].reason
                                        .toString()
                                        .isEmpty
                                    ? 'Not mentioned'
                                    : controller.pastAppointments[index].reason
                                        .toString(),
                                chatButtonWidget: Container(),
                                cancelButtonWidget: Container()),
                          );
                        }));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: Get.width * 0.19,
                        height: Get.height * 0.09,
                        decoration: BoxDecoration(
                            image: controller.pastAppointments[index].doctor!
                                        .profileImage ==
                                    null
                                ? const DecorationImage(
                                    scale: 2.0,
                                    image: AssetImage(AppImages.profileIcon))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(controller
                                        .pastAppointments[index]
                                        .doctor!
                                        .profileImage
                                        .toString())),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.containerBackground)),
                      ),
                      AppSizeBox.width_3,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. ${controller.pastAppointments[index].doctor!.firstName.toString()}'
                            ' ${controller.pastAppointments[index].doctor!.lastName.toString()}',
                            style: AppTextStyle.doctorNameTitle,
                          ),
                          AppSizeBox.height_005,
                          Text(
                            '${DateFormat("yMMMd").format(controller.pastAppointments[index].bookingDate!)} at'
                            ' ${controller.pastAppointments[index].bookingTime}',
                            style: TextStyles.darkPlain14,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        controller
                            .pastAppointments[index].status!.capitalizeFirst
                            .toString(),
                        style: controller.pastAppointments[index].status
                                    .toString() ==
                                'pending'
                            ? TextStyles.pendingText
                            : controller.pastAppointments[index].status
                                        .toString() ==
                                    'rejected'
                                ? TextStyles.rejectText
                                : controller.pastAppointments[index].status
                                            .toString() ==
                                        'cancelled'
                                    ? TextStyles.cancelledText
                                    : TextStyles.acceptText,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: controller.pastAppointments.length,
            ),
          );
  });
}
