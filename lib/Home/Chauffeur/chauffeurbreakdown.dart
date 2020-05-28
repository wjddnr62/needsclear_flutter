import 'package:aladdinmagic/Home/Chauffeur/chauffeur.dart';
import 'package:aladdinmagic/Home/Phone/phone.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChauffeurBreakdown extends StatefulWidget {
  final int type;

  ChauffeurBreakdown({this.type});

  @override
  _ChauffeurBreakdown createState() => _ChauffeurBreakdown();
}

class _ChauffeurBreakdown extends State<ChauffeurBreakdown> {
  DateTime now = DateTime.now();
  String date;
  int type = 0;

  String startAddress = "서울 금천구 가산디지털1로 24\n대륭13차 701호";
  String endAddress = "서울 금천구 가산디지털1로 24\n대륭13차 701호";

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
          MaterialPageRoute(builder: (context) => Chauffeur()),
          (route) => false),
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          title: Text(
            "대리운전 내역",
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
                                type == 0 ? "배차대기" : "완료",
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
                        "* 운행정보",
                        style: TextStyle(
                            fontSize: 12, fontFamily: 'noto', color: mainColor),
                      ),
                    ),
                    whiteSpaceH(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "출발지",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        ),
                        Text(
                          startAddress,
                          style: TextStyle(
                              color: black, fontFamily: 'noto', fontSize: 14),
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                    whiteSpaceH(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "도착지",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        ),
                        Text(
                          endAddress,
                          style: TextStyle(
                              color: black, fontFamily: 'noto', fontSize: 14),
                          textAlign: TextAlign.end,
                        )
                      ],
                    ),
                    type != 0
                        ? Column(
                            children: [],
                          )
                        : Container()
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
                        MaterialPageRoute(builder: (context) => Chauffeur()),
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
