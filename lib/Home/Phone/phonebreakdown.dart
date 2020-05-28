import 'package:aladdinmagic/Home/Phone/phone.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PhoneBreakdown extends StatefulWidget {
  final int type;

  PhoneBreakdown({this.type});

  @override
  _PhoneBreakdown createState() => _PhoneBreakdown();
}

class _PhoneBreakdown extends State<PhoneBreakdown> {
  DateTime now = DateTime.now();
  String date;
  int type = 0;

  String name = "이름";
  String phone = "010-0000-0000";
  String changeNewsAgency = "SKT";
  String selectDeviceName = "Galaxy Fold 5G";

  @override
  void initState() {
    super.initState();

    date = DateFormat('yyyy/MM/dd').format(now);
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
            "휴대폰 신청 내역",
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
                              widget.type == 0 ? date : "",
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
                                type == 0 ? "접수완료" : "완료",
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
                          changeNewsAgency,
                          style: TextStyle(
                              color: black, fontFamily: 'noto', fontSize: 14),
                        )
                      ],
                    ),
                    whiteSpaceH(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        selectDeviceName,
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
                        MaterialPageRoute(builder: (context) => Phone()),
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
