import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/book_appointment/widgets/book_appointment_field.dart';
import 'package:airmymd/app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum UserType { Self, Family }

class BookAppointmentWidget extends StatefulWidget {
  const BookAppointmentWidget({Key? key}) : super(key: key);

  @override
  State<BookAppointmentWidget> createState() => _BookAppointmentWidgetState();
}

class _BookAppointmentWidgetState extends State<BookAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookAppointmentController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppPadding.outerScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizeBox.height_2,
              const Text(
                PageConstants.kSelectDate,
                style: TextStyles.greyMainHeading,
              ),

              ///Calender==Method===============================================
              bookAppointmentCalender(),
              AppSizeBox.height_2,
              const Text(
                PageConstants.kAvailableSlots,
                style: TextStyles.greyMainHeading,
              ),
              AppSizeBox.height_2,

              ///Slots==Method==================================================
              availableSlots(),
              AppSizeBox.height_2,

              const Text(
                PageConstants.kAppointmentFor,
                style: TextStyles.greyMainHeading,
              ),

              /// Select user radio button ====================================
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      visualDensity: const VisualDensity(horizontal: -4.0),
                      dense: false,
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      title: const Text('Self'),
                      leading: Radio<UserType>(
                        activeColor: AppColors.primaryColor,
                        value: UserType.Self,
                        groupValue: controller.userType,
                        onChanged: controller.updateUserType,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      visualDensity: const VisualDensity(horizontal: -4.0),
                      dense: false,
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      title: const Text('Family'),
                      leading: Radio<UserType>(
                        activeColor: AppColors.primaryColor,
                        value: UserType.Family,
                        groupValue: controller.userType,
                        onChanged: controller.updateUserType,
                      ),
                    ),
                  ),
                ],
              ),
              controller.userType == UserType.Self ||
                      controller.userType == null
                  ? const SizedBox()
                  : DropdownButtonFormField(
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.textFieldBorder)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldBorder))),
                      hint: const Text('Select User'),
                      value: controller.selectedChildId,
                      items: controller.childUsers.map((val) {
                        return DropdownMenuItem(
                          value: val.childId.toString(),
                          child: Text(
                              '${val.childPatientProfile.firstName} ${val.childPatientProfile.lastName}' ??
                                  'Unknown'),
                        );
                      }).toList(),
                      onChanged: controller.updateChildId),

              AppSizeBox.height_2,

              const Text(
                PageConstants.kReason,
                style: TextStyles.greyMainHeading,
              ),
              AppSizeBox.height_2,

              ///ReasonBox==Method==============================================
              reasonBox(),
              AppSizeBox.height_5,
              bookAppointmentButton(),
              AppSizeBox.height_10
            ],
          ),
        ),
      );
    });
  }
}
