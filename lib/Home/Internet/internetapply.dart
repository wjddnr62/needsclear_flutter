import 'package:aladdinmagic/Util/showToast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

import 'internetbreakdown.dart';

class InternetApply extends StatefulWidget {
  @override
  _InternetApply createState() => _InternetApply();
}

class _InternetApply extends State<InternetApply> {
  TextEditingController nameController = TextEditingController();
  TextEditingController middleController = TextEditingController();
  TextEditingController endController = TextEditingController();

  FocusNode middleFocus = FocusNode();
  FocusNode endFocus = FocusNode();

  String startPhone = "010";
  String selectNewsAgency = "통신사";
  String serviceSelect = "인터넷";

  List<String> startPhoneList = List();
  List<String> selectNewsAgencyList = List();
  List<String> serviceSelectList = List();

  bool selectCheck = false;

  @override
  void initState() {
    super.initState();

    startPhoneList..add("010")..add("011")..add("012");
    selectNewsAgencyList..add("통신사")..add("SKT")..add("LG")..add("KT");
    serviceSelectList..add("인터넷")..add("TV + 인터넷");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1.0,
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
          "인터넷 신청",
          style: TextStyle(
              color: black,
              fontSize: 14,
              fontFamily: 'noto',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 88,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 8)
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    "assets/needsclear/resource/home/internet/lg.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              whiteSpaceH(16),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 88,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 8)
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    "assets/needsclear/resource/home/internet/sk.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              whiteSpaceH(16),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 88,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2), blurRadius: 8)
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    "assets/needsclear/resource/home/internet/kt.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              whiteSpaceH(24),
              Text(
                "신청자 정보",
                style: TextStyle(
                    fontFamily: 'noto',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: black),
              ),
              whiteSpaceH(4),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                style:
                    TextStyle(fontFamily: 'noto', color: black, fontSize: 16),
                controller: nameController,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(middleFocus);
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(color: Color(0xFFDDDDDD))),
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontFamily: 'noto'),
                    hintText: "이름",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                        borderRadius: BorderRadius.circular(0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                        borderRadius: BorderRadius.circular(0)),
                    contentPadding: EdgeInsets.only(left: 10, right: 10)),
              ),
              whiteSpaceH(8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: DropdownButton<String>(
                          underline: Container(),
                          elevation: 0,
                          isExpanded: true,
                          style: TextStyle(
                              color: black, fontSize: 16, fontFamily: 'noto'),
                          items: startPhoneList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontFamily: 'noto'),
                              ),
                            );
                          }).toList(),
                          value: startPhone,
                          onChanged: (value) {
                            setState(() {
                              startPhone = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  whiteSpaceW(8),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller: middleController,
                        focusNode: middleFocus,
                        style: TextStyle(
                            fontFamily: 'noto', color: black, fontSize: 16),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(endFocus);
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: Color(0xFFDDDDDD))),
                            counterText: "",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFDDDDDD)),
                                borderRadius: BorderRadius.circular(0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                                borderRadius: BorderRadius.circular(0)),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                    ),
                  ),
                  whiteSpaceW(8),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: endController,
                        focusNode: endFocus,
                        style: TextStyle(
                            fontFamily: 'noto', color: black, fontSize: 16),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: Color(0xFFDDDDDD))),
                            counterText: "",
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFDDDDDD)),
                                borderRadius: BorderRadius.circular(0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                                borderRadius: BorderRadius.circular(0)),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                    ),
                  ),
                ],
              ),
              whiteSpaceH(12),
              Text("서비스 선택",
                  style: TextStyle(
                      fontFamily: 'noto',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: black)),
              whiteSpaceH(4),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: white, border: Border.all(color: Color(0xFFDDDDDD))),
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: DropdownButton<String>(
                    underline: Container(),
                    elevation: 0,
                    isExpanded: true,
                    style: TextStyle(
                        color: black, fontSize: 16, fontFamily: 'noto'),
                    items: selectNewsAgencyList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: black, fontSize: 16, fontFamily: 'noto'),
                        ),
                      );
                    }).toList(),
                    value: selectNewsAgency,
                    onChanged: (value) {
                      setState(() {
                        selectNewsAgency = value;
                      });
                    },
                  ),
                ),
              ),
              whiteSpaceH(8),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: white, border: Border.all(color: Color(0xFFDDDDDD))),
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: DropdownButton<String>(
                    underline: Container(),
                    elevation: 0,
                    isExpanded: true,
                    style: TextStyle(
                        color: black, fontSize: 16, fontFamily: 'noto'),
                    items: serviceSelectList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: black, fontSize: 16, fontFamily: 'noto'),
                        ),
                      );
                    }).toList(),
                    value: serviceSelect,
                    onChanged: (value) {
                      setState(() {
                        serviceSelect = value;
                      });
                    },
                  ),
                ),
              ),
              whiteSpaceH(16),
              Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: Checkbox(
                      activeColor: mainColor,
                      value: selectCheck,
                      onChanged: (value) {
                        setState(() {
                          selectCheck = value;
                        });
                      },
                    ),
                  ),
                  whiteSpaceW(12),
                  Text(
                    "개인정보 제 3자 제공 및 위탁동의",
                    style: TextStyle(
                        fontFamily: 'noto',
                        fontSize: 12,
                        color: Color(0xFF888888)),
                  )
                ],
              ),
              whiteSpaceH(40),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 44,
                child: RaisedButton(
                  onPressed: () {
                    dialog();
                    if (nameController.text == "") {
                      showToast("이름을 입력해주세요.");
                    } else if (middleController.text == "" ||
                        endController.text == "") {
                      showToast("전화번호를 입력해주세요.");
                    } else if (selectNewsAgency == "통신사") {
                      showToast("통신사를 선택해주세요.");
                    } else if (!selectCheck) {
                      showToast("개인정보 제 3자 제공에 대한 동의를 해주세요.");
                    } else {
                      dialog();
                    }
                  },
                  color: mainColor,
                  child: Center(
                    child: Text(
                      "신청하기",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'noto',
                          fontWeight: FontWeight.w600,
                          color: white),
                    ),
                  ),
                ),
              ),
              whiteSpaceH(90)
            ],
          ),
        ),
      ),
    );
  }

  dialog() {
    return showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            backgroundColor: white,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(0)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        whiteSpaceH(20),
                        Text(
                          "신청하시겠습니까?",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'noto',
                              fontSize: 14),
                        ),
                        whiteSpaceH(24),
                        Text(
                          "입력하신 정보로\n인터넷 신청이 진행됩니다.",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'noto',
                              color: Color(0xFF666666)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(0))),
                                child: Text(
                                  "취소",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black,
                                      fontWeight: FontWeight.w600),
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
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InternetBreakdown(
                                                type: 0,
                                              )),
                                      (route) => false);
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(0)),
                                ),
                                child: Center(
                                  child: Text(
                                    "확인",
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }
}
