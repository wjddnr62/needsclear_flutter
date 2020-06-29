import 'package:flutter/material.dart';
import 'package:needsclear/Model/dress.dart';
import 'package:needsclear/Model/savedata.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/text.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import 'addressfind.dart';
import 'buy.dart';

class LaundryPayment extends StatefulWidget {
  final int allPay;
  final List<DressSet> dressNormal;
  final List<DressSet> dressPremium;
  final List<int> dressPaymentNormal;
  final List<int> dressPaymentPremium;

  LaundryPayment(
      {this.allPay,
      this.dressNormal,
      this.dressPremium,
      this.dressPaymentNormal,
      this.dressPaymentPremium});

  @override
  _LaundryPayment createState() => _LaundryPayment();
}

class _LaundryPayment extends State<LaundryPayment> {
  bool method = false;
  TextEditingController address = TextEditingController();
  FocusNode addressNode = FocusNode();
  String firstAddress = "";
  String zoneCode = "";

  @override
  void initState() {
    super.initState();
  }

  static final _textKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
//        Navigator.of(context).pushReplacement(MaterialPageRoute(
//            builder: (context) => LaundryApply(
//                  type: 1,
//                  dress: widget.dress,
//                  allPay: widget.allPay,
//                )));
        Navigator.of(context).pop();
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
//              Navigator.of(context).pushReplacement(MaterialPageRoute(
//                  builder: (context) => LaundryApply(
//                        type: 1,
//                        dress: widget.dress,
//                        allPay: widget.allPay,
//                      )));
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              "assets/needsclear/resource/public/prev.png",
              width: 24,
              height: 24,
            ),
          ),
          centerTitle: true,
          title: mainMove("결제하기", context),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    whiteSpaceH(8),
                    Text(
                      "발송정보",
                      style: TextStyle(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'noto'),
                    ),
                    whiteSpaceH(34),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () {
                                if (method) {
                                  setState(() {
                                    method = false;
                                  });
                                }
                                setState(() {
                                  addressNode.unfocus();
                                });
                              },
                              shape: !method
                                  ? null
                                  : Border.all(color: Color(0xFFDDDDDD)),
                              elevation: 0.0,
                              color: !method ? mainColor : white,
                              child: Center(
                                child: Text(
                                  "택배발송",
                                  style: TextStyle(
                                      fontFamily: 'noto',
                                      fontSize: 14,
                                      color:
                                          !method ? white : Color(0xFF888888)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () {
                                if (!method) {
                                  setState(() {
                                    method = true;
                                    addressNode.requestFocus();
                                  });
                                }
                              },
                              shape: method
                                  ? null
                                  : Border.all(color: Color(0xFFDDDDDD)),
                              color: method ? mainColor : white,
                              elevation: 0.0,
                              child: Center(
                                child: Text(
                                  "방문수령",
                                  style: TextStyle(
                                      color: method ? white : Color(0xFF888888),
                                      fontSize: 14,
                                      fontFamily: 'noto'),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(24),
                    customText(StyleCustom(
                        text: "주소", fontSize: 10, color: Color(0xFF888888))),
                    whiteSpaceH(4),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFDDDDDD)),
                                color: Color(0xFFF2F2F2)),
                            child: Center(
                              child: customText(
                                  StyleCustom(text: zoneCode, fontSize: 16)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: RaisedButton(
                              onPressed: () {
                                if (method) {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => AddressFind()))
                                      .then((value) {
                                    if (value) {
                                      setState(() {
                                        firstAddress = saveData.address;
                                        zoneCode = saveData.zoneCode;
                                      });
                                    }
                                  });
                                }
                              },
                              shape: !method
                                  ? Border.all(color: Color(0xFFCCCCCC))
                                  : null,
                              color: !method ? Color(0xFFDDDDDD) : mainColor,
                              elevation: 0.0,
                              child: Center(
                                child: customText(StyleCustom(
                                    text: "주소검색",
                                    color: !method ? Color(0xFF888888) : white,
                                    fontSize: 14)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(8),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFDDDDDD)),
                          color: Color(0xFFF2F2F2)),
                      child: Center(
                        child: customText(
                            StyleCustom(fontSize: 16, text: firstAddress)),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      controller: address,
                      focusNode: addressNode,
                      key: _textKey,
                      style: TextStyle(
                          fontFamily: 'noto',
                          color: method ? black : Color(0xFF888888),
                          fontSize: 16),
                      readOnly: method ? false : true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: method ? white : Color(0xFFF2F2F2),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(color: Color(0xFFDDDDDD))),
                          counterText: "",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167),
                              fontFamily: 'noto'),
                          hintText: "상세 주소 입력",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                              borderRadius: BorderRadius.circular(0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(0)),
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                    ),
                    whiteSpaceH(6),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xFFDDDDDD),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10,
                color: Color(0xFFEEEEEE),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xFFDDDDDD),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    whiteSpaceH(8),
                    Text(
                      "결제금액",
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontFamily: 'noto',
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(16),
                    Row(
                      children: [
                        Expanded(
                          child: customText(
                              StyleCustom(text: "세탁비", fontSize: 14)),
                        ),
                        customText(StyleCustom(
                            fontSize: 14,
                            text: numberFormat.format(widget.allPay) + " 원",
                            color: black))
                      ],
                    ),
                    whiteSpaceH(5),
                    Row(
                      children: [
                        Expanded(
                          child: customText(StyleCustom(
                              text: "발송비", fontSize: 14, color: black)),
                        ),
                        customText(StyleCustom(
                            fontSize: 14,
                            text: numberFormat.format(0) + " 원",
                            color: black))
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
                        Expanded(
                          child: customText(StyleCustom(
                              text: "총 금액",
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w600)),
                        ),
                        customText(StyleCustom(
                            fontSize: 16,
                            text: numberFormat.format(widget.allPay) + " 원",
                            fontWeight: FontWeight.w600,
                            color: mainColor))
                      ],
                    ),
                    whiteSpaceH(40),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 44,
                      child: RaisedButton(
                        onPressed: () {
                          if (method) {
                            if (firstAddress == "" || address.text == "") {
                              showToast("주소를 입력해주세요.");
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Buy(
                                        address:
                                            firstAddress + " " + address.text,
                                        amount: 100,
                                        allPay: widget.allPay,
                                        dressNormal: widget.dressNormal,
                                        dressPremium: widget.dressPremium,
                                        dressPaymentNormal:
                                            widget.dressPaymentNormal,
                                        dressPaymentPremium:
                                            widget.dressPaymentPremium,
                                        collectionType: 1,
                                      )));
                            }
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Buy(
                                      address: "",
                                      amount: 100,
                                      allPay: widget.allPay,
                                      dressNormal: widget.dressNormal,
                                      dressPremium: widget.dressPremium,
                                      dressPaymentNormal:
                                          widget.dressPaymentNormal,
                                      dressPaymentPremium:
                                          widget.dressPaymentPremium,
                                      collectionType: 0,
                                    )));
                          }
                        },
                        elevation: 0.0,
                        color: mainColor,
                        child: Center(
                          child: customText(StyleCustom(
                              text: "결제하기",
                              color: white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
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
