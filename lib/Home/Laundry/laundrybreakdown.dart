import 'package:aladdinmagic/Model/dress.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'laundry.dart';

class LaundryBreakDown extends StatefulWidget {
  final int type;
  final int washType;
  final int allPay;
  final List<DressSet> dressNormal;
  final List<DressSet> dressPremium;
  final List<int> dressPaymentNormal;
  final List<int> dressPaymentPremium;
  final int ncpPoint;
  final List<DressSet> addAllDress;
  final String date;

  LaundryBreakDown(
      {this.type,
      this.washType,
      this.allPay,
      this.dressNormal,
      this.dressPremium,
      this.dressPaymentNormal,
      this.dressPaymentPremium,
        this.ncpPoint,
        this.addAllDress,
        this.date});

  @override
  _LaundryBreakDown createState() => _LaundryBreakDown();
}

class _LaundryBreakDown extends State<LaundryBreakDown> {
  DateTime now = DateTime.now();
  String date;

  int allPay = 0;
  List<DressSet> dressNormal = List();
  List<DressSet> dressPremium = List();
  List<DressSet> addAllDress = List();
  List<int> dressPaymentNormal = List();
  List<int> dressPaymentPremium = List();

  int type = 0;

  @override
  void initState() {
    super.initState();

    date = DateFormat('yyyy/MM/dd').format(now);

    if (widget.type == 0) {
      allPay = widget.allPay;
      dressNormal = widget.dressNormal;
      dressPremium = widget.dressPremium;

      for (int i = 0; i < dressNormal.length; i++) {
        addAllDress.add(DressSet(
            dressName: dressNormal[i].dressName,
            dressCount: dressNormal[i].dressCount,
            dressPay: dressNormal[i].dressPay));
      }

      for (int i = 0; i < dressPremium.length; i++) {
        addAllDress.add(DressSet(
            dressName: dressPremium[i].dressName,
            dressCount: dressPremium[i].dressCount,
            dressPay: dressPremium[i].dressPay));
      }

      dressPaymentNormal = widget.dressPaymentNormal;
      dressPaymentPremium = widget.dressPaymentPremium;
    } else {
      allPay = widget.allPay;
      addAllDress = widget.addAllDress;
      date = widget.date.split(" ")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Laundry()), (route) => false),
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 1.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Laundry()),
                  (route) => false);
            },
            icon: Image.asset(
              "assets/needsclear/resource/home/close.png",
              width: 24,
              height: 24,
            ),
          ),
          title: Text(
            "세탁 내역",
            style: TextStyle(
                color: black,
                fontWeight: FontWeight.w600,
                fontFamily: 'noto',
                fontSize: 14),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                                    widget.washType == 0
                                        ? "택배대기"
                                        : widget.washType == 1
                                        ? "수령대기"
                                        : widget.washType == 2
                                        ? "세탁중"
                                        : widget.washType == 3
                                        ? "완료"
                                        : "",
                                    style: widget.washType == 0
                                        ? TextStyle(
                                        color: Color(0xFFFFCC00),
                                        fontFamily: 'noto',
                                        fontSize: 12)
                                        : widget.washType == 1
                                        ? TextStyle(
                                        color: Color(0xFFFFCC00),
                                        fontFamily: 'noto',
                                        fontSize: 12)
                                        : widget.washType == 2
                                        ? TextStyle(
                                        color: Color(0xFF00AAFF),
                                        fontFamily: 'noto',
                                        fontSize: 12)
                                        : widget.washType == 3
                                        ? TextStyle(
                                        color:
                                        Color(0xFF888888),
                                        fontFamily: 'noto',
                                        fontSize: 12)
                                        : TextStyle(
                                        color:
                                        Color(0xFFFFCC00),
                                        fontFamily: 'noto',
                                        fontSize: 12),
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
                            "* 세탁내용",
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 12,
                                fontFamily: 'noto'),
                          ),
                        ),
                        whiteSpaceH(8),
                        ListView.builder(
                          itemBuilder: (context, idx) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    addAllDress[idx].dressName +
                                        " (개 당 ${addAllDress[idx].dressPay}원)",
                                    style: TextStyle(
                                        fontFamily: 'noto',
                                        fontSize: 14,
                                        color: black),
                                  ),
                                ),
                                Text(
                                  "${numberFormat.format(addAllDress[idx].dressPay * addAllDress[idx].dressCount)} 원",
                                  style: TextStyle(
                                      fontFamily: 'noto',
                                      fontSize: 14,
                                      color: black),
                                )
                              ],
                            );
                          },
                          shrinkWrap: true,
                          itemCount: addAllDress.length,
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
                            Expanded(
                              child: Text(
                                "세탁금액",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontFamily: 'noto',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              "${numberFormat.format(allPay)} 원",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'noto',
                                  fontSize: 14,
                                  color: mainColor),
                            )
                          ],
                        ),
                        widget.type == 0 ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${widget.ncpPoint} NCP 적립",
                            style: TextStyle(
                                fontFamily: 'noto',
                                fontSize: 12,
                                color: mainColor),
                          ),
                        ) : Container()
                      ],
                    ),
                  ),
                ),
              ),
              whiteSpaceH(40),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: RaisedButton(
                    color: mainColor,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Laundry()),
                          (route) => false);
                    },
                    elevation: 0.0,
                    child: Center(
                      child: Text(
                        "확인",
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontFamily: 'noto',
                            fontWeight: FontWeight.w600),
                      ),
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
