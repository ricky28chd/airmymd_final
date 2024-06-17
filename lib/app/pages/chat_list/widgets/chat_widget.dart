import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatListController>(builder: (controller) {
      return controller.conversationList.isEmpty
          ? Center(
              child: Text(
                  controller.errorText.isEmpty ? '' : 'No chats available'),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: AppPadding.outerScreenPadding,
                child: Column(
                  children: [
                    AppSizeBox.height_3,
                    ListView.separated(
                      primary: true,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        ///change dynamic type date to the dateTime type.
                        final changeTimeType = controller
                                    .conversationList[index]
                                    .latestMsg!
                                    .createdAt ==
                                null
                            ? controller
                                .conversationList[index].latestMsg!.createdAt
                            : DateTime.parse(controller
                                .conversationList[index].latestMsg!.createdAt);

                        ///change server datetime to the local datetime.
                        final serverTime = controller.conversationList[index]
                                    .latestMsg!.createdAt ==
                                null
                            ? controller
                                .conversationList[index].latestMsg!.createdAt
                            : DateTime.utc(
                                    changeTimeType.year,
                                    changeTimeType.month,
                                    changeTimeType.day,
                                    changeTimeType.hour,
                                    changeTimeType.minute)
                                .toLocal();

                        ///change the format odf datetime.
                        final latmessageTime = controller
                                    .conversationList[index]
                                    .latestMsg!
                                    .createdAt ==
                                null
                            ? ''
                            : DateFormat('h:mm a').format(serverTime);
                        return ListTile(
                          onTap: () {
                            NavigateTo.goToChatScreen(
                                navigateFrom: ' ',
                                userdId: controller.conversationList[index].id
                                    .toString(),
                                image: controller
                                    .conversationList[index].profilePhotoUrl
                                    .toString(),
                                doctorName:
                                    '${controller.conversationList[index].profile!.firstName} ${controller.conversationList[index].profile!.lastName}');
                          },
                          contentPadding: const EdgeInsets.all(0),
                          leading: SizedBox(
                            height: 100,
                            width: Get.width * 0.15,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.containerBackground,
                                      image: controller.conversationList[index]
                                                  .profilePhotoUrl!.isEmpty &&
                                              controller.conversationList[index]
                                                      .profilePhotoUrl! ==
                                                  'null'
                                          ? const DecorationImage(
                                              scale: 2.5,
                                              image: AssetImage(
                                                  AppImages.profileIcon))
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              scale: 2.5,
                                              image: CachedNetworkImageProvider(
                                                  '${controller.conversationList[index].profilePhotoUrl}'))),
                                ),
                                // const Align(
                                //   alignment: Alignment.bottomRight,
                                //   child: Icon(
                                //     Icons.circle,
                                //     size: 15,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          title: Text(
                            'Dr. ${controller.conversationList[index].profile!.firstName} ${controller.conversationList[index].profile!.lastName}',
                            style: AppTextStyle.doctorNameTitle,
                          ),
                          subtitle: Text(
                            '${controller.conversationList[index].latestMsg!.message}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                controller.conversationList[index].unread == 0
                                    ? TextStyles.lastMessagseText
                                    : TextStyles.darkBold13,
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.conversationList[index].latestMsg!
                                            .createdAt ==
                                        null
                                    ? ''
                                    : latmessageTime,
                                style: TextStyles.timeText,
                              ),
                              AppSizeBox.height_1,
                              controller.conversationList[index].unread == 0
                                  ? const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.transparent,
                                    )
                                  : CircleAvatar(
                                      radius: 12,
                                      child: Text(
                                        '${controller.conversationList[index].unread}',
                                        style: TextStyles.whitePlain12,
                                      ),
                                    ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          thickness: 1,
                        );
                      },
                      itemCount: controller.conversationList.length,
                    )
                  ],
                ),
              ),
            );
    });
  }
}
