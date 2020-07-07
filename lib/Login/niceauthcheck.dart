import 'package:flutter/material.dart';
import 'package:needsclear/public/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NiceAuthCheck extends StatefulWidget {
  @override
  _NiceAuthCheck createState() => _NiceAuthCheck();
}

class _NiceAuthCheck extends State<NiceAuthCheck> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      body: WebView(
        initialUrl: "http://admin.needsclear.kr/checkplus_main.php",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (_webController) {
          _webController.clearCache();
        },
        onPageStarted: (url) {
          print("start : $url");
        },
        onPageFinished: (url) {
          print(url);
        },
      ),
    );
  }
}
