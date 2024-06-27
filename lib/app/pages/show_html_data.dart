import 'package:airmymd/app/pages/pages.dart';
import 'package:flutter_size/flutter_size.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaitentsLoginScreen extends StatefulWidget {
  const PaitentsLoginScreen({super.key});

  @override
  State<PaitentsLoginScreen> createState() => _PaitentsLoginScreenState();
}

class _PaitentsLoginScreenState extends State<PaitentsLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {
                  "==> 2. ==>".logPrint;
                },
                onPageFinished: (String url) {
                  "==> 3. ==>".logPrint;
                },
                onUrlChange: (value) {
                  "==> 5. ${value.url}==>".logPrint;
                },
                onHttpAuthRequest: (request) {
                  "==> 6. ${request.host} ${request.realm} ==>".logPrint;
                },
                onHttpError: (HttpResponseError error) {
                  "==> 7. ${error.response} ==>".logPrint;
                },
                onWebResourceError: (WebResourceError error) {
                  "==> 4. ${error.description} ==>".logPrint;
                },
                onNavigationRequest: (NavigationRequest request) {
                  // "here iam ==> 1. ${request.url} ==>".logPrint;
                  var uri = Uri.parse(request.url);
                  String? code = uri.queryParameters['code'];
                  print('code -=-=-=--=-=-=--=-=-=-=-=- $code');

                  if (request.url
                      .startsWith('com.project.airmymd://callback')) {
                    Navigator.of(context).pop();
                    return NavigationDecision.prevent;
                    // return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(
                'https://nativeapi.nextgen.com/nge/prod/nge-oauth/authorize?client_id=7a84c548-6fee-436e-9a2c-2582f8245cfb&redirect_uri=com.project.airmymd://callback&response_type=code'))),
    );
  }
}
