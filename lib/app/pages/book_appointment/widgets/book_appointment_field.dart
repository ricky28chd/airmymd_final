// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:airmymd/app/app.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

///Method for displaying Calender on [BookAppointmentScreen].
Widget bookAppointmentCalender() {
  return GetBuilder<BookAppointmentController>(builder: (controller) {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      rowHeight: 50,
      daysOfWeekHeight: 30,
      headerStyle: const HeaderStyle(
          headerPadding: EdgeInsets.symmetric(vertical: 15),
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyles.darkBlack16,
          leftChevronPadding: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.zero),
      daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyles.darkBlack15,
          weekendStyle: TextStyles.darkBlack15),
      focusedDay: controller.focusDay,
      onDaySelected: controller.selectNewDate,
      selectedDayPredicate: (DateTime date) {
        return isSameDay(controller.selectedDay, date);
      },
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(3000),
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        selectedDecoration: BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primaryColor),
        todayTextStyle: TextStyles.plainDark15,
        todayDecoration: BoxDecoration(
            shape: BoxShape.circle, color: AppColors.greyColorMainHeading),
        defaultTextStyle: TextStyles.darkPlain15,
        weekendTextStyle: TextStyles.darkPlain15,
      ),
    );
  });
}

///Method for displaying available slots on the [BookAppointmentScreen].
Widget availableSlots() {
  return GetBuilder<BookAppointmentController>(builder: (controller) {
    return controller.timeSlotError != ''
        ? Center(
            child: Text(
            controller.timeSlotError,
            textAlign: TextAlign.center,
          ))
        : GridView.builder(
            primary: false,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  controller.selectSlot(controller.timeSlots[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: controller.selectedSlot
                              .contains(controller.timeSlots[index])
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: controller.selectedSlot
                                .contains(controller.timeSlots[index])
                            ? AppColors.whiteColor
                            : AppColors.darkText,
                      ),
                      AppSizeBox.width_2,
                      Text(
                        controller.timeSlots[index],
                        style: controller.selectedSlot
                                .contains(controller.timeSlots[index])
                            ? TextStyles.whitePlain12
                            : TextStyles.darkMedium12,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: controller.timeSlots.length,
          );
  });
}

///Method for displaying Reason box on [BookAppointmentScreen], in
///which user can tell their problems.
Widget reasonBox() {
  return GetBuilder<BookAppointmentController>(builder: (controller) {
    return TextFormField(
      controller: controller.reasonController,
      cursorColor: AppColors.primaryColor,
      maxLines: 6,
      decoration: InputDecoration(
        hintText: 'Enter Here...',
        contentPadding: const EdgeInsets.all(10),
        hintStyle: AppTextStyle.textFieldHint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.blackColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColors.blackColor),
        ),
      ),
    );
  });
}
