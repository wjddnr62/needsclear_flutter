import 'dart:convert';

import 'package:aladdinmagic/Home/Chauffeur/chauffeur.dart';
import 'package:aladdinmagic/Home/Exchange/exchange.dart';
import 'package:aladdinmagic/Home/Internet/internet.dart';
import 'package:aladdinmagic/Home/Laundry/laundry.dart';
import 'package:aladdinmagic/Home/delivery.dart';
import 'package:aladdinmagic/Home/invitation.dart';
import 'package:aladdinmagic/Home/recommendation.dart';
import 'package:aladdinmagic/Login/combinelogin.dart';
import 'package:aladdinmagic/Model/datastorage.dart';
import 'package:aladdinmagic/Model/pointmanage.dart';
import 'package:aladdinmagic/Provider/provider.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/showToast.dart';
import 'package:aladdinmagic/Util/text.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Phone/phone.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  DateTime currentBackPressTime;
  UserProvider userProvider = UserProvider();
  SharedPreferences prefs;
  WebViewController _webViewController;
  String initialUrl = "";

  bool firstLoad = false;
  String loadCompleteUrl;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool dlAuto = false;

  Future<bool> onWillPop() {
    if (loadCompleteUrl == null) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        showToast("한번 더 누르면 종료됩니다.");
        return Future.value(false);
      }
      return Future.value(true);
    } else {
      _webViewController.currentUrl().then((value) {
        if (value != loadCompleteUrl) {
          _webViewController.goBack();
        } else {
          setState(() {
            viewPage = 0;
            loadCompleteUrl = null;
            firstLoad = false;
          });
        }
      });
      return null;
    }
  }

  sharedLogout() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("autoLogin", 0);
    await prefs.setString("id", "");
    await prefs.setString("pass", "");
    await prefs.setString("bankName", "");
    await prefs.setString("account", "");
    await prefs.setString("accountNumber", "");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => CombineLogin(
                  authCheck: 1,
                )),
        (route) => false);
  }

  int viewPage = 0;

  List<String> resource = [
    'assets/needsclear/alliance/driver.png',
    'assets/needsclear/alliance/flower.png',
    'assets/needsclear/alliance/quick.png',
    'assets/needsclear/alliance/needsbox.png',
    'assets/needsclear/alliance/mobile.png',
    'assets/needsclear/alliance/internet.png',
    'assets/needsclear/alliance/express.png',
    'assets/needsclear/alliance/primaturity.png',
    'assets/needsclear/alliance/car-insurance.png',
    'assets/needsclear/alliance/rental.png',
//    'assets/needsclear/alliance/film.png',
    'assets/needsclear/alliance/laundry.png',
    'assets/needsclear/alliance/rentcar.png',
  ];

  List<String> resourceName = [
    '대리운전',
    '꽃배달',
    '퀵서비스',
    '알라딘박스',
    '휴대폰가입',
    '인터넷가입',
    '택배',
    '후불상조',
    '자동차 보험',
    '렌탈 서비스',
//    '영화표 예매',
    '세탁신청',
    '렌트카',
  ];

  List<String> resourcePlus = [
    'assets/needsclear/alliance/driver.png',
    'assets/needsclear/alliance/flower.png',
    'assets/needsclear/alliance/quick.png',
    'assets/needsclear/alliance/needsbox.png',
    'assets/needsclear/alliance/mobile.png',
    'assets/needsclear/alliance/internet.png',
    'assets/needsclear/alliance/express.png',
    'assets/needsclear/alliance/primaturity.png',
    'assets/needsclear/alliance/car-insurance.png',
    'assets/needsclear/alliance/rental.png',
    'assets/needsclear/alliance/film.png',
    'assets/needsclear/alliance/laundry.png',
    'assets/needsclear/alliance/rentcar.png',
  ];

  List<String> resourceNamePlus = [
    '대리운전',
    '꽃배달',
    '퀵서비스',
    '알라딘박스',
    '휴대폰가입',
    '인터넷가입',
    '택배',
    '후불상조',
    '자동차 보험',
    '렌탈 서비스',
    '영화표 예매',
    '세탁신청',
    '렌트카',
  ];

  ScrollController _scrollController = ScrollController();

  onTopScroll() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  int bottomIdx = 0;

  customDialog(msg) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "알림",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromARGB(255, 167, 167, 167),
                  ),
                  whiteSpaceH(20),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 167, 167, 167)),
                            child: Center(
                              child: Text(
                                "확인",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  webView(url) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (_webController) {
        _webController.clearCache();
        _webViewController = _webController;
      },
      onPageFinished: (url) {
        if (firstLoad == false) {
          loadCompleteUrl = url;
          firstLoad = true;
        }
      },
    );
  }

  String image;

  serviceList(index, type) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: white,
          border:
          Border.all(width: 2, color: Color.fromARGB(255, 245, 245, 245))),
      child: Center(
        child: GestureDetector(
          onTap: () async {
            // type 0 = 꽃배달, 1 = 퀵서비스, 2 = 대리운전
            String name;
            if (type == 0) {
              name = resourceName[index];
              image = resource[index];
            } else {
              name = resourceNamePlus[index];
              image = resourcePlus[index];
            }

            if (name == "꽃배달") {
//              userProvider.addCallLog({
//                'id': saveData.id,
//                'phone': saveData.phoneNumber,
//                'call': "18005139",
//                'type': 0
//              });
              await launch("tel:18005139");
            } else if (name == "퀵서비스") {
//              userProvider.addCallLog({
//                'id': saveData.id,
//                'phone': saveData.phoneNumber,
//                'call': "15888290",
//                'type': 1
//              });
              await launch("tel:15888290");
            } else if (name == "대리운전") {
//              userProvider.addCallLog({
//                'id': saveData.id,
//                'phone': saveData.phoneNumber,
//                'call': "18009455",
//                'type': 2
//              });
              await launch("tel:18009455");
            } else if (name == "알라딘박스") {
              setState(() {
                initialUrl =
                "https://play.google.com/store/apps/details?id=com.apsolution.safebox&hl=ko";
                viewPage = 4;
              });
//              await launch(
//                  "https://play.google.com/store/apps/details?id=com.apsolution.safebox&hl=ko");
            } else if (name == "택배") {
              final page = Delivery();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => page));
            } else if (name == "자동차 보험") {
              setState(() {
                initialUrl = "https://esti.goodcar-direct.com/CB500002";
                viewPage = 4;
              });
//              await launch("https://esti.goodcar-direct.com/CB500002");
            } else if (name == "후불상조") {
              setState(() {
                initialUrl = "https://www.dhsangjo.xyz";
                viewPage = 4;
              });
//              await launch("https://www.dhsangjo.xyz");
            } else if (name == "렌탈 서비스") {
              setState(() {
                initialUrl = "http://rs222.tbmrs.com/index.do";
                viewPage = 4;
              });
//              await launch(
//                "http://rs222.tbmrs.com/index.do",
//              );
            } else if (name == "휴대폰가입") {
              setState(() {
                initialUrl = "http://aladin.oig.kr/phone/index.html";
                viewPage = 4;
              });
//              await launch("http://aladin.oig.kr/phone/index.html");
            } else if (name == "인터넷가입") {
              setState(() {
                initialUrl = "http://aladin.oig.kr/internet/index.html";
                viewPage = 4;
              });
//              await launch("http://aladin.oig.kr/internet/index.html");
            } else if (name == "세탁신청") {
              final page = Laundry();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => page));
            } else {
              customDialog("서비스 준비 중입니다.");
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "${type == 0 ? resource[index] : resourcePlus[index]}",
                width: 56,
              ),
              Text(
                "${type == 0 ? resourceName[index] : resourceNamePlus[index]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: black, fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }

  Provider provider = Provider();

  initManage() async {
    await provider.pointManageSelect().then((value) async {
      print(json.decode(value)['data']);
      List<dynamic> data = await json.decode(value)['data'];
      List<PointManage> pointManage = List();

      for (int i = 0; i < data.length; i++) {
        pointManage.add(PointManage(
          idx: data[i]['idx'],
          type: data[i]['type'],
          serviceType: data[i]['serviceType'],
          rewordType: data[i]['rewordType'],
          myselfPercent: data[i]['myselfPercent'],
          directlyPercent: data[i]['directlyPercent'],
          indirectPercent: data[i]['indirectPercent'],
          myselfPoint: data[i]['myselfPoint'],
          directlyPoint: data[i]['directlyPoint'],
          indirectPoint: data[i]['indirectPoint'],
        ));
      }
//      print(json.decode(value)['data']);
      dataStorage.pointManage = pointManage;
    });
  }

  @override
  void initState() {
    super.initState();

    if (dataStorage.user.autoSale == 0) {
      dlAuto = false;
    } else {
      dlAuto = true;
    }

    initManage();
  }

  drawerUi() {
    return Drawer(
      elevation: 0.0,
      child: SingleChildScrollView(
        child: Container(
          color: white,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              whiteSpaceH(MediaQuery
                  .of(context)
                  .padding
                  .top),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 52,
                color: white,
                padding: EdgeInsets.all(14),
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                        "assets/needsclear/resource/home/close.png"),
                  ),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 94,
                color: white,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${dataStorage.user.name}",
                            style: TextStyle(
//                            decoration: TextDecoration.underline,
                                color: mainColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                          whiteSpaceH(3),
                          Text(
                            "${dataStorage.user.phone.substring(
                                0, 3)}-${dataStorage.user.phone.substring(
                                3, 7)}-${dataStorage.user.phone.substring(
                                7, 11)}",
                            style: TextStyle(
                                color: Color(0xFF666666),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: dataStorage.user.type == 0
                                ? Container()
                                : Image.asset(
                              "assets/needsclear/resource/home/pbm.png",
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              sharedLogout();
                            },
                            child: Text(
                              "로그아웃",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFF888888),
                                  fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 56,
                color: Color(0xFFF7F7F7),
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Text(
                      "프리미엄 회원 모집안내!",
                      style: TextStyle(
                          color: Color(0xFF444444),
                          fontSize: 14,
                          fontFamily: 'noto',
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              whiteSpaceH(12),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 56,
                child: RaisedButton(
                  onPressed: () {},
                  elevation: 0.0,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  color: Color(0xFF00AAFF),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/needsclear/resource/public/dl-coin.png",
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                      whiteSpaceW(8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "나의 DL",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 12,
                                  color: white),
                            ),
                            Text(
                              "${numberFormat.format(dataStorage.user.dl)} DL",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: white),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/needsclear/resource/public/next-wt.png",
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                ),
              ),
              whiteSpaceH(28),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 48,
                color: white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "자동판매 설정",
                            style: TextStyle(
                                fontFamily: 'noto',
                                color: black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        setState(() {
                          dlAuto = value;
                        });
                      },
                      value: dlAuto,
                      activeColor: Color(0xFF00BBCC),
                      hoverColor: white,
                    )
                  ],
                ),
              ),
              whiteSpaceH(12),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 48,
                child: RaisedButton(
                  onPressed: () {},
                  color: white,
                  elevation: 0.0,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "공지사항",
                      style: TextStyle(
                        fontFamily: 'noto',
                        fontSize: 14,
                        color: black,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 48,
                child: RaisedButton(
                  onPressed: () {},
                  color: white,
                  elevation: 0.0,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "FAQ",
                      style: TextStyle(
                        fontFamily: 'noto',
                        fontSize: 14,
                        color: black,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 48,
                child: RaisedButton(
                  onPressed: () {},
                  color: white,
                  elevation: 0.0,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "서비스 이용문의",
                      style: TextStyle(
                        fontFamily: 'noto',
                        fontSize: 14,
                        color: black,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 48,
                child: RaisedButton(
                  onPressed: () {},
                  color: white,
                  elevation: 0.0,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "약관 및 정책",
                      style: TextStyle(
                        fontFamily: 'noto',
                        fontSize: 14,
                        color: black,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 48,
                child: RaisedButton(
                  onPressed: () {},
                  color: white,
                  elevation: 0.0,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "앱 정보",
                          style: TextStyle(
                            fontFamily: 'noto',
                            fontSize: 14,
                            color: black,
                          ),
                        ),
                        whiteSpaceW(12),
                        Text(
                          "V.1.0.0",
                          style: TextStyle(
                              fontFamily: 'noto',
                              color: Color(0xFF00BBCC),
                              fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: white,
            resizeToAvoidBottomInset: true,
            drawer: drawerUi(),
            appBar: viewPage == 0
                ? appBar = AppBar(
              backgroundColor: white,
              elevation: 0.0,
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/Home", (Route<dynamic> route) => false);
                },
                child: Text(
                  "NEEDS CLEAR",
                  style: TextStyle(
                      fontSize: 20,
                      color: black,
                      fontFamily: 'noto',
                      fontWeight: FontWeight.w600),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                icon: Image.asset(
                  "assets/needsclear/resource/home/menu.png",
                  width: 24,
                  height: 24,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/needsclear/resource/home/notice-new.png",
                    width: 24,
                    height: 24,
                  ),
                )
              ],
            )
                : viewPage == 3 ? null : null,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (idx) {
                if (idx == 0) {
                  setState(() {
                    bottomIdx = idx;
                    viewPage = 0;
                  });
                } else if (idx == 1) {
                  setState(() {
                    bottomIdx = idx;
                    viewPage = 1;
                  });
                } else if (idx == 2) {
                  setState(() {
                    bottomIdx = idx;
                    viewPage = 2;
                  });
                } else if (idx == 3) {
                  setState(() {
                    bottomIdx = idx;
                    viewPage = 3;
                  });
                }
              },
              currentIndex: bottomIdx,
              iconSize: 24,
              selectedLabelStyle:
              TextStyle(color: black, fontSize: 10, fontFamily: 'noto'),
              unselectedLabelStyle: TextStyle(
                  color: Color(0xFFAAAAAA), fontSize: 10, fontFamily: 'noto'),
              elevation: 12,
              backgroundColor: white,
              unselectedFontSize: 14,
              selectedFontSize: 14,
              items: [
                BottomNavigationBarItem(
                    title: customText(StyleCustom(
                        text: "홈",
                        color: viewPage == 0 ? black : Color(0xFFAAAAAA))),
                    backgroundColor: white,
                    icon: Image.asset(
                      viewPage == 0
                          ? "assets/needsclear/resource/home/bottom/home-color.png"
                          : "assets/needsclear/resource/home/bottom/home.png",
                      width: 24,
                      height: 24,
                    )),
                BottomNavigationBarItem(
                    title: customText(StyleCustom(
                        text: "추천인관리",
                        color: viewPage == 1 ? black : Color(0xFFAAAAAA))),
                    backgroundColor: white,
                    icon: Image.asset(
                      viewPage == 1
                          ? "assets/needsclear/resource/home/bottom/friends-color.png"
                          : "assets/needsclear/resource/home/bottom/friends.png",
                      width: 24,
                      height: 24,
                    )),
                BottomNavigationBarItem(
                    title: customText(StyleCustom(
                        text: "포인트관리",
                        color: viewPage == 2 ? black : Color(0xFFAAAAAA))),
                    backgroundColor: white,
                    icon: Image.asset(
                      viewPage == 2
                          ? "assets/needsclear/resource/home/bottom/point-color.png"
                          : "assets/needsclear/resource/home/bottom/point.png",
                      width: 24,
                      height: 24,
                    )),
                BottomNavigationBarItem(
                    title: customText(StyleCustom(
                        text: "이벤트",
                        color: viewPage == 3 ? black : Color(0xFFAAAAAA))),
                    backgroundColor: white,
                    icon: Image.asset(
                      viewPage == 3
                          ? "assets/needsclear/resource/home/bottom/event-color.png"
                          : "assets/needsclear/resource/home/bottom/event.png",
                      width: 24,
                      height: 24,
                    )),
              ],
            ),
            body: viewPage == 4
                ? webView(initialUrl)
                : Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Stack(
                      children: [
                        Column(
                          children: <Widget>[
                            viewPage == 0
                                ? Column(
                              children: <Widget>[
                                mainHome()
//                                          saveMoneyView(),
//                                          pService()
                              ],
                            )
                                : Container(),
                            viewPage == 1
                                ? aRecommenderManagement()
                                : Container(),
                            viewPage == 2
                                ? pointManagement()
                                : Container(),
                            viewPage == 3 ? Container() : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: onWillPop);
  }

  List<String> serviceName = [
    '렌탈',
    '세탁',
    '자동차보험',
    '상조',
    '대리운전',
    '퀵배송',
    '휴대폰 구매',
    '인터넷가입'
  ];
  List<String> serviceImage = [
    'assets/needsclear/resource/service/rental.png',
    'assets/needsclear/resource/service/washer.png',
    'assets/needsclear/resource/service/insurance.png',
    'assets/needsclear/resource/service/rip.png',
    'assets/needsclear/resource/service/driver.png',
    'assets/needsclear/resource/service/quick.png',
    'assets/needsclear/resource/service/phone.png',
    'assets/needsclear/resource/service/internet.png'
  ];

  mainHome() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 185,
            decoration: BoxDecoration(
                color: Color(0xFFCCCCCC),
                borderRadius: BorderRadius.circular(6)),
          ),
          whiteSpaceH(16),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 88,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 8)
              ],
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/needsclear/resource/home/coin.png",
                            width: 24,
                            height: 24,
                          ),
                          whiteSpaceW(4),
                          Text(
                            "적립금",
                            style: TextStyle(
                                color: mainColor,
                                fontFamily: 'noto',
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                            text:
                            "${numberFormat.format(dataStorage.user.point)}",
                            style: TextStyle(
                                fontFamily: 'noto',
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: 20),
                            children: <TextSpan>[
                              TextSpan(
                                  text: " NCP",
                                  style: TextStyle(
                                      fontFamily: 'noto',
                                      fontSize: 14,
                                      color: black,
                                      fontWeight: FontWeight.w600))
                            ]),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "추천인",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 12,
                                  color: mainColor),
                            ),
                            whiteSpaceH(8),
                            Text(
                              "추천 적립금",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 12,
                                  color: mainColor),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${dataStorage.user.recoPerson}명",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto',
                                  fontWeight: FontWeight.w600),
                            ),
                            whiteSpaceH(8),
                            Text(
                              "${numberFormat.format(
                                  dataStorage.user.point)} NCP",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          whiteSpaceH(24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "주요서비스",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'noto',
                  color: black),
            ),
          ),
          whiteSpaceH(10),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 90,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Center(
                          child: ListView.builder(
                            itemBuilder: (context, idx) {
                              return Padding(
                                padding:
                                EdgeInsets.only(right: idx < 3 ? 12 : 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        width: 64,
                                        height: 64,
                                        child: RaisedButton(
                                          onPressed: () {
                                            if (serviceName[idx] == '렌탈') {
                                              print("렌탈");
                                              setState(() {
                                                initialUrl =
                                                "http://rs222.tbmrs.com/index.do";
                                                viewPage = 4;
                                              });
                                            } else if (serviceName[idx] ==
                                                '세탁') {
                                              print("세탁");
//                                            final page = Laundry();
//                                            Navigator.of(context).pushReplacement(
//                                                MaterialPageRoute(builder: (context) => page));
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Laundry()));
                                            } else if (serviceName[idx] ==
                                                '자동차보험') {
                                              print("자동차보험");
                                              setState(() {
                                                initialUrl =
                                                "https://esti.goodcar-direct.com/CB500002";
                                                viewPage = 4;
                                              });
                                            } else if (serviceName[idx] ==
                                                '상조') {
                                              print("상조");
                                              setState(() {
                                                initialUrl =
                                                "https://www.dhsangjo.xyz";
                                                viewPage = 4;
                                              });
                                            }
                                          },
                                          elevation: 0.0,
                                          padding: EdgeInsets.zero,
                                          color: Color(0xFFF7F7F7),
                                          child: Center(
                                            child: Image.asset(
                                              serviceImage[idx],
                                              width: 48,
                                              height: 48,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    whiteSpaceH(8),
                                    Text(
                                      serviceName[idx],
                                      style: TextStyle(
                                          fontFamily: 'noto',
                                          fontSize: 12,
                                          color: black),
                                    )
                                  ],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                whiteSpaceH(16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 90,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Center(
                          child: ListView.builder(
                            itemBuilder: (context, idx) {
                              return Padding(
                                padding:
                                EdgeInsets.only(right: idx < 3 ? 12 : 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Container(
                                        width: 64,
                                        height: 64,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            if (serviceName[idx + 4] ==
                                                '대리운전') {
                                              print("대리운전");
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Chauffeur()
                                                  ));
                                            } else if (serviceName[idx + 4] ==
                                                '퀵배송') {
                                              print("퀵배송");
                                              await launch("tel:15888290");
                                            } else if (serviceName[idx + 4] ==
                                                '휴대폰 구매') {
                                              print("휴대폰 구매");
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Phone()
                                                  ));
                                            } else if (serviceName[idx + 4] ==
                                                '인터넷가입') {
                                              print("인터넷가입");
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Internet()
                                                  ));
                                            }
                                          },
                                          elevation: 0.0,
                                          padding: EdgeInsets.zero,
                                          color: Color(0xFFF7F7F7),
                                          child: Center(
                                            child: Image.asset(
                                              serviceImage[idx + 4],
                                              width: 48,
                                              height: 48,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    whiteSpaceH(8),
                                    Text(
                                      serviceName[idx + 4],
                                      style: TextStyle(
                                          fontFamily: 'noto',
                                          fontSize: 12,
                                          color: black),
                                    )
                                  ],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          whiteSpaceH(32),
          Stack(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 88,
                decoration: BoxDecoration(
                    color: Color(0xFFCCCCCC),
                    borderRadius: BorderRadius.circular(6)),
              ),
              Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 32,
                    height: 16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Color(0xFFEEEEEE)),
                    child: Center(
                      child: Text(
                        "AD",
                        style: TextStyle(
                            color: black, fontSize: 12, fontFamily: 'noto'),
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  String recoValue = "최신순";
  String pointValue = "최신순";

  aRecommenderManagement() {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              whiteSpaceH(appBar.preferredSize.height),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 88,
                color: white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "나의 추천인",
                          style: TextStyle(
                              fontFamily: 'noto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceW(4),
                        Image.asset(
                          "assets/needsclear/resource/home/bottom/friends-color.png",
                          width: 24,
                          height: 24,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        InkWell(
                          onTap: () {
                            print("추천하기");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Recommendation()));
                          },
                          child: Text(
                            "추천하기 >",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 12,
                                color: Color(0xFF22EEFF),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "${dataStorage.user.recoPerson}",
                                  style: TextStyle(
                                      fontFamily: 'noto',
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: 28),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: " 명",
                                        style: TextStyle(
                                            fontFamily: 'noto',
                                            fontSize: 14,
                                            color: black,
                                            fontWeight: FontWeight.w600))
                                  ]),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        InkWell(
                          onTap: () {
                            print("초대하기");
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Invitation()));
                          },
                          child: Text(
                            "초대하기 >",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 40,
                color: white,
                child: Row(
                  children: [
                    Text(
                      "추천인 적립금",
                      style: TextStyle(
                          fontFamily: 'noto', fontSize: 14, color: black),
                    ),
                    whiteSpaceW(16),
                    Text(
                      "${numberFormat.format(dataStorage.user.point)} NCP",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontFamily: 'noto',
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              whiteSpaceH(16),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 40,
                color: white,
                child: Row(
                  children: [
                    Text(
                      "전체결과",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'noto',
                          fontSize: 14,
                          color: black),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      width: 70,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: DropdownButton<String>(
                          underline: Container(),
                          elevation: 0,
                          style: TextStyle(
                              color: black, fontSize: 14, fontFamily: 'noto'),
                          items: <String>['최신순', '과거순'].map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontFamily: 'noto'),
                              ),
                            );
                          }).toList(),
                          value: recoValue,
                          onChanged: (value) {
                            setState(() {
                              recoValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.zero,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, idx) {
                    return Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            idx == 0
                                ? "assets/needsclear/resource/home/management/friend-first.png"
                                : "assets/needsclear/resource/home/management/friend-second.png",
                            width: 32,
                            height: 32,
                          ),
                          whiteSpaceW(12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(resourceName[idx]),
                              Text(idx.toString())
                            ],
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text("날짜"), Text("By")],
                          )
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: resourceName.length,
                ),
              )
            ],
          )),
    );
  }

  pointManagement() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            whiteSpaceH(appBar.preferredSize.height),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 100,
              padding: EdgeInsets.only(top: 16, bottom: 16),
              color: white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "현재 포인트",
                              style: TextStyle(
                                  color: black,
                                  fontFamily: 'noto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            whiteSpaceW(4),
                            Image.asset(
                              "assets/needsclear/resource/home/bottom/point-color.png",
                              width: 24,
                              height: 24,
                            )
                          ],
                        ),
                        Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 12,
                                color: Color(0xFF22EEFF),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  text:
                                  "${numberFormat.format(
                                      dataStorage.user.point)}",
                                  style: TextStyle(
                                      fontFamily: 'noto',
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: 28),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: " NCP",
                                        style: TextStyle(
                                            fontFamily: 'noto',
                                            fontSize: 14,
                                            color: black,
                                            fontWeight: FontWeight.w600))
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("환전하기");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Exchange()));
                    },
                    child: Text("환전하기 >"),
                  )
                ],
              ),
            ),
            whiteSpaceH(12),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "이달 통계",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'noto',
                      color: black),
                )),
            whiteSpaceH(10),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 72,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 8)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "적립포인트",
                          style: TextStyle(
                              color: Color(0xFF888888),
                              fontFamily: 'noto',
                              fontSize: 12),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/needsclear/resource/home/point/coin-plus.png",
                              width: 24,
                              height: 24,
                            ),
                            whiteSpaceW(12),
                            Text(
                              "${numberFormat.format(1000000)} NCP",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'noto',
                                  color: mainColor,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "지출포인트",
                          style: TextStyle(
                              color: Color(0xFF888888),
                              fontFamily: 'noto',
                              fontSize: 12),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/needsclear/resource/home/point/coin-minus.png",
                              width: 24,
                              height: 24,
                            ),
                            whiteSpaceW(12),
                            Text(
                              "- ${numberFormat.format(1000000)} NCP",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'noto',
                                  color: Color(0xFF003355),
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            whiteSpaceH(16),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 40,
              color: white,
              child: Row(
                children: [
                  Text(
                    "전체결과",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontFamily: 'noto',
                        fontSize: 14),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: 70,
                    padding: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: DropdownButton<String>(
                        underline: Container(),
                        elevation: 0,
                        style: TextStyle(
                            color: black, fontSize: 14, fontFamily: 'noto'),
                        items: <String>['최신순', '과거순'].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto'),
                            ),
                          );
                        }).toList(),
                        value: pointValue,
                        onChanged: (value) {
                          setState(() {
                            pointValue = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            whiteSpaceW(16),
            // 리스트 추가
          ],
        ),
      ),
    );
  }
}
