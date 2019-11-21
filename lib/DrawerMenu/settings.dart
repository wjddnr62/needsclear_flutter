import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/SignUp/smsauth.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  SaveData saveData = SaveData();

  passDialog() {
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
                    "비밀번호 변경은\n휴대폰인증 후 가능합니다.\n\n휴대폰인증\n화면으로 이동하시겠습니까?",
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
                                "취소",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      whiteSpaceW(5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmsAuth(type: 2)));
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('/Home');
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text(
            "설정",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: black),
          ),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/Home');
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            whiteSpaceH(30),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "계정정보",
                style: TextStyle(
                    color: black, fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            whiteSpaceH(30),
            Row(
              children: <Widget>[
                whiteSpaceW(15),
                Text(
                  "*",
                  style: TextStyle(color: Colors.redAccent),
                ),
                Text(
                  "아 이 디 : ${saveData.id}",
                  style: TextStyle(
                      color: black, fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
            Row(
              children: <Widget>[
                whiteSpaceW(15),
                Text(
                  "*",
                  style: TextStyle(color: Colors.redAccent),
                ),
                Text(
                  "비밀번호 : ",
                  style: TextStyle(
                      color: black, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Container(
                  width: 120,
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color.fromARGB(255, 167, 167, 167))),
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("******", textAlign: TextAlign.start,),
                  ),
                ),
                whiteSpaceW(10),
                RaisedButton(
                  onPressed: () {
                    passDialog();
                  },
                  elevation: 0.0,
                  color: Color.fromARGB(255, 167, 167, 167),
                  child: Center(
                    child: Text(
                      "수정",
                      style: TextStyle(color: white),
                    ),
                  ),
                )
              ],
            ),
            whiteSpaceH(20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: black,
            ),
            whiteSpaceH(20),
            Row(
              children: <Widget>[
                whiteSpaceW(15),
                Expanded(
                  child: Text(
                    "버전정보",
                    style: TextStyle(color: black, fontSize: 14),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 167, 167, 167),
                ),
                whiteSpaceW(15)
              ],
            ),
            whiteSpaceH(20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: black,
            ),
            whiteSpaceH(20),
            Row(
              children: <Widget>[
                whiteSpaceW(15),
                Expanded(
                  child: Text(
                    "약관",
                    style: TextStyle(color: black, fontSize: 14),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 167, 167, 167),
                ),
                whiteSpaceW(15)
              ],
            ),
            whiteSpaceH(20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: black,
            ),
            whiteSpaceH(MediaQuery.of(context).size.height / 5),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("/MemberW");
                  },
                  child: Text(
                    "회원탈퇴",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  serviceDialog(msg) {
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
}
