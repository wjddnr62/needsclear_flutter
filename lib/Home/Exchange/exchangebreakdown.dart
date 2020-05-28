import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExchangeBreakdown extends StatefulWidget {
  final int retentionNcp;
  final int deductionNcp;
  final double retentionDL;
  final double exchangeDL;
  final int type;

  ExchangeBreakdown(
      {this.retentionNcp,
      this.deductionNcp,
      this.retentionDL,
      this.exchangeDL,
      this.type});

  @override
  _ExchangeBreakdown createState() => _ExchangeBreakdown();
}

class _ExchangeBreakdown extends State<ExchangeBreakdown> {
  DateTime now = DateTime.now();
  String formatDate;

  @override
  void initState() {
    super.initState();
    formatDate = DateFormat('yyyy/MM/dd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              "assets/needsclear/resource/home/close.png",
              width: 24,
              height: 24,
            ),
          ),
          centerTitle: true,
          title: Text(
            "환전 내역",
            style: TextStyle(
                fontFamily: 'noto',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 8)
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            formatDate,
                            style: TextStyle(
                                fontFamily: 'noto',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: black),
                          ),
                        ),
                        whiteSpaceH(16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Color(0xFFDDDDDD),
                        ),
                        whiteSpaceH(16),
                        Text(
                          "* NCP 현황",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 12,
                              fontFamily: 'noto'),
                        ),
                        whiteSpaceH(8),
                        Row(
                          children: [
                            Text(
                              "보유 NCP",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 14,
                                  color: black),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "${numberFormat.format(widget.retentionNcp)} NCP",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto'),
                            )
                          ],
                        ),
                        whiteSpaceH(4),
                        Row(
                          children: [
                            Text(
                              "차감 NCP",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 14,
                                  color: black),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "- ${numberFormat.format(widget.deductionNcp)} NCP",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto'),
                            )
                          ],
                        ),
                        whiteSpaceH(8),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Color(0xFFDDDDDD),
                        ),
                        whiteSpaceH(8),
                        Row(
                          children: [
                            Text(
                              "잔여 NCP",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "${numberFormat.format(widget.retentionNcp - widget.deductionNcp)} NCP",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'noto',
                                  color: mainColor),
                            )
                          ],
                        ),
                        whiteSpaceH(30),
                        Text(
                          "* DL 현황",
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 12,
                              fontFamily: 'noto'),
                        ),
                        whiteSpaceH(8),
                        Row(
                          children: [
                            Text(
                              "보유 DL",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 14,
                                  color: black),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "${numberFormat.format(widget.retentionDL.toInt())} DL",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto'),
                            )
                          ],
                        ),
                        whiteSpaceH(4),
                        Row(
                          children: [
                            Text(
                              "환전 DL",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 14,
                                  color: black),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "+ ${numberFormat.format(widget.exchangeDL.toInt())} DL",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: 'noto'),
                            )
                          ],
                        ),
                        whiteSpaceH(8),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Color(0xFFDDDDDD),
                        ),
                        whiteSpaceH(8),
                        Row(
                          children: [
                            Text(
                              "총 DL",
                              style: TextStyle(
                                  fontFamily: 'noto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(
                              "${numberFormat.format(widget.retentionDL.toInt() + widget.exchangeDL.toInt())} DL",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: 'noto',
                                  color: mainColor),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                whiteSpaceH(40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 0.0,
                    color: mainColor,
                    child: Center(
                      child: Text(
                        "확인",
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'noto'),
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
