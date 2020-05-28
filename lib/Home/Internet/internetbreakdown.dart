import 'package:aladdinmagic/Home/Phone/phone.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'internet.dart';

class InternetBreakdown extends StatefulWidget {
  final int type;
  final String name;
  final String phone;
  final String newsAgency;
  final String selectService;
  InternetBreakdown({this.type,this.name,this.phone,this.newsAgency,this.selectService});

  @override
  _InternetBreakdown createState() => _InternetBreakdown();
}

class _InternetBreakdown extends State<InternetBreakdown> {
  DateTime now = DateTime.now();
  String date;
  int type = 0;

  String name = "이름";
  String phone = "010-0000-0000";
  String newsAgency = "SK 브로드밴드";
  String selectService = "인터넷";


  @override
  void initState() {
    super.initState();
    type = widget.type;
    name = widget.name;
    phone = widget.phone;
    newsAgency = widget.newsAgency;
    selectService = widget.selectService;
    date = DateFormat('yyyy/MM/dd').format(now);
  }

  String typeToString(type) {
    if(type == 0) return "접수완료";
    else if(type == 1) return "결제대기";
    else if(type == 2) return "결제완료";
    else if(type == 3) return "취소";
    else return "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Phone()), (route) => false),
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          title: Text(
            "인터넷 신청 내역",
            style: TextStyle(
                color: black,
                fontFamily: 'noto',
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
          elevation: 1.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Phone()),
                  (route) => false);
            },
            icon: Image.asset(
              "assets/needsclear/resource/home/close.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 8)
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              date,
                              style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontFamily: 'noto',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 8,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                typeToString(type),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    whiteSpaceH(16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Color(0xFFDDDDDD),
                    ),
                    whiteSpaceH(16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "* 신청정보",
                        style: TextStyle(
                            fontSize: 12, fontFamily: 'noto', color: mainColor),
                      ),
                    ),
                    whiteSpaceH(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "신청자",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              color: black, fontFamily: 'noto', fontSize: 14),
                        )
                      ],
                    ),
                    whiteSpaceH(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        phone,
                        style: TextStyle(
                            color: black, fontFamily: 'noto', fontSize: 14),
                      ),
                    ),
                    whiteSpaceH(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "상품정보",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        ),
                        Text(
                          newsAgency,
                          style: TextStyle(
                              color: black, fontFamily: 'noto', fontSize: 14),
                        )
                      ],
                    ),
                    whiteSpaceH(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        selectService,
                        style: TextStyle(
                            color: black, fontFamily: 'noto', fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              whiteSpaceH(40),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 44,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Internet()),
                        (route) => false);
                  },
                  color: mainColor,
                  elevation: 0.0,
                  child: Center(
                    child: Text(
                      "확인",
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'noto', color: white),
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
}
