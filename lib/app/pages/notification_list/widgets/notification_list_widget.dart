import 'package:airmymd/app/app.dart';
import 'package:intl/intl.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationListController>(builder: (controller) {
      return controller.notifications.isEmpty
          ? SizedBox(
              height: Get.height - Get.height * 0.10,
              child: Center(
                  child: Text(controller.errorText.isNotEmpty
                      ? 'Nothing here!!!'
                      : '')))
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    final serverTime = DateTime.utc(
                            controller.notifications[index].createdAt!.year,
                            controller.notifications[index].createdAt!.month,
                            controller.notifications[index].createdAt!.day,
                            controller.notifications[index].createdAt!.hour,
                            controller.notifications[index].createdAt!.minute)
                        .toLocal();

                    final notificationTime =
                        DateFormat('h:mm a').format(serverTime);
                    return ListTile(
                      onTap: () {
                        print('dkdd ${controller.notifications[index].title}');
                        if (controller.notifications[index].title ==
                            'Received a Note.') {
                          NavigateTo.goToNotesScreen();
                          Get.find<NotesController>().selectedButton =
                              'Shared Notes';
                        } else {
                          appointmentId = controller.notifications[index].id!;
                          NavigateTo.goToAppointmentListScreen();
                        }
                      },
                      horizontalTitleGap: 8,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '${controller.notifications[index].title}',
                        style: TextStyles.darkBold13,
                      ),
                      subtitle: Text(
                        '${controller.notifications[index].message}',
                        style: TextStyles.darkPlain14,
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            notificationTime,
                            style: TextStyles.darkBold13,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return const Divider();
                  },
                  itemCount: controller.notifications.length),
            );
    });
  }
}
