import 'package:flutter/material.dart';
import 'package:needsclear/Model/dress.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import 'laundrypayment.dart';

class LaundryApply extends StatefulWidget {
  final int type;
  final List<DressSet> dressNormal;
  final List<DressSet> dressPremium;
  final int allPay;

  LaundryApply({this.type, this.dressNormal, this.dressPremium, this.allPay});

  @override
  _LaundryApply createState() => _LaundryApply();
}

class _LaundryApply extends State<LaundryApply> {
  String selectBoxValue = "옵션";
  List<DressSet> dressNormal = List();
  List<DressSet> dressPremium = List();
  List<int> dressPaymentNormal = List();
  List<int> dressPaymentPremium = List();

  @override
  void initState() {
    super.initState();

    init();
  }

  init() {
    setState(() {
      dressNormal.clear();
      dressPremium.clear();

      dressNormal = widget.dressNormal;
      dressPremium = widget.dressPremium;

      for (int i = 0; i < widget.dressNormal.length; i++) {
        widget.dressNormal[i].dressCount = 0;
      }

      for (int i = 0; i < widget.dressPremium.length; i++) {
        widget.dressPremium[i].dressCount = 0;
      }

      for (int i = 0; i < dressNormal.length; i++) {
        dressPaymentNormal.add(0);
      }

      for (int i = 0; i < dressPremium.length; i++) {
        dressPaymentPremium.add(0);
      }
    });
  }

  int allPay = 0;
  bool checkNormal = false;
  bool checkPremium = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return null;
      },
//          Navigator.of(context)
//          .pushReplacement(MaterialPageRoute(builder: (context) => Laundry())),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              "assets/needsclear/resource/public/prev.png",
              width: 24,
              height: 24,
            ),
          ),
          centerTitle: true,
          title: Text(
            "세탁신청",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: black,
                fontFamily: 'noto',
                fontSize: 14),
          ),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                whiteSpaceH(8),
                Text(
                  "세탁물 수량",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'noto',
                      color: black,
                      fontWeight: FontWeight.w600),
                ),
                whiteSpaceH(16),
                dressNormal.length != 0
                    ? Text(
                        "일반세탁",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontFamily: 'noto',
                            fontSize: 14),
                      )
                    : Container(),
                dressNormal.length != 0 ? whiteSpaceH(8) : Container(),
                ListView.builder(
                  itemBuilder: (context, idx) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                dressNormal[idx].dressName +
                                    " ${dressNormal[idx].dressPay}원",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'noto',
                                    color: black),
                              ),
                            ),
//                            Expanded(
//                              child: Container(),
//                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (dressNormal[idx]
                                                          .dressCount !=
                                                      0) {
                                                    dressNormal[idx]
                                                        .dressCount -= 1;
                                                    dressPaymentNormal[idx] -=
                                                        dressNormal[idx]
                                                            .dressPay;
                                                    allPay -= dressNormal[idx]
                                                        .dressPay;
                                                  }
                                                });
                                              },
                                              elevation: 0.0,
                                              color: Color(0xFFEEEEEE),
                                              padding: EdgeInsets.zero,
                                              shape: Border.all(
                                                  color: Color(0xFFDDDDDD)),
                                              child: Center(
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontFamily: 'noto',
                                                      color: black,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(4),
                                        Expanded(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                    color: Color(0xFFDDDDDD))),
                                            child: Center(
                                              child: Text(
                                                dressNormal[idx]
                                                    .dressCount
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'noto',
                                                    color: black,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(4),
                                        Expanded(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (dressNormal[idx]
                                                          .dressCount !=
                                                      99) {
                                                    dressNormal[idx]
                                                        .dressCount += 1;
                                                    dressPaymentNormal[idx] +=
                                                        dressNormal[idx]
                                                            .dressPay;
                                                    allPay += dressNormal[idx]
                                                        .dressPay;
                                                  }
                                                });
                                              },
                                              elevation: 0.0,
                                              color: Color(0xFFEEEEEE),
                                              padding: EdgeInsets.zero,
                                              shape: Border.all(
                                                  color: Color(0xFFDDDDDD)),
                                              child: Center(
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                      fontFamily: 'noto',
                                                      color: black,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  whiteSpaceW(12),
                                  Expanded(
                                    child: Container(
                                      color: white,
                                      child: Text(
                                        "${numberFormat.format(dressPaymentNormal[idx])}원",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 12,
                                            fontFamily: 'noto'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        whiteSpaceH(8)
                      ],
                    );
                  },
                  shrinkWrap: true,
                  itemCount: dressNormal != null ? dressNormal.length : 0,
                  physics: NeverScrollableScrollPhysics(),
                ),
                whiteSpaceH(16),
                dressPremium.length != 0
                    ? Text(
                        "명품세탁",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontFamily: 'noto',
                            fontSize: 14),
                      )
                    : Container(),
                dressPremium.length != 0 ? whiteSpaceH(8) : Container(),
                ListView.builder(
                  itemBuilder: (context, idx) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                dressPremium[idx].dressName +
                                    " ${dressPremium[idx].dressPay}원",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'noto',
                                    color: black),
                              ),
                            ),
