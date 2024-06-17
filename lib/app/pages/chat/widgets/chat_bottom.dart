import 'package:airmymd/app/app.dart';

class ChatBottom extends StatelessWidget {
  const ChatBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (controller) {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, bottom: 10, top: 10, right: 20),
          //height: controller.image != null ? Get.height * 0.20 : 60,
          width: double.infinity,
          color: AppColors.whiteColor,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  controller.getImage();
                },
                child: const Icon(
                  Icons.add_circle,
                  size: 30,
                  color: AppColors.primaryColor,
                ),
              ),
              AppSizeBox.width_2,
              Expanded(
                child: controller.image != null
                    ? Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(10),
                        // height: Get.height * 0.15,
                        width: Get.width * 0.70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.greyText, width: 1)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 5),
                                  child: Image.file(
                                    controller.image!,
                                    scale: 14.0,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.image = null;
                                    controller.update();
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                maxLines: 5,
                                minLines: 1,
                                controller: controller.sendMessageController,
                                decoration: InputDecoration(
                                    // prefixIcon: GestureDetector(
                                    //   onTap: () {
                                    //     controller.getImage();
                                    //   },
                                    //   child: const Icon(
                                    //     Icons.add_circle,
                                    //     size: 30,
                                    //     color: AppColors.primaryColor,
                                    //   ),
                                    // ),
                                    hintText: "Write message...",
                                    contentPadding: const EdgeInsets.only(
                                        right: 20, left: 5),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: AppColors
                                                .greyColorMainHeading)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: AppColors
                                                .greyColorMainHeading)),
                                    hintStyle: AppTextStyle.textFieldHint,
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                      )
                    : TextField(
                        maxLines: 5,
                        minLines: 1,
                        controller: controller.sendMessageController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            contentPadding:
                                const EdgeInsets.only(right: 20, left: 20),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: AppColors.greyColorMainHeading)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: AppColors.greyColorMainHeading)),
                            hintStyle: AppTextStyle.textFieldHint,
                            border: InputBorder.none),
                      ),
              ),
              AppSizeBox.width_3,
              GestureDetector(
                onTap: () {
                  controller.scrollController.position.maxScrollExtent;

                  // messages.add(ChatMessage(
                  //     id: controller.userId,
                  //     messageContent: controller.sendMessageController.text,
                  //     dateTime: DateTime.now().toString(),
                  //     messageType: 'receiver',
                  //     mediaURL: []));
                  controller.sendMessage();

                  controller.update();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Icon(
                      Icons.send,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
