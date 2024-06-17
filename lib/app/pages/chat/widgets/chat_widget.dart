import 'package:cached_network_image/cached_network_image.dart';
import 'package:airmymd/app/app.dart';
import 'package:airmymd/app/pages/chat/widgets/chat_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as dateTimeChange;

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (controller) {
      return SizedBox(
        height: Get.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                reverse: true,
                shrinkWrap: true,
                primary: false,
                itemCount: messages.length,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  messages.sort((a,b)=>b.dateTime!.compareTo(a.dateTime.toString()));
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment:
                                (messages[index].messageType == "receiver"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                            child: Text(
                              '${date(DateTime.parse(messages[index].dateTime!).toUtc())}',
                              style: TextStyles.greyPlain13,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: messages[index].mediaURL!.isNotEmpty
                                ? const BoxDecoration()
                                : BoxDecoration(
                                    borderRadius: messages[index].messageType ==
                                            "receiver"
                                        ? const BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15))
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15)),
                                    color: (messages[index].messageType ==
                                            "receiver"
                                        ? const Color(0xffFAFAFA)
                                        : const Color(0xffE4E4E4)),
                                  ),
                            padding: const EdgeInsets.all(16),
                            child: messages[index].mediaURL!.isNotEmpty
                                ? Directionality(
                                    textDirection:
                                        messages[index].messageType ==
                                                "receiver"
                                            ? TextDirection.ltr
                                            : TextDirection.rtl,
                                    child: Column(
                                      children: [
                                        GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                            ),
                                            shrinkWrap: true,
                                            itemCount: messages[index]
                                                .mediaURL!
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int ind) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(DetailedImageView(
                                                    imageName: messages[index]
                                                        .mediaURL![ind]
                                                        .toString(),
                                                  ));
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: messages[index]
                                                                .messageType ==
                                                            "receiver"
                                                        ? const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15))
                                                        : const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(15)),
                                                    color: (messages[index]
                                                                .messageType ==
                                                            "receiver"
                                                        ? const Color(
                                                            0xffFAFAFA)
                                                        : const Color(
                                                            0xffE4E4E4)),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 10, 0, 10),
                                                    child: CachedNetworkImage(
                                                      height: 200,
                                                      imageUrl: messages[index]
                                                          .mediaURL![ind]
                                                          .toString(),
                                                      placeholder: (context,
                                                              url) =>
                                                          const CupertinoActivityIndicator(
                                                        color: AppColors
                                                            .blackColor,
                                                        radius: 10,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                        messages[index].messageContent!.isEmpty
                                            ? Container()
                                            : AppSizeBox.height_1,
                                        Align(
                                          alignment:
                                              messages[index].messageType ==
                                                      "receiver"
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: messages[index]
                                                          .messageType ==
                                                      "receiver"
                                                  ? const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15))
                                                  : const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15)),
                                              color: (messages[index]
                                                          .messageType ==
                                                      "receiver"
                                                  ? const Color(0xffFAFAFA)
                                                  : const Color(0xffE4E4E4)),
                                            ),
                                            child: Padding(
                                              padding: messages[index]
                                                      .messageContent!
                                                      .isEmpty
                                                  ? EdgeInsets.zero
                                                  : const EdgeInsets.all(16.0),
                                              child: messages[index]
                                                      .messageContent!
                                                      .isEmpty
                                                  ? Container()
                                                  : Text(
                                                      messages[index]
                                                          .messageContent
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    messages[index].messageContent.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const ChatBottom()
          ],
        ),
      );
    });
  }
}

String month = '';
String? date(DateTime tm) {
  final DateTime serverTime = DateTime.utc(
          int.parse(dateTimeChange.DateFormat('yyyy').format(tm)),
          int.parse(dateTimeChange.DateFormat('MM').format(tm)),
          int.parse(dateTimeChange.DateFormat('dd').format(tm)),
          int.parse(dateTimeChange.DateFormat('HH').format(tm)),
          int.parse(dateTimeChange.DateFormat('mm').format(tm)))
      .toLocal();

  print('$tm :: $serverTime');

//   tm = tm.toLocal();
  DateTime now = DateTime.now();
  //print('$now :: ${now.toUtc()} :: ${now.toUtc().toLocal()}');

  Duration diff = now.difference(tm);

  int days = diff.inDays;

  print('$now :::: $tm :::: $days');

  if (days > 7) {
    return dateTimeChange.DateFormat('MMM dd, yyyy')
        .format(serverTime)
        .toString();
  } else if (days > 1) {
    return dateTimeChange.DateFormat('EEEE')
        .format(serverTime)
        .toString()
        .substring(0, 3);
  } else if (days == 1) {
    return ' Yesterday';
  } else {
    if (dateTimeChange.DateFormat('MMM dd, yyyy').format(now).toString() !=
        dateTimeChange.DateFormat('MMM dd, yyyy')
            .format(serverTime)
            .toString()) {
      return 'Today';
    } else {
      return dateTimeChange.DateFormat('hh:mm a').format(serverTime).toString();
    }
  }
}
