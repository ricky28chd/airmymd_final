import 'package:airmymd/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColor,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      controller.goBackToChatList();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  AppSizeBox.height_1,
                  Container(
                    height: Get.height * 0.05,
                    width: Get.width * 0.10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.containerBackground,
                        image: controller.doctorImage == null
                            ? const DecorationImage(
                                scale: 2.5,
                                image: AssetImage(AppImages.profileIcon))
                            : DecorationImage(
                                fit: BoxFit.cover,
                                scale: 2.5,
                                image: CachedNetworkImageProvider(
                                    controller.doctorImage))),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Dr. ${controller.doctorName}",
                          style: TextStyles.whiteBold15,
                        ),
                        AppSizeBox.height_005,
                        // Text(
                        //   "Online",
                        //   style: TextStyles.whitePlain12,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ChatWidget(),
      );
    });
  }
}
