import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:needsclear/Home/Phone/phonebreakdown.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/user.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class PhoneApply extends StatefulWidget {
  @override
  _PhoneApply createState() => _PhoneApply();
}

class _PhoneApply extends State<PhoneApply> {
  TextEditingController nameController = TextEditingController();
  TextEditingController middleController = TextEditingController();
  TextEditingController endController = TextEditingController();

  FocusNode middleFocus = FocusNode();
  FocusNode endFocus = FocusNode();

  String startPhone = "010";
  String nowNewsAgency = "현재 통신사";
  String changeNewsAgency = "변경 통신사";
  String serviceSelect = "번호이동";
  String selectDevice = "희망기종";

  List<String> startPhoneList = List();
  List<String> nowNewsAgencyList = List();
  List<String> changeNewsAgencyList = List();
  List<String> serviceSelectList = List();
  List<String> selectDeviceList = List();

  bool selectCheck = false;

  bool dataSet = false;
  List<String> deviceImage = List();

  @override
  void initState() {
    super.initState();

    startPhoneList..add("010")..add("011")..add("012");
    nowNewsAgencyList..add("현재 통신사")..add("SKT")..add("LG")..add("KT");
    changeNewsAgencyList..add("변경 통신사")..add("SKT")..add("LG")..add("KT");
    serviceSelectList..add("번호이동");
    selectDeviceList..add("희망기종");

    Provider().getDevice().then((value) {
      List<dynamic> datas = jsonDecode(value)['data'];
      for(Map<String ,dynamic> data in datas) {
        selectDeviceList..add(data['deviceName']);
        deviceImage.add(data['deviceImage']);
      }
      setState(() {
        dataSet = true;
      });
    });
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
          "휴대폰 신청",
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
//              Image.asset(
//                "assets/needsclear/resource/home/phone/phone_image.png",
//                fit: BoxFit.contain,
//              ),
              dataSet
                  ? StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, idx) {
                    return Column(
                      children: [
                        Image.memory(base64.decode(deviceImage[idx].split(
                            ",")[1]), fit: BoxFit.contain,),

                      ],
                    );
                    return Container();
                  },
                  itemCount: deviceImage.length,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  staggeredTileBuilder: (idx) => StaggeredTile.fit(1))
                  : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                ),
              ),
              whiteSpaceH(20),
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
              Text("통신사 선택",
                  style: TextStyle(
                      fontFamily: 'noto',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: black)),
              whiteSpaceH(4),
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
                          items: nowNewsAgencyList.map((value) {
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
                          value: nowNewsAgency,
                          onChanged: (value) {
                            setState(() {
                              nowNewsAgency = value;
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
                          items: changeNewsAgencyList.map((value) {
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
                          value: changeNewsAgency,
                          onChanged: (value) {
                            setState(() {
                              changeNewsAgency = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
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
              whiteSpaceH(12),
              Text(
                "기종 선택",
                style: TextStyle(
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'noto'),
              ),
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
                    items: selectDeviceList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: black, fontSize: 16, fontFamily: 'noto'),
                        ),
                      );
                    }).toList(),
                    value: selectDevice,
                    onChanged: (value) {
                      setState(() {
                        selectDevice = value;
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
                    if (nameController.text == "") {
                      showToast("이름을 입력해주세요.");
                    } else if (middleController.text == "" ||
                        endController.text == "") {
                      showToast("전화번호를 입력해주세요.");
                    } else if (nowNewsAgency == "현재 통신사") {
                      showToast("현재 통신사를 선택해주세요.");
                    } else if (changeNewsAgency == "변경 통신사") {
                      showToast("변경 통신사를 선택해주세요.");
                    } else if (selectDevice == "희망기종") {
                      showToast("기종을 선택해주세요.");
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

  bool touch = false;

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
                          "입력하신 정보로\n휴대폰 신청이 진행됩니다.",
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
                                  if (!touch) {
                                    touch = true;
                                    Provider provider = Provider();
                                    User user = DataStorage.dataStorage.user;

                                    provider
                                        .insertPhone(
                                        user.id,
                                        nameController.text,
                                        startPhone + middleController.text +
                                            endController.text,
                                        nowNewsAgency,
                                        changeNewsAgency,
                                        serviceSelect == "번호이동" ? 0 : "",
                                        selectDevice)
                                        .then((value) {
                                      print(value);
                                      touch = false;
                                      var json = jsonDecode(value);
                                      if (json['result'] == 1) {
                                        Navigator.of(
                                            context, rootNavigator: true)
                                            .pop();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PhoneBreakdown(
                                                      type: 0,
                                                      name: nameController.text,
                                                      phone: startPhone +
                                                          middleController
                                                              .text +
                                                          endController.text,
                                                      changeNewsAgency: changeNewsAgency,
                                                      selectDeviceName: selectDevice,
                                                    )),
                                                (route) => false);
                                      } else {
                                        touch = false;
                                        print("안됨");
                                      }
                                    });
                                  }


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