//                            Expanded(
//                              child: Container(),
//                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (dressPremium[idx]
                                                          .dressCount !=
                                                      0) {
                                                    dressPremium[idx]
                                                        .dressCount -= 1;
                                                    dressPaymentPremium[idx] -=
                                                        dressPremium[idx]
                                                            .dressPay;
                                                    allPay -= dressPremium[idx]
                                                        .dressPay;
                                                  }
                                                });
                                              },
                                              elevation: 0.0,
                                              color: Color(0xFFEEEEEE),
                                              padding: EdgeInsets.zero,
                                              shape: Border.all(
                                                  color: Color(0xFFDDDDDD)),
                                              child: Center(
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontFamily: 'noto',
                                                      color: black,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(4),
                                        Expanded(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                    color: Color(0xFFDDDDDD))),
                                            child: Center(
                                              child: Text(
                                                dressPremium[idx]
                                                    .dressCount
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'noto',
                                                    color: black,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(4),
                                        Expanded(
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (dressPremium[idx]
                                                          .dressCount !=
                                                      99) {
                                                    dressPremium[idx]
                                                        .dressCount += 1;
                                                    dressPaymentPremium[idx] +=
                                                        dressPremium[idx]
                                                            .dressPay;
                                                    allPay += dressPremium[idx]
                                                        .dressPay;
                                                  }
                                                });
                                              },
                                              elevation: 0.0,
                                              color: Color(0xFFEEEEEE),
                                              padding: EdgeInsets.zero,
                                              shape: Border.all(
                                                  color: Color(0xFFDDDDDD)),
                                              child: Center(
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                      fontFamily: 'noto',
                                                      color: black,
                                                      fontSize: 14),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  whiteSpaceW(12),
                                  Expanded(
                                    child: Container(
                                      color: white,
                                      child: Text(
                                        "${numberFormat.format(dressPaymentPremium[idx])}원",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 12,
                                            fontFamily: 'noto'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        whiteSpaceH(8)
                      ],
                    );
                  },
                  shrinkWrap: true,
                  itemCount: dressPremium != null ? dressPremium.length : 0,
                  physics: NeverScrollableScrollPhysics(),
                ),
                whiteSpaceH(16),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Color(0xFFDDDDDD),
                ),
                whiteSpaceH(8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "세탁금액",
                        style: TextStyle(
                            fontFamily: 'noto',
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      numberFormat.format(allPay) + "원",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: mainColor,
                          fontSize: 16,
                          fontFamily: 'noto'),
                    )
                  ],
                ),
                whiteSpaceH(62),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: RaisedButton(
                    elevation: 0.0,
                    onPressed: () {
//                    final page = LaundryPayment(
//                      allPay: allPay,
//                      dress: dressNormal,
//                    );
//                    Navigator.of(context).pushReplacement(
//                        MaterialPageRoute(builder: (context) => page));
                      for (int i = 0; i < dressNormal.length; i++) {
                        if (dressNormal[i].dressCount == 0) {
                          checkNormal = true;
                        } else {
                          checkNormal = false;
                        }
                      }

                      for (int i = 0; i < dressPremium.length; i++) {
                        if (dressPremium[i].dressCount == 0) {
                          checkPremium = true;
                        } else {
                          checkPremium = false;
                        }
                      }

                      if (checkNormal || checkPremium) {
                        showToast("모든 세탁물에 수량을 선택해주세요.");
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LaundryPayment(
                                  allPay: allPay,
                                  dressNormal: dressNormal,
                                  dressPaymentNormal: dressPaymentNormal,
                                  dressPremium: dressPremium,
                                  dressPaymentPremium: dressPaymentPremium,
                                )));
                      }
                    },
                    color: mainColor,
                    child: Center(
                      child: Text(
                        "신청하기",
                        style: TextStyle(
                            fontFamily: 'noto',
                            fontSize: 14,
                            color: white,
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
