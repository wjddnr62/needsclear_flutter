import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:needsclear/SignUp/smsauth.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class MemberW extends StatefulWidget {
  @override
  _MemberW createState() => _MemberW();
}

class _MemberW extends State<MemberW> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed("/Settings");
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: mainMove("회원탈퇴", context),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/Settings");
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                whiteSpaceH(25),
                Row(
                  children: <Widget>[
                    whiteSpaceW(50),
                    Icon(
                      Icons.warning,
                      color: Colors.redAccent,
                      size: 24,
                    ),
                    whiteSpaceW(10),
                    Text(
                      "계정 비활성화 및 삭제 시 주의사항",
                      style: TextStyle(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                whiteSpaceH(25),
                Row(
                  children: <Widget>[
                    whiteSpaceW(20),
                    Icon(
                      Icons.brightness_1,
                      color: black,
                      size: 6,
                    ),
                    whiteSpaceW(20),
                    Text(
                      "유의사항 (",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: black),
                    ),
                    Text("필독사항",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.red)),
                    Text(")",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: black))
                  ],
                ),
                whiteSpaceH(25),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DottedBorder(
                    color: black,
                    strokeWidth: 1,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          whiteSpaceH(15),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "-사용하고 계신 계정은 탈퇴가 완료 될 경우",
                                  style: TextStyle(
                                    color: black,
                                  ),
                                ),
                                TextSpan(
                                    text: "복구가 불가",
                                    style: TextStyle(color: Colors.red)),
                                TextSpan(
                                    text: "하니 유의 부탁드립니다.",
                                    style: TextStyle(
                                      color: black,
                                    ))
                              ],
                            ),
                          ),
                          whiteSpaceH(15),
                          Text("-탈퇴가 완료될 경우 앱 이용내역이(적립내역, 추천인내역 등) 삭제됩니다."),
                          whiteSpaceH(15)
                        ],
                      ),
                    ),
                  ),
                ),
                whiteSpaceH(25),
                Row(
                  children: <Widget>[
                    whiteSpaceW(20),
                    Icon(
                      Icons.brightness_1,
                      color: black,
                      size: 6,
                    ),
                    whiteSpaceW(20),
                    Text(
                      "회원탈퇴 진행방법",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: black),
                    ),
                  ],
                ),
                whiteSpaceH(25),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: DottedBorder(
                    color: black,
                    strokeWidth: 1,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          whiteSpaceH(15),
                          Text("회원 탈퇴 선택 시 불법도용 및 불이익에 대한 피해를 방지하고자 회원가입 시 진행된 휴대폰인증 절차가 진행됩니다."),
                          whiteSpaceH(15),
                          Text("휴대폰인증 완료 후 회원탈퇴 신청이 진행됩니다."),
                          whiteSpaceH(15)
                        ],
                      ),
                    ),
                  ),
                ),
//              whiteSpaceH(25),
//              Row(
//                children: <Widget>[
//                  whiteSpaceW(20),
//                  Icon(
//                    Icons.brightness_1,
//                    color: black,
//                    size: 6,
//                  ),
//                  whiteSpaceW(20),
//                  Text(
//                    "회원탈퇴 대기기간 안내",
//                    style: TextStyle(
//                        fontWeight: FontWeight.w600,
//                        fontSize: 16,
//                        color: black),
//                  ),
//                ],
//              ),
//              whiteSpaceH(25),
//              Padding(
//                padding: EdgeInsets.only(left: 10, right: 10),
//                child: DottedBorder(
//                  color: black,
//                  strokeWidth: 1,
//                  padding: EdgeInsets.only(left: 10, right: 10),
//                  child: Container(
//                    width: MediaQuery.of(context).size.width,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        whiteSpaceH(15),
//                        RichText(
//                          text: TextSpan(
//                            children: <TextSpan>[
//                              TextSpan(
//                                text: "인증 완료  ",
//                                style: TextStyle(
//                                  color: black,
//                                ),
//                              ),
//                              TextSpan(
//                                  text: "14일간의 탈퇴 대기기간",
//                                  style: TextStyle(color: black, fontWeight: FontWeight.w600)),
//                              TextSpan(
//                                  text: "이 있으며, 탈퇴 대기기나 동안",
//                                  style: TextStyle(
//                                    color: black,
//                                  )),
//                              TextSpan(
//                                  text: " 탈퇴 대기 취소",
//                                  style: TextStyle(color: black, fontWeight: FontWeight.w600)),
//                              TextSpan(
//                                  text: "를 할 수 있습니다.",
//                                  style: TextStyle(
//                                    color: black,
//                                  )),
//                            ],
//                          ),
//                        ),
//                        whiteSpaceH(15)
//                      ],
//                    ),
//                  ),
//                ),
//              ),
                whiteSpaceH(30),
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SmsAuth(type: 3)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(width: 1, color: black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("회원 탈퇴신청"),
                      ),
                    ),
                  ),
                ),
                whiteSpaceH(30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
