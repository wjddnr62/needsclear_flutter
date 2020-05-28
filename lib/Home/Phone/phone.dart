import 'package:aladdinmagic/Home/Phone/phoneapply.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class Phone extends StatefulWidget {
  @override
  _Phone createState() => _Phone();
}

class _Phone extends State<Phone> {
  String phoneValue = "전체";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()), (route) => false),
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            },
            icon: Image.asset(
              "assets/needsclear/resource/public/prev.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 96,
                color: Color(0xFFF7F7F7),
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "휴대폰 구매",
                          style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontFamily: 'noto',
                              fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PhoneApply()));
                          },
                          child: Text(
                            "신청하기 >",
                            style: TextStyle(
                                fontFamily: 'noto', fontSize: 14, color: black),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Image.asset(
                        "assets/needsclear/resource/service/phone.png",
                        width: 72,
                        height: 72,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: white,
                  child: Row(
                    children: [
                      Text(
                        "이용내역",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'noto',
                            fontSize: 14,
                            color: black),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: DropdownButton<String>(
                            underline: Container(),
                            elevation: 0,
                            style: TextStyle(
                                color: black, fontSize: 14, fontFamily: 'noto'),
                            items: <String>['전체', '접수완료', '완료'].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontFamily: 'noto'),
                                ),
                              );
                            }).toList(),
                            value: phoneValue,
                            onChanged: (value) {
                              setState(() {
                                phoneValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
