import 'package:aladdinmagic/SignUp/signup.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class HowJoin extends StatefulWidget {
  @override
  _HowJoin createState() => _HowJoin();
}

class _HowJoin extends State<HowJoin> {

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
                            Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {customDialog("화면을 닫으시는 경우\n회원가입이 중단됩니다.\n\n회원가입을\n중단하시겠습니까?");},
      child: Scaffold(
        backgroundColor: white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 40),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              whiteSpaceH(30),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "알라딘매직 가입방법을\n선택해 주세요.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 18),
                  ),
                ),
              ),
              whiteSpaceH(10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color.fromARGB(255, 167, 167, 167),
              ),
              whiteSpaceH(50),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp(type: 0,)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "일반회원으로 가입하기",
                            style: TextStyle(
                                fontSize: 16,
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    whiteSpaceH(30),
                    GestureDetector(
                      onTap: () {
//                        serviceDialog("서비스 준비 중입니다.");
                      print("카카오톡 회원가입");
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp(type: 1,)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              whiteSpaceW(50),
                              Image.asset(
                                "assets/icon/kakao_icon.png",
                                width: 30,
                                height: 30,
                              ),
                              whiteSpaceW(10),
                              Text("카카오톡으로 가입하기",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    whiteSpaceH(30),
                    GestureDetector(
                      onTap: () {
                        serviceDialog("서비스 준비 중입니다.");
//                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp(type: 2,)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              whiteSpaceW(50),
                              Image.asset(
                                "assets/icon/google_icon.png",
                                width: 30,
                                height: 30,
                              ),
                              whiteSpaceW(10),
                              Text("구글로 가입하기",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    whiteSpaceH(30),
                    GestureDetector(
                      onTap: () {
                        serviceDialog("서비스 준비 중입니다.");
//                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp(type: 3,)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              whiteSpaceW(50),
                              Image.asset(
                                "assets/icon/facebook_icon.png",
                                width: 30,
                                height: 30,
                              ),
                              whiteSpaceW(10),
                              Text("페이스북으로 가입하기",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
