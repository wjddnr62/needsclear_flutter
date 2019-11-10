import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/toast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  DateTime currentBackPressTime;
  FocusNode mainFocus = FocusNode();
  SaveData saveData = SaveData();
  UserProvider userProvider = UserProvider();
  SharedPreferences prefs;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast(msg: "한번 더 누르면 종료됩니다.", type: 0);
      return Future.value(false);
    }
    return Future.value(true);
  }

  sharedLogout() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("autoLogin", 0);
    await prefs.setString("id", "");
    await prefs.setString("pass", "");

    Navigator.of(context).pushNamedAndRemoveUntil("/Login", (Route<dynamic> route) => false);
  }

  int viewPage = 0;

  List<String> resource = [
    'assets/resource/laundry.png',
    'assets/resource/aladdinbox.png',
    'assets/resource/woogos.png',
    'assets/resource/movie.png',
    'assets/resource/flower.png',
    'assets/resource/drive.png',
    'assets/resource/quick.png',
    'assets/resource/car.png',
    'assets/resource/more.png'
  ];

  List<String> resourceName = [
    '세탁신청',
    '알라딘박스',
    '우고스',
    '영화표 예매',
    '꽃배달',
    '대리운전',
    '퀵서비스',
    '렌트카',
    '제휴서비스\n더보기'
  ];

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FocusScope.of(context).requestFocus(mainFocus);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      drawer:  Drawer(
        child: Column(
          children: <Widget>[
            whiteSpaceH(MediaQuery.of(context).padding.top + 20),
            Row(
              children: <Widget>[
                whiteSpaceW(30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${saveData.name}>", style: TextStyle(decoration: TextDecoration.underline, color: black, fontWeight: FontWeight.w600, fontSize: 18), textAlign: TextAlign.start,),
                      Text("${saveData.phoneNumber.substring(0, 3)}-${saveData.phoneNumber.substring(3, 7)}-${saveData.phoneNumber.substring(7, 11)}")
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    sharedLogout();
                  },
                  child: Text("로그아웃", style: TextStyle(decoration: TextDecoration.underline, color: black, fontWeight: FontWeight.w600, fontSize: 16), textAlign: TextAlign.start,),
                ),
                whiteSpaceW(30)
              ],
            ),
            whiteSpaceH(20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Color.fromARGB(255, 167, 167, 167),
            ),
            whiteSpaceH(50),
            Center(
              child: Text("서비스 준비 중입니다."),
            )
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
      body: WillPopScope(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {},
                            focusNode: mainFocus,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "알라딘매직",
                                hintStyle:
                                    TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor)),
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {},
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "제휴서비스",
                                hintStyle:
                                    TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor)),
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {
                            },
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "이벤트",
                                hintStyle:
                                    TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor)),
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 5)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: TextFormField(
                            onTap: () {
                            },
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "고객지원",
                                hintStyle:
                                    TextStyle(fontSize: 14, color: black),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor)),
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
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromARGB(255, 219, 219, 219),
                  ),
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
                                  text:
                                      "${numberFormat.format(saveData.point)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: mainColor,
                                      fontSize: 28),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "원",
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
                  whiteSpaceH(10),
                  Row(
                    children: <Widget>[
                      whiteSpaceW(5),
                      Icon(Icons.person),
                      Expanded(
                        child: Text("피추천인"),
                      ),
                      Text("${saveData.recoPerson}명"),
                      whiteSpaceW(10)
                    ],
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
                        child: Text("피추천인 적립"),
                      ),
                      Text("${numberFormat.format(saveData.recoPrice)}원"),
                      whiteSpaceW(10)
                    ],
                  ),
                  whiteSpaceH(10),
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
                          onTap: () {},
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 245, 245, 245))),
                    child: GridView.count(
                      crossAxisCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(9, (index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: white,
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 245, 245, 245))),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                // type 0 = 꽃배달, 1 = 퀵서비스, 2 = 대리운전
                                if (resourceName[index] == "꽃배달") {
                                  userProvider.addCallLog({
                                    'id': saveData.id,
                                    'phone': saveData.phoneNumber,
                                    'call': "18005139",
                                    'type': 0
                                  });
                                  await launch("tel:18005139");
                                } else if (resourceName[index] == "퀵서비스") {
                                  userProvider.addCallLog({
                                    'id': saveData.id,
                                    'phone': saveData.phoneNumber,
                                    'call': "15888290",
                                    'type': 1
                                  });
                                  await launch("tel:15888290");
                                } else if (resourceName[index] == "대리운전") {
                                  userProvider.addCallLog({
                                    'id': saveData.id,
                                    'phone': saveData.phoneNumber,
                                    'call': "18009455",
                                    'type': 2
                                  });
                                  await launch("tel:18009455");
                                } else if (resourceName[index] == "알라딘박스") {
                                  await launch(
                                      "https://play.google.com/store/apps/details?id=com.apsolution.safebox&hl=ko");
                                } else {
                                  customDialog("서비스 준비 중입니다.", 0);
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "${resource[index]}",
                                    width: 70,
                                  ),
                                  Text(
                                    "${resourceName[index]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    color: white,
                  )
                ],
              ),
            ),
          ),
          onWillPop: onWillPop),
    );
  }
}
