import 'package:aladdinmagic/Home/Chauffeur/chauffeurbreakdown.dart';
import 'package:aladdinmagic/Home/Laundry/addressfind.dart';
import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Util/text.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class ChauffeurApply extends StatefulWidget {
  @override
  _ChauffeurApply createState() => _ChauffeurApply();
}

class _ChauffeurApply extends State<ChauffeurApply> {
  String startAddress = "";
  String endAddress = "";

  TextEditingController startAddressController = TextEditingController();
  TextEditingController endAddressController = TextEditingController();
  FocusNode endAddressNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            whiteSpaceH(8),
            Text(
              "출발지",
              style: TextStyle(
                  color: black,
                  fontFamily: 'noto',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
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
                          StyleCustom(text: startAddress, fontSize: 16)),
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => AddressFind()))
                            .then((value) {
                          if (value) {
                            setState(() {
                              startAddress = saveData.address;
                            });
                          }
                        });
                      },
                      color: mainColor,
                      elevation: 0.0,
                      child: Center(
                        child: customText(StyleCustom(
                            text: "주소검색", color: white, fontSize: 14)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            whiteSpaceH(8),
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: startAddressController,
              style: TextStyle(fontFamily: 'noto', color: black, fontSize: 16),
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
                  hintText: "상세 주소 입력",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                      borderRadius: BorderRadius.circular(0)),
                  contentPadding: EdgeInsets.only(left: 10, right: 10)),
            ),
            whiteSpaceH(24),
            Text(
              "도착지",
              style: TextStyle(
                  color: black,
                  fontFamily: 'noto',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
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
                          StyleCustom(text: endAddress, fontSize: 16)),
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => AddressFind()))
                            .then((value) {
                          if (value) {
                            setState(() {
                              endAddress = saveData.address;
                            });
                          }
                        });
                      },
                      color: mainColor,
                      elevation: 0.0,
                      child: Center(
                        child: customText(StyleCustom(
                            text: "주소검색", color: white, fontSize: 14)),
                      ),
                    ),
                  ),
                )
              ],
            ),
            whiteSpaceH(8),
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              controller: endAddressController,
              style: TextStyle(fontFamily: 'noto', color: black, fontSize: 16),
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
                  hintText: "상세 주소 입력",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                      borderRadius: BorderRadius.circular(0)),
                  contentPadding: EdgeInsets.only(left: 10, right: 10)),
            ),
            whiteSpaceH(40),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 44,
              child: RaisedButton(
                onPressed: () {
                  dialog();
                },
                color: mainColor,
                elevation: 0.0,
                child: Center(
                  child: Text(
                    "신청하기",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'noto',
                        color: white),
                  ),
                ),
              ),
            )
          ],
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
                          "가입하신 연락처로\n기사님께서 연락하십니다.",
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
                                              ChauffeurBreakdown(
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
