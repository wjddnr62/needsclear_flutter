import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/savelog.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import 'dlsend.dart';

class Dl extends StatefulWidget {
  @override
  _Dl createState() => _Dl();
}

class _Dl extends State<Dl> {
  String selectValue = "최신순";

  List<SaveLog> saveLogList = new List();

  @override
  void initState() {
    super.initState();

    saveLogInit();
  }

  saveLogInit() async {
    await provider.selectSavelog(dataStorage.user.id).then((value) {
      List<dynamic> saveLog = json.decode(value)['data'];
      for (int i = 0; i < saveLog.length; i++) {
        saveLogList.add(SaveLog(
            name: saveLog[i]['name'],
            type: saveLog[i]['type'],
            id: saveLog[i]['id'],
            date: saveLog[i]['date'],
            phone: saveLog[i]['phone'],
            point: saveLog[i]['point'],
            saveType: saveLog[i]['saveType']));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whiteSpaceH(52),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 88,
                color: white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "나의 DL",
                          style: TextStyle(
                              fontFamily: 'noto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceW(4),
                        Image.asset(
                          "assets/needsclear/resource/public/dl-coin.png",
                          width: 24,
                          height: 24,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DlSend()));
                          },
                          child: Text(
                            "전송하기 >",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 12,
                                color: Color(0xFF22EEFF),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "${dataStorage.user.dl.toInt()}",
                                  style: TextStyle(
                                      fontFamily: 'noto',
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: 28),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: " DL",
                                        style: TextStyle(
                                            fontFamily: 'noto',
                                            fontSize: 14,
                                            color: black,
                                            fontWeight: FontWeight.w600))
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              whiteSpaceH(16),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: white,
                child: Row(
                  children: [
                    Text(
                      "전체결과",
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
                      width: 70,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: DropdownButton<String>(
                          underline: Container(),
                          elevation: 0,
                          style: TextStyle(
                              color: black, fontSize: 14, fontFamily: 'noto'),
                          items: <String>['최신순', '과거순'].map((value) {
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
                          value: selectValue,
                          onChanged: (value) {
                            setState(() {
                              selectValue = value;
                              if (value == "최신순") {
//                            alignment = 0;
                                saveLogList.sort((a, b) => b.date
                                    .toString()
                                    .compareTo(a.date.toString()));
                              } else {
//                            alignment = 1;
                                saveLogList.sort((a, b) => a.date
                                    .toString()
                                    .compareTo(b.date.toString()));
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              whiteSpaceH(16),
              ListView.builder(
                itemBuilder: (context, idx) {
                  if (saveLogList[idx].saveType == 2) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          saveLogList[idx].date.split(" ")[0],
                          style: TextStyle(
                              color: Color(0xFF888888),
                              fontFamily: 'noto',
                              fontSize: 12),
                        ),
                        whiteSpaceH(4),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 88,
                          color: white,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/needsclear/resource/public/dl-coin.png",
                                width: 48,
                                height: 48,
                              ),
                              whiteSpaceW(12),
                              Text(
                                "DL 환전",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'noto',
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Text(
                                "${numberFormat.format(saveLogList[idx].point / 1000)} DL",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: mainColor,
                                    fontFamily: 'noto',
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
                itemCount: saveLogList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
