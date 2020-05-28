import 'dart:convert';

import 'package:aladdinmagic/Home/home.dart';
import 'package:aladdinmagic/Model/datastorage.dart';
import 'package:aladdinmagic/Model/user.dart';
import 'package:aladdinmagic/Model/usercheck.dart';
import 'package:aladdinmagic/Provider/provider.dart';
import 'package:aladdinmagic/SignUp/newsignup.dart';
import 'package:aladdinmagic/Util/parameter.dart';
import 'package:aladdinmagic/Util/showToast.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CombineLogin extends StatefulWidget {
  final int authCheck;

  CombineLogin({this.authCheck});

  @override
  _CombineLogin createState() => _CombineLogin();
}

class _CombineLogin extends State<CombineLogin> {
  WebViewController webViewController;
  String url =
      "http://49.247.3.220/auth_api/oauth/authorize?client_id=needs_clear&redirect_uri=http://localhost:3000&response_type=code";
  String logoutUrl = "http://49.247.3.220/auth_api/users/logout";

  Provider provider = Provider();
  bool userCheck = false;

  bool clearCache = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.authCheck == 1 ? logoutUrl : url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewController) {
                if (!clearCache) {
                  webViewController.clearCache();
                  clearCache = true;
                }
                this.webViewController = webViewController;
              },
              onPageStarted: (url) {
                if (url == "http://49.247.3.220/auth_api/") {
//                  webViewController.clearCache();
                  webViewController.loadUrl(this.url);
                  if (widget.authCheck != 1) {
                    showToast("로그인에 실패하였습니다.");
                  }
                }
              },
              onPageFinished: (url) async {
                print("url : $url");
                List<String> code = List();
                if (url.contains("code") && !url.contains("oauth")) {
                  setState(() {
                    userCheck = true;
                  });
                  code = url.split("=");
                  parameter.oauthCode = code[1];

                  await provider.authToken().then((value) async {
                    dynamic authToken = json.decode(value);
                    print("authToken : ${authToken['access_token']}");
                    // 유저 정보 가져오고 회원정보 있는지 확인 후 홈으로 보낼 지 기본 회원 정보 받는 곳으로 이동할 지 결정

                    if (authToken['access_token'] != null) {
                      await provider
                          .authCheck(authToken['access_token'])
                          .then((value) async {

                        dynamic authCheck = json.decode(value);
                        int sex = 0;

                        if ("MAN" == authCheck['sex']) {
                          sex = 0;
                        } else {
                          sex = 1;
                        }

                        List<String> phoneSplit = List();
                        phoneSplit = authCheck['phone'].toString().split("-");

                        UserCheck userCheck = UserCheck(
                            username: authCheck['username'],
                            name: authCheck['name'],
                            phone: authCheck['phone'],
                            birth: authCheck['birth'],
                            sex: sex);
                        print(userCheck.username);

                        await provider
                            .selectUser(userCheck.username)
                            .then((value) {
                              print(value);
                          dynamic selectUser = json.decode(value);
                          if (selectUser['data'] != null) {
                            User user = User.fromJson(selectUser['data']);

                            dataStorage.user = user;

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => Home()),
                                (Route<dynamic> route) => false);
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => NewSignUp(
                                          userCheck: userCheck,
                                        )),
                                (Route<dynamic> route) => false);
                          }
                        });
                      });
                    }
                  });
                }
              },
            ),
            userCheck
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: white,
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: black,
                        size: 80.0,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
