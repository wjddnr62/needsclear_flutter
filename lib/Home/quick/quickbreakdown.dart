import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:needsclear/Home/quick/quick.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class QuickBreakdown extends StatefulWidget {
  final String vehicle;
  final String article;
  final String damage;
  final String startAddress;
  final String endAddress;

  QuickBreakdown(
      {this.vehicle,
      this.article,
      this.damage,
      this.startAddress,
      this.endAddress});

  @override
  _QuickBreakdown createState() => _QuickBreakdown();
}

class _QuickBreakdown extends State<QuickBreakdown> {
  DateTime now = DateTime.now();
  String datetime = "";
  String type = "";
  int payment = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    datetime = DateFormat('yyyy/MM/dd').format(now);
    type = "배차대기";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Quick()), (route) => false);
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0.5,
          centerTitle: true,
          title: mainMove("퀵 배송 내역", context),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Quick()),
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 8)
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                datetime,
                                style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'noto'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                type,
                                style: TextStyle(
                                    fontFamily: 'noto',
                                    fontSize: 12,
                                    color: Color(0xFF888888)),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          )
                        ],
                      ),
                      whiteSpaceH(16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Color(0xFFDDDDDD),
                      ),
                      whiteSpaceH(16),
                      Text(
                        "* 배송옵션",
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 12,
                          fontFamily: 'noto',
                        ),
                      ),
                      whiteSpaceH(8),
                      Row(
                        children: [
                          Text(
                            widget.vehicle,
                            style: TextStyle(
                                fontFamily: 'noto', fontSize: 14, color: black),
                          ),
                          whiteSpaceW(16),
                          Text(
                            widget.article,
                            style: TextStyle(
                                fontFamily: 'noto', fontSize: 14, color: black),
                          ),
                          whiteSpaceW(16),
                          Text(
                            widget.damage,
                            style: TextStyle(
                                fontFamily: 'noto', fontSize: 14, color: black),
                          ),
                        ],
                      ),
                      whiteSpaceH(16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Color(0xFFDDDDDD),
                      ),
                      whiteSpaceH(16),
                      Text(
                        "* 운행정보",
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 12,
                          fontFamily: 'noto',
                        ),
                      ),
                      whiteSpaceH(16),
                      Row(
                        children: [
                          Text(
                            "출발지",
                            style: TextStyle(
                                color: black, fontSize: 14, fontFamily: 'noto'),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.startAddress,
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto'),
                              maxLines: 2,
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                      whiteSpaceH(4),
                      Row(
                        children: [
                          Text(
                            "도착지",
                            style: TextStyle(
                                color: black, fontSize: 14, fontFamily: 'noto'),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.endAddress,
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto'),
                              maxLines: 2,
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                      whiteSpaceH(16),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Color(0xFFDDDDDD),
                      ),
                      whiteSpaceH(16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "운행금액",
                            style: TextStyle(
                                fontFamily: 'noto',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: black),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${numberFormat.format(payment)} 원",
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'noto',
                                    fontSize: 16),
                              ),
                              whiteSpaceH(4),
                              Text(
                                "${numberFormat.format(0)} NCP 적립",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'noto',
                                    color: mainColor),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                whiteSpaceH(40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 43,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Quick()),
                          (route) => false);
                    },
                    color: mainColor,
                    elevation: 0.0,
                    child: Center(
                      child: Text(
                        "확인",
                        style: TextStyle(
                            color: white,
                            fontFamily: 'noto',
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
