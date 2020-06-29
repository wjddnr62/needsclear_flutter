import 'package:flutter/material.dart';
import 'package:needsclear/Home/quick/quickUseGuide.dart';
import 'package:needsclear/Home/quick/quickapply.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/pageMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import '../home.dart';

class Quick extends StatefulWidget {
  @override
  _Quick createState() => _Quick();
}

class _Quick extends State<Quick> {
  String quickValue = "전체";
  bool viewOption = false;
  int quickType = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          title: mainMoveLogo(context),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            },
            icon: Image.asset(
              "assets/needsclear/resource/public/prev.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 88,
                color: Color(0xFFF7F7F7),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "퀵 배송 서비스",
                          style: TextStyle(
                              fontFamily: 'noto',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QuickUseGuide()));
                          },
                          child: Text(
                            "이용 가이드 >",
                            style: TextStyle(
                                fontFamily: 'noto', fontSize: 14, color: black),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Image.asset(
                      "assets/needsclear/resource/service/quick.png",
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                    whiteSpaceW(24)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                color: Color(0xFFF7F7F7),
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFDDDDDD))),
                  child: RaisedButton(
                    onPressed: () {
                      pushPageMove(QuickApply(), context);
                    },
                    elevation: 0.0,
                    color: white,
                    child: Center(
                      child: Text(
                        "신청하기",
                        style: TextStyle(
                            color: black, fontSize: 14, fontFamily: 'noto'),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: white,
                  child: Row(
                    children: [
                      Text(
                        "이용내역",
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
                        width: 80,
                        padding: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: DropdownButton<String>(
                            underline: Container(),
                            elevation: 0,
                            style: TextStyle(
                                color: black, fontSize: 14, fontFamily: 'noto'),
                            items: <String>[
                              '전체',
                              '배차대기',
                              '기사출발',
                              '배송중',
                              '완료',
                              '고객취소',
                              '배차실패'
                            ].map((value) {
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
                            value: quickValue,
                            onChanged: (value) {
                              setState(() {
                                quickValue = value;
                                if (value == "전체") {
                                  viewOption = false;
                                } else {
                                  viewOption = true;
                                  if (value == "배차대기") {
                                    quickType = 0;
                                  } else if (value == "기사출발") {
                                    quickType = 1;
                                  } else if (value == "배송중") {
                                    quickType = 2;
                                  } else if (value == "완료") {
                                    quickType = 3;
                                  } else if (value == "고객취소") {
                                    quickType = 4;
                                  } else if (value == "배차실패") {
                                    quickType = 5;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
