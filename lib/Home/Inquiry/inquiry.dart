import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:needsclear/Home/Inquiry/inquiryregister.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/inquirym.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class Inquiry extends StatefulWidget {
  @override
  _Inquiry createState() => _Inquiry();
}

class _Inquiry extends State<Inquiry> {
  List<bool> viewVisible = List();
  List<InquiryM> inquiryList = List();

  @override
  void initState() {
    super.initState();

    inquiryInit();
  }

  inquiryInit() async {
    await provider.selectInquiry(dataStorage.user.id).then((value) {
      List<dynamic> data = json.decode(value)['data'];
      print(json.decode(value)['data']);
      for (int i = 0; i < data.length; i++) {
        inquiryList.add(InquiryM(
            question: data[i]['question'],
            answer: data[i]['answer'],
            idx: data[i]['idx'],
            created_at: data[i]['created_at'],
            title: data[i]['title'],
            updated_at: data[i]['updated_at']));
        viewVisible.add(false);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: white,
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
        title: Text(
          "서비스 문의",
          style: TextStyle(
              fontFamily: 'noto',
              fontSize: 14,
              color: black,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => InquiryRegister()))
                      .then((value) {
                    viewVisible.clear();
                    inquiryList.clear();
                    inquiryInit();
                  });
                },
                child: Text(
                  "작성하기",
                  style: TextStyle(
                      color: mainColor,
                      fontFamily: 'noto',
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemBuilder: (context, idx) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      viewVisible[idx] = !viewVisible[idx];
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inquiryList[idx].title,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'noto',
                              color: black,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                viewVisible[idx]
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFFF7F7F7),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(
                                    "assets/needsclear/resource/public/q.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                whiteSpaceW(12),
                                Text(
                                  inquiryList[idx].question,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'noto',
                                      color: black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                whiteSpaceW(28),
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(
                                    "assets/needsclear/resource/public/a.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                whiteSpaceW(12),
                                Text(
                                  inquiryList[idx].answer != null
                                      ? inquiryList[idx].answer
                                      : "",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'noto',
                                      color: black),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
            );
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: inquiryList.length,
        ),
      ),
    );
  }
}
