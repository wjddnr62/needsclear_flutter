import 'package:flutter/material.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class RecoTerms extends StatefulWidget {
  @override
  _RecoTerms createState() => _RecoTerms();
}

class _RecoTerms extends State<RecoTerms> {
  String termsText = "";
  bool selectCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    termsText = "약관 내용입니다.";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(false);
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0.0,
          centerTitle: true,
          title: mainMove("약관 및 정책 동의", context),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: Image.asset(
              "assets/needsclear/resource/public/prev.png",
              width: 24,
              height: 240,
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  whiteSpaceW(8),
                  Text(
                    "추천인 데이터 저장에 대한 동의(선택)",
                    style: TextStyle(
                        fontFamily: 'noto',
                        fontSize: 16,
                        color: Color(0xFF888888)),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              whiteSpaceH(8),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: white, border: Border.all(color: Color(0xFFDDDDDD))),
                padding: EdgeInsets.all(12),
                child: Text(
                  termsText,
                  style:
                      TextStyle(color: black, fontSize: 13, fontFamily: 'noto'),
                ),
              ),
              whiteSpaceH(60),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  elevation: 0.0,
                  color: mainColor,
                  child: Center(
                    child: Text(
                      "동의",
                      style: TextStyle(
                          fontFamily: 'noto',
                          fontSize: 16,
                          color: white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              whiteSpaceH(24),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "약관 및 정책 자세히 보기",
                  style:
                      TextStyle(color: black, fontSize: 16, fontFamily: 'noto'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
