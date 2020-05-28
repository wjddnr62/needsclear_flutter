import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Util/mainMove.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddressFind extends StatefulWidget {
  @override
  _AddressFind createState() => _AddressFind();
}

class _AddressFind extends State<AddressFind> {
  AppBar appBar;
  WebViewController webViewController;

  String address;
  String zoneCode;

  addressDialog(url) {
    return showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            backgroundColor: white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: appBar = AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        centerTitle: true,
        title: mainMove("주소검색", context),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            appBar.preferredSize.height,
        child: WebView(
          initialUrl: "http://aladin.oig.kr/daum/daumapi.php",
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          debuggingEnabled: true,
          onPageStarted: (value) {
            print("start : $value");
          },
          onPageFinished: (value) async {
            print("finish : $value");
//            addressDialog(value);
          },
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'address',
                onMessageReceived: (JavascriptMessage msg) {
                  print("address : " + msg.message);
                  address = msg.message;
                  saveData.address = address;
                  if (address != null && zoneCode != null) {
                    Navigator.of(context).pop(true);
                  }
                }),
            JavascriptChannel(
                name: 'zonecode',
                onMessageReceived: (JavascriptMessage msg) {
                  print("zonecode : " + msg.message);
                  zoneCode = msg.message;
                  saveData.zoneCode = zoneCode;
                  if (address != null && zoneCode != null) {
                    Navigator.of(context).pop(true);
                  }
                }),
          ]),
          onWebViewCreated: (WebViewController webViewController) {
            this.webViewController = webViewController;
          },
        ),
      ),
    );
  }
}
