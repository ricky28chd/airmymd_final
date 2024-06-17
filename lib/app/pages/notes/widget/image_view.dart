import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../../app.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: InteractiveViewer(
              child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) {
                    return Image.file(File(url));
                  },
                  progressIndicatorBuilder:
                      (BuildContext, String, DownloadProgress) {
                    return const SizedBox(
                        height: 40, child: CupertinoActivityIndicator());
                  },
                  imageUrl: url),
            ),
          ),
        ));
  }
}
