import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  onPressed: () {},
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
}
