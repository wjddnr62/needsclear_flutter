import 'package:aladdinmagic/Home/withdraw.dart';
import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/toast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  DateTime currentBackPressTime;
  FocusNode mainFocus = FocusNode();
  FocusNode pFocus = FocusNode();
  FocusNode eventFocus = FocusNode();
  SaveData saveData = SaveData();
  UserProvider userProvider = UserProvider();
  SharedPreferences prefs;
  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  GoogleSignIn googleSignIn = GoogleSignIn();
  WebViewController _webViewController;
  String initialUrl = "";

  bool firstLoad = false;
  String loadCompleteUrl;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() {
    if (loadCompleteUrl == null) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        showToast(msg: "한번 더 누르면 종료됩니다.", type: 0);
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

  Future<void> googleLogout() async {
    print("googleLogout");
    googleSignIn.disconnect();
  }

  kakaoLogOut() async {
    print("logout");
    final KakaoLoginResult result = await kakaoSignIn.logOut();
    print("logout");
    switch (result.status) {
      case KakaoLoginStatus.loggedIn:
        print('LoggedIn by the user.\n'
            '- UserID is ${result.account.userID}\n'
            '- UserEmail is ${result.account.userEmail} ');

        break;
      case KakaoLoginStatus.loggedOut:
        print('LoggedOut by the user.');
        break;
      case KakaoLoginStatus.error:
        print('This is Kakao error message : ${result.errorMessage}');
        break;
    }
    // To-do Someting ...
  }

  final facebookLogin = FacebookLogin();

  fbLogout() async {
    await facebookLogin.logOut();
  }

  sharedLogout() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("autoLogin", 0);
    await prefs.setString("id", "");
    await prefs.setString("pass", "");

    if (saveData.type != 0) {
      kakaoLogOut();
      googleLogout();
      fbLogout();
    }

    Navigator.of(context)
        .pushNamedAndRemoveUntil("/Login", (Route<dynamic> route) => false);
  }

  int viewPage = 0;

  List<String> resource = [
    'assets/resource/drive.png',
    'assets/resource/flower.png',
    'assets/resource/quick.png',
    'assets/resource/aladdinbox.png',
    'assets/resource/smartPhone2.png',
    'assets/resource/internet2.png',
    'assets/resource/delivery.png',
    'assets/resource/premise.png',
    'assets/resource/insurance.png',
    'assets/resource/rent.png',
    'assets/resource/laundry.png',
    'assets/resource/car.png',
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
    '세탁신청',
    '렌트카',
  ];

  List<String> resourcePlus = [
    'assets/resource/drive.png',
    'assets/resource/flower.png',
    'assets/resource/quick.png',
    'assets/resource/aladdinbox.png',
    'assets/resource/smartPhone2.png',
    'assets/resource/internet2.png',
    'assets/resource/delivery.png',
    'assets/resource/premise.png',
    'assets/resource/insurance.png',
    'assets/resource/rent.png',
    'assets/resource/movie.png',
    'assets/resource/laundry.png',
    'assets/resource/car.png',
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

  customDialog(msg, type) {
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
                            if (type == 0) {
                              Navigator.of(context).pop();
                            }
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

  saveMoneyView() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          color: Color.fromARGB(255, 245, 245, 245),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "현재 적립금",
                    style: TextStyle(
                        color: black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              whiteSpaceH(20),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                        text: "${numberFormat.format(saveData.point)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            fontSize: 28),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Point",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: black,
                                  fontWeight: FontWeight.w600))
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Color.fromARGB(255, 219, 219, 219),
        ),
        GestureDetector(
          onTap: () {
//            Navigator.of(context).pushNamed("/RecoList");
          },
          child: Column(
            children: <Widget>[
              whiteSpaceH(10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/RecoList");
                },
                child: Row(
                  children: <Widget>[
                    whiteSpaceW(5),
                    Icon(Icons.person),
                    Expanded(
                      child: Text("추천인"),
                    ),
                    Text("${saveData.recoPerson}명"),
                    whiteSpaceW(10)
                  ],
                ),
              ),
              whiteSpaceH(3),
              Row(
                children: <Widget>[
                  whiteSpaceW(7),
                  Image.asset(
                    "assets/resource/save_payment.png",
                    width: 20,
                  ),
                  whiteSpaceW(2),
                  Expanded(
                    child: Text("추천인 적립금"),
                  ),
                  Text("${numberFormat.format(saveData.recoPrice)} point"),
                  whiteSpaceW(10)
                ],
              ),
              whiteSpaceH(10),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/Reco");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  color: Colors.black87,
                  child: Column(
                    children: <Widget>[
                      whiteSpaceH(20),
                      Row(
                        children: <Widget>[
                          whiteSpaceW(10),
                          Expanded(
                            child: Text(
                              "추천하기",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: white,
                                  fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: white,
                            size: 20,
                          ),
                          whiteSpaceW(10)
                        ],
                      ),
                      whiteSpaceH(20),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "지인들에게 알라딘매직을 추천하고 적립금을 받으세요!",
                          style: TextStyle(
                            fontSize: 14,
                            color: white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 120,
              color: white,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Withdraw(type: 0)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  color: mainColor,
                  child: Column(
                    children: <Widget>[
                      whiteSpaceH(20),
                      Row(
                        children: <Widget>[
                          whiteSpaceW(10),
                          Expanded(
                            child: Text(
                              "출금하기",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: white,
                                  fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: white,
                            size: 20,
                          ),
                          whiteSpaceW(10)
                        ],
                      ),
                      whiteSpaceH(20),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "적립금을 현금으로 가져가세요!",
                          style: TextStyle(
                            fontSize: 14,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
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
            String image;
            if (type == 0) {
              name = resourceName[index];
              image = resource[index];
            } else {
              name = resourceNamePlus[index];
              image = resourcePlus[index];
            }

            if (name == "꽃배달") {
              userProvider.addCallLog({
                'id': saveData.id,
                'phone': saveData.phoneNumber,
                'call': "18005139",
                'type': 0
              });
              await launch("tel:18005139");
            } else if (name == "퀵서비스") {
              userProvider.addCallLog({
                'id': saveData.id,
                'phone': saveData.phoneNumber,
                'call': "15888290",
                'type': 1
              });
              await launch("tel:15888290");
            } else if (name == "대리운전") {
              userProvider.addCallLog({
                'id': saveData.id,
                'phone': saveData.phoneNumber,
                'call': "18009455",
                'type': 2
              });
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
              Navigator.of(context).pushReplacementNamed("/Delivery");
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
            } else {
              customDialog("서비스 준비 중입니다.", 0);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "${type == 0 ? resource[index] : resourcePlus[index]}",
                width: 70,
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

  pService() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: viewPage == 0
              ? MediaQuery.of(context).size.width + 115
              : MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: Color.fromARGB(255, 245, 245, 245))),
          child: GridView.count(
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            children: viewPage == 0
                ? List.generate(12, (index) {
              return serviceList(index, 0);
            })
                : viewPage == 1
                ? List.generate(
              resourcePlus.length,
                  (idx) {
                return serviceList(idx, 1);
              },
            )
                : Container(),
          ),
        ),
        viewPage != 1
            ? Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: white,
              border: Border.all(
                  width: 1, color: Color.fromARGB(255, 245, 245, 245))),
        )
            : Container(),
        viewPage != 1
            ? GestureDetector(
          onTap: () {
            setState(() {
              viewPage = 1;
              FocusScope.of(context).requestFocus(pFocus);
              onTopScroll();
            });
          },
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
//            color: mainColor,
              decoration: BoxDecoration(
                  color: Color(0xFFD74f15),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 36,
                      color: white,
                    ),
                    whiteSpaceW(10),
                    Text(
                      "제휴 서비스 더보기",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
            : Container(),
        viewPage != 1
            ? Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: white,
              border: Border.all(
                  width: 2, color: Color.fromARGB(255, 245, 245, 245))),
        )
            : Container(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          color: white,
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (viewPage == 0) {
      FocusScope.of(context).requestFocus(mainFocus);
    }
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: white,
          resizeToAvoidBottomInset: true,
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                whiteSpaceH(MediaQuery
                    .of(context)
                    .padding
                    .top + 20),
                Row(
                  children: <Widget>[
                    whiteSpaceW(30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${saveData.name}>",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                              "${saveData.phoneNumber.substring(
                                  0, 3)}-${saveData.phoneNumber.substring(
                                  3, 7)}-${saveData.phoneNumber.substring(
                                  7, 11)}")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sharedLogout();
                      },
                      child: Text(
                        "로그아웃",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    whiteSpaceW(30)
                  ],
                ),
                whiteSpaceH(20),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 1,
                  color: Color.fromARGB(255, 167, 167, 167),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 30,
                  color: Color.fromARGB(255, 129, 129, 129),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                      "알라딘매직",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, color: white),
                    ),
                  ),
                ),
                whiteSpaceH(20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/SaveBreakDown");
                  },
                  child: Row(
                    children: <Widget>[
                      whiteSpaceW(10),
                      Expanded(
                        child: Text(
                          "적립금내역",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      whiteSpaceW(10)
                    ],
                  ),
                ),
                whiteSpaceH(20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/RecoList");
                  },
                  child: Row(
                    children: <Widget>[
                      whiteSpaceW(10),
                      Expanded(
                        child: Text(
                          "추천인목록",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      whiteSpaceW(10)
                    ],
                  ),
                ),
                whiteSpaceH(20),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 30,
                  color: Color.fromARGB(255, 129, 129, 129),
                  padding: EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                      "기타",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, color: white),
                    ),
                  ),
                ),
                whiteSpaceH(20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/Settings");
                  },
                  child: Row(
                    children: <Widget>[
                      whiteSpaceW(10),
                      Expanded(
                        child: Text(
                          "설정",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                      whiteSpaceW(10)
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0.5,
            centerTitle: true,
            title: Image.asset(
              "assets/resource/title.png",
              width: 120,
            ),
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: black,
                size: 28,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: black,
                ),
              )
            ],
          ),
          body: viewPage == 4
              ? webView(initialUrl)
              : SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                viewPage = 0;
                                FocusScope.of(context)
                                    .requestFocus(mainFocus);
                              });
                            },
                            focusNode: mainFocus,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "알라딘매직",
                                hintStyle:
                                TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: mainColor)),
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                viewPage = 1;
                                FocusScope.of(context)
                                    .requestFocus(pFocus);
                              });
                            },
                            focusNode: pFocus,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "제휴서비스",
                                hintStyle:
                                TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: mainColor)),
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                viewPage = 2;
                                FocusScope.of(context)
                                    .requestFocus(eventFocus);
                              });
                            },
                            focusNode: eventFocus,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "이벤트",
                                hintStyle:
                                TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: mainColor)),
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {
                              viewPage = 3;
                            },
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "고객지원",
                                hintStyle:
                                TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: mainColor)),
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  whiteSpaceH(0.5),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 1,
                    color: Color.fromARGB(255, 219, 219, 219),
                  ),
                  viewPage == 0
                      ? Column(
                    children: <Widget>[saveMoneyView(), pService()],
                  )
                      : Container(),
                  viewPage == 1 ? pService() : Container(),
                  viewPage == 2
                      ? Padding(
                    padding: EdgeInsets.only(
                        top:
                        MediaQuery
                            .of(context)
                            .size
                            .height / 3),
                    child: Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          "이벤트가 존재하지 않습니다.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
                      : Container(),
                  viewPage == 3 ? Container() : Container()
                ],
              ),
            ),
          ),
        ),
        onWillPop: onWillPop);
  }
}
