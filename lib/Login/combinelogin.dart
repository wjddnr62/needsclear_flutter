import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:needsclear/Home/home.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/user.dart';
import 'package:needsclear/Model/usercheck.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/SignUp/newsignup.dart';
import 'package:needsclear/Util/parameter.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/public/colors.dart';
import 'package:needsclear/public/platformViewVerticalGestureRecognizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CombineLogin extends StatefulWidget {
  final int authCheck;

  CombineLogin({this.authCheck});

  @override
  _CombineLogin createState() => _CombineLogin();
}

class _CombineLogin extends State<CombineLogin> {
  WebViewController webViewController;

//  String url =
//      "http://auth.cashlink.kr/auth_api/oauth/authorize?client_id=needs_clear&redirect_uri=http://admin.needsclear.kr/login/index.html&response_type=code";
//  String logoutUrl = "http://auth.cashlink.kr/auth_api/users/logout";

  String url =
      "http://192.168.100.237/auth_api/oauth/authorize?client_id=needs_clear&redirect_uri=http://localhost:3000&response_type=code";
  String logoutUrl = "http://192.168.100.237/auth_api/users/logout";

  Provider provider = Provider();
  bool userCheck = false;

  bool clearCache = false;

  @override
  void initState() {
    super.initState();
  }

  DateTime currentBackPressTime;
  ScrollController scrollController;

  bool textInputCheck = false;
  bool loginView = true;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast("한번 더 누르면 종료됩니다.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 10000),
                  child: WebView(
                    initialUrl: widget.authCheck == 1 ? logoutUrl : url,
                    gestureRecognizers: [
                      Factory(() => PlatformViewVerticalGestureRecognizer()),
                    ].toSet(),
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (webViewController) {
                      if (!clearCache) {
                        webViewController.clearCache();
                        clearCache = true;
                      }
                      this.webViewController = webViewController;
                    },
                    onPageStarted: (url) {
//                        if (url == "http://gateway.cashlink.kr/auth_api/") {
                      if (url == "http://192.168.100.237/auth_api/") {
//                  webViewController.clearCache();
                        webViewController.loadUrl(this.url);
                        if (widget.authCheck != 1) {
                          showToast("로그인에 실패하였습니다.");
                        }
                      }

                      if (url.contains("logout")) {
                        webViewController.loadUrl(this.url);
                      }
                    },
                    onPageFinished: (url) async {
                      print("url : $url");
                      if (url ==
                          "http://192.168.100.237/auth_api/users/login") {
//                        if (url == "http://auth.cashlink.kr/auth_api/users/login") {
                        loginView = true;
                      } else {
                        loginView = false;
                      }

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
                          if (authToken['access_token'] == null) {
                            webViewController.loadUrl(url);
                          }
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
                              phoneSplit =
                                  authCheck['phone'].toString().split("-");

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
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
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
                        }).catchError((error) {
                          webViewController.loadUrl(url);
                        });
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
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
        ),
      ),
    );
  }
}
