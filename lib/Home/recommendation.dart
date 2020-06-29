import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:needsclear/Home/recoterms.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/user.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class Recommendation extends StatefulWidget {
  @override
  _Recommendation createState() => _Recommendation();
}

class _Recommendation extends State<Recommendation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactUsController = TextEditingController();
  FocusNode contactUsFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: mainMoveLogo(context),
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
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whiteSpaceH(24),
              Text(
                "추천인 등록하기",
                style: TextStyle(
                    color: black,
                    fontFamily: 'noto',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              whiteSpaceH(4),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                controller: nameController,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(contactUsFocus);
                },
                decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontFamily: 'noto'),
                    hintText: "이름",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                        borderRadius: BorderRadius.circular(0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                        borderRadius: BorderRadius.circular(0)),
                    contentPadding: EdgeInsets.only(left: 10, right: 10)),
              ),
              whiteSpaceH(8),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: contactUsController,
                focusNode: contactUsFocus,
                decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontFamily: 'noto'),
                    hintText: "연락처",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFCCCCCC)),
                        borderRadius: BorderRadius.circular(0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor),
                        borderRadius: BorderRadius.circular(0)),
                    contentPadding: EdgeInsets.only(left: 10, right: 10)),
              ),
              whiteSpaceH(12),
              Text(
                "* 니즈클리어의 추천인 시스템은 다른 우고스 플랫폼과 다른 시스템입니다.",
                style: TextStyle(
                    fontFamily: 'noto', fontSize: 12, color: Color(0xFF888888)),
              ),
              Text(
                "* 입력된 이름과 전화번호로 회원가입이 이루어질 시 자동으로 내 직추천인으로 등록됩니다.",
                style: TextStyle(
                    fontFamily: 'noto', fontSize: 12, color: Color(0xFF888888)),
              ),
              whiteSpaceH(56),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    if (nameController.text == "" ||
                        nameController.text == null) {
                      showToast("이름을 입력해주세요.");
                    } else if (contactUsController.text == "" ||
                        contactUsController.text == null) {
                      showToast("연락처를 입력해주세요.");
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => RecoTerms()))
                          .then((check) {
                        if (check) {
                          User user = DataStorage.dataStorage.user;
                          print(user.idx);
                          print(user.recoCode);
                          Provider()
                              .insertReco(user.idx, user.recoCode,
                                  nameController.text, contactUsController.text)
                              .then((value) {
                            var json = jsonDecode(value);
                            print(value);
                            if (json['result'] == 1) {
                              nameController.text = "";
                              contactUsController.text = "";
                              dialog();
                            } else {
                              print("안됨");
                            }
                          });
                        } else {
                          showToast("추천인 등록 약관에 동의되지 않았습니다.");
                        }
                      });
                    }
                  },
                  elevation: 0.0,
                  color: mainColor,
                  child: Center(
                    child: Text(
                      "등록하기",
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontFamily: 'noto',
                          fontWeight: FontWeight.w600),
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
              height: 300,
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
                          "추천인이 등록되었습니다",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'noto',
                              fontSize: 14),
                        ),
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
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 40,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
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
