import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class DlSend extends StatefulWidget {
  @override
  _DlSend createState() => _DlSend();
}

class _DlSend extends State<DlSend> {
  String platformValue = "캐시링크";
  TextEditingController dlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: Image.asset(
            "assets/needsclear/resource/public/prev.png",
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          "전송하기",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'noto',
            color: black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whiteSpaceH(8),
              Text(
                "전송 계좌",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontFamily: 'noto',
                    fontSize: 16),
              ),
              whiteSpaceH(4),
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
                    items: ['캐시링크'].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              color: black, fontSize: 16, fontFamily: 'noto'),
                        ),
                      );
                    }).toList(),
                    value: platformValue,
                    onChanged: (value) {
                      setState(() {
                        platformValue = value;
                      });
                    },
                  ),
                ),
              ),
              whiteSpaceH(24),
              Row(
                children: [
                  Text(
                    "전송 DL 수량",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontFamily: 'noto',
                        fontSize: 16),
                  ),
                  whiteSpaceW(12),
                  Text(
                    "보유 DL : ",
                    style: TextStyle(
                        fontFamily: 'noto', color: black, fontSize: 12),
                  ),
                  Text(
                    "${numberFormat.format(dataStorage.user.dl)} DL",
                    style: TextStyle(
                        fontSize: 12, color: mainColor, fontFamily: 'noto'),
                  )
                ],
              ),
              whiteSpaceH(4),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: white, border: Border.all(color: Color(0xFFCCCCCC))),
                child: TextFormField(
                  maxLines: 1,
                  controller: dlController,
                  autofocus: true,
                  onChanged: (value) {},
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  style: TextStyle(fontSize: 16, color: black),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      suffixText: "DL",
                      suffixStyle: TextStyle(
                          fontSize: 16, color: black, fontFamily: 'noto'),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 10)),
                ),
              ),
              whiteSpaceH(24),
              Text(
                "전송결과",
                style: TextStyle(
                    fontFamily: 'noto',
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              whiteSpaceH(16),
              Row(
                children: [
                  Text(
                    "잔여 DL",
                    style: TextStyle(
                        fontSize: 14, color: black, fontFamily: 'noto'),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    "0 DL",
                    style: TextStyle(
                        fontSize: 14, color: black, fontFamily: 'noto'),
                  )
                ],
              ),
              whiteSpaceH(4),
              Text(
                "* 전송 시 약간의 시간이 소요될 수 있습니다.",
                style: TextStyle(
                    fontFamily: 'noto', color: Color(0xFF888888), fontSize: 12),
              ),
              whiteSpaceH(40),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    showToast("서비스 준비중입니다.");
                  },
                  elevation: 0.0,
                  color: mainColor,
                  child: Center(
                      child: Text(
                    "전송하기",
                    style: TextStyle(
                        fontSize: 14,
                        color: white,
                        fontFamily: 'noto',
                        fontWeight: FontWeight.w600),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
