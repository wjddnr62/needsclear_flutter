import 'dart:convert';

import 'package:aladdinmagic/Home/home.dart';
import 'package:aladdinmagic/Model/datastorage.dart';
import 'package:aladdinmagic/Model/user.dart';
import 'package:aladdinmagic/Model/usercheck.dart';
import 'package:aladdinmagic/Provider/provider.dart';
import 'package:aladdinmagic/Util/text.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewSignUp extends StatefulWidget {
  final UserCheck userCheck;

  NewSignUp({this.userCheck});

  @override
  _NewSignUp createState() => _NewSignUp();
}

class _NewSignUp extends State<NewSignUp> {
  UserCheck userCheck;

  String selectBoxValue = "가입경로 선택";

  bool allAgree = false;
  bool useCheck = false;
  bool privacyCheck = false;
  bool locationCheck = false;
  List<String> signRoot = [
    '가입경로 선택',
    '알라딘박스',
    'ABO 회원',
    'ABM 회원',
    '대리점 회원',
    '총판 회원',
    '지인추천',
    '인터넷 검색',
    '기타'
  ];

  TextEditingController recoController = TextEditingController();
  Provider provider = Provider();

  bool recoCheck = false;

  bool signFinish = false;

  @override
  void initState() {
    super.initState();

    userCheck = widget.userCheck;

    userInsert();
  }

  userInsert() async {
    await provider
        .insertUser(userCheck.username, userCheck.name, userCheck.phone,
            userCheck.birth, userCheck.sex)
        .then((value) {
      dynamic result = json.decode(value);
      if (result['data'] == "OK") {
        provider
            .saveLogInsert(
                id: userCheck.username,
                name: userCheck.name,
                phone: userCheck.phone,
                type: 0,
                point: 10000,
                date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
                saveMonth: "",
                savePlace: 0,
                saveType: 0)
            .then((value) async {
          print("saveLog : $value");
          dynamic result = json.decode(value);
          if (result['data'] == "OK") {
            // 회원가입 완료
            setState(() {
              signFinish = true;
            });

            await provider.selectUser(userCheck.username).then((value) {
              dynamic data = json.decode(value);
              User user = User.fromJson(data['data']);

              dataStorage.user = user;

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false);
            });
          }
        });
      }
      print("insertUser : " + value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => null,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(mainColor),
            ),
          ),
        ),
      ),
    );
  }

  backDialog() {
    return showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: white,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        whiteSpaceH(12),
                        customText(StyleCustom(
                            text: "알림",
                            color: Color(0xFF444444),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                        whiteSpaceH(12),
                        Padding(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Color(0xFFCCCCCC),
                          ),
                        ),
                        whiteSpaceH(36),
                        customText(StyleCustom(
                            text: "앱을 종료하시겠습니까?",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF444444)))
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  "취소",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  SystemChannels.platform
                                      .invokeListMethod('SystemNavigator.pop');
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12)),
                                ),
                                child: Center(
                                  child: Text(
                                    "확인",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }
}
