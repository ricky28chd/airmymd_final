// ignore_for_file: prefer_const_constructors

import 'package:airmymd/app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable

// ignore: must_be_immutable
class AirmymdWebViewWidget extends StatefulWidget {
  const AirmymdWebViewWidget({super.key, required this.url});
  final String url;

  @override
  State<AirmymdWebViewWidget> createState() => _AirmymdWebViewWidgetState();
}

class _AirmymdWebViewWidgetState extends State<AirmymdWebViewWidget> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          }))
      ..setBackgroundColor(Colors.white)
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        title: Image.asset(
          AppImages.logo,
          height: 70,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (isLoading == true)
            Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            )
        ],
      ),
    );
  }
}
