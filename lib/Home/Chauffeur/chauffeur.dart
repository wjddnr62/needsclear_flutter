import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:needsclear/Home/Chauffeur/chauffeurUseGuide.dart';
import 'package:needsclear/Model/chauffeur.dart' as mCh;
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/user.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import '../home.dart';
import 'chauffeurapply.dart';
import 'chauffeurbreakdown.dart';

class Chauffeur extends StatefulWidget {
  @override
  _Chauffeur createState() => _Chauffeur();
}

class _Chauffeur extends State<Chauffeur> {
  String chauffeurValue = "전체";
  bool dataSet = false;
  List<mCh.Chauffeur> chList = List();
  bool viewOption = false;
  int viewType = 0;

  getChauffeur() {
    Provider provider = Provider();
    User user = DataStorage.dataStorage.user;

    provider.getChauffeur(user.id).then((value) {
      List<dynamic> datas = jsonDecode(value)['data'];

      for (Map<String, dynamic> data in datas) {
        mCh.Chauffeur chModel = mCh.Chauffeur(
            data['idx'],
            data['created_at'],
            data['startAddress'],
            data['endAddress'],
            data['id'],
            data['name'],
            data['phone'],
            data['payment'],
            data['gisaName'],
            data['gisaPhone'],
            data['type']);

        chList.add(chModel);
      }

      setState(() {
        dataSet = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getChauffeur();
  }

  String getAddressText(String string) {
    List<String> tmp = string.split(" ");
    return tmp[tmp.length - 1] + " " + tmp[tmp.length - 2];
  }

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
          centerTitle: true,
          title: mainMoveLogo(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Color(0xFFF7F7F7),
                padding: EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "대리운전 서비스",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 20,
                                  fontFamily: 'noto',
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChauffeurUseGuide()
                                ));
                              },
                              child: Text(
                                "이용 가이드 >",
                                style: TextStyle(
                                    fontFamily: 'noto',
                                    fontSize: 14,
                                    color: black),
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
                            "assets/needsclear/resource/service/driver.png",
                            width: 72,
                            height: 72,
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(22),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 43,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChauffeurApply()));
                        },
                        padding: EdgeInsets.zero,
                        color: white,
                        elevation: 0.0,
                        child: Center(
                          child: Text(
                            "신청하기",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        ),
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
                            items: <String>[
                              '전체',
                              '배차대기',
                              '기사출발',
                              '운행중',
                              '완료',
                              '취소'
                            ].map((value) {
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
                            value: chauffeurValue,
                            onChanged: (value) {
                              setState(() {
                                chauffeurValue = value;
                                if (value == "전체") {
                                  viewOption = false;
                                } else {
                                  viewOption = true;
                                  if (value == "배차대기") {
                                    viewType = 0;
                                  } else if (value == "기사출발") {
                                    viewType = 1;
                                  } else if (value == "운행중") {
                                    viewType = 2;
                                  } else if (value == "완료") {
                                    viewType = 3;
                                  } else if (value == "취소") {
                                    viewType = 4;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              whiteSpaceH(16),
              dataSet
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, idx) {
                          if (viewOption) {
                            if (chList[idx].type == viewType) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChauffeurBreakdown(
                                            type: chList[idx].type,
                                            startAddress:
                                            chList[idx].startAddress,
                                            endAddress: chList[idx].endAddress,
                                                payment: chList[idx].payment,
                                          )),
                                          (route) => false);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chList[idx].created_at.split(" ")[0],
                                      style: TextStyle(
                                          color: Color(0xFF888888),
                                          fontFamily: 'noto',
                                          fontSize: 12),
                                    ),
                                    whiteSpaceH(4),
                                    Row(
                                      children: [
                                        chList[idx].type == 0
                                            ? Image.asset(
                                          "assets/needsclear/resource/drive/matching.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : chList[idx].type == 1
                                            ? Image.asset(
                                          "assets/needsclear/resource/drive/start.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : chList[idx].type == 2
                                            ? Image.asset(
                                          "assets/needsclear/resource/drive/drive.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : chList[idx].type == 3
                                            ? Image.asset(
                                          "assets/needsclear/resource/drive/end.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : Image.asset(
                                          "assets/needsclear/resource/drive/end.png",
                                          width: 48,
                                          height: 48,
                                        ),
                                        whiteSpaceW(12),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  chList[idx].payment != null
                                                      ? "${numberFormat.format(
                                                      chList[idx].payment)} 원"
                                                      : "",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'noto',
                                                      color: black,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                ),
                                                whiteSpaceW(12),
                                                Text(
                                                  chList[idx].type == 0
                                                      ? "배차대기"
                                                      : chList[idx].type == 1
                                                      ? "기사출발"
                                                      : chList[idx].type == 2
                                                      ? "운행중"
                                                      : chList[idx].type ==
                                                      3
                                                      ? "완료"
                                                      : "취소",
                                                  style: chList[idx].type == 0
                                                      ? TextStyle(
                                                      color: Color(0xFFFFCC00),
                                                      fontFamily: 'noto',
                                                      fontSize: 12)
                                                      : chList[idx].type == 1
                                                      ? TextStyle(
                                                      color:
                                                      Color(0xFFFFCC00),
                                                      fontFamily: 'noto',
                                                      fontSize: 12)
                                                      : chList[idx].type == 2
                                                      ? TextStyle(
                                                      color: Color(
                                                          0xFF00AAFF),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12)
                                                      : chList[idx].type ==
                                                      3
                                                      ? TextStyle(
                                                      color: Color(
                                                          0xFF888888),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12)
                                                      : TextStyle(
                                                      color: Color(
                                                          0xFF888888),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "${getAddressText(chList[idx]
                                                  .startAddress)} > ${getAddressText(
                                                  chList[idx].endAddress)}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'noto',
                                                  color: Color(0xFF888888)),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Image.asset(
                                          "assets/needsclear/resource/public/small-arrow.png",
                                          width: 24,
                                          height: 24,
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(20)
                                  ],
                                ),
                              );
                            }
                          } else {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChauffeurBreakdown(
                                              type: chList[idx].type,
                                              startAddress:
                                              chList[idx].startAddress,
                                              endAddress: chList[idx]
                                                  .endAddress,
                                              payment: chList[idx].payment,
                                            )),
                                        (route) => false);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chList[idx].created_at.split(" ")[0],
                                    style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontFamily: 'noto',
                                        fontSize: 12),
                                  ),
                                  whiteSpaceH(4),
                                  Row(
                                    children: [
                                      chList[idx].type == 0
                                          ? Image.asset(
                                        "assets/needsclear/resource/drive/matching.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : chList[idx].type == 1
                                          ? Image.asset(
                                        "assets/needsclear/resource/drive/start.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : chList[idx].type == 2
                                          ? Image.asset(
                                        "assets/needsclear/resource/drive/drive.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : chList[idx].type == 3
                                          ? Image.asset(
                                        "assets/needsclear/resource/drive/end.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : Image.asset(
                                        "assets/needsclear/resource/drive/end.png",
                                        width: 48,
                                        height: 48,
                                      ),
                                      whiteSpaceW(12),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                chList[idx].payment != null
                                                    ? "${numberFormat.format(
                                                    chList[idx].payment)} 원"
                                                    : "",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'noto',
                                                    color: black,
                                                    fontWeight: FontWeight
                                                        .w600),
                                              ),
                                              whiteSpaceW(12),
                                              Text(
                                                chList[idx].type == 0
                                                    ? "배차대기"
                                                    : chList[idx].type == 1
                                                    ? "기사출발"
                                                    : chList[idx].type == 2
                                                    ? "운행중"
                                                    : chList[idx].type ==
                                                    3
                                                    ? "완료"
                                                    : "취소",
                                                style: chList[idx].type == 0
                                                    ? TextStyle(
                                                    color: Color(0xFFFFCC00),
                                                    fontFamily: 'noto',
                                                    fontSize: 12)
                                                    : chList[idx].type == 1
                                                    ? TextStyle(
                                                    color:
                                                    Color(0xFFFFCC00),
                                                    fontFamily: 'noto',
                                                    fontSize: 12)
                                                    : chList[idx].type == 2
                                                    ? TextStyle(
                                                    color: Color(
                                                        0xFF00AAFF),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize: 12)
                                                    : chList[idx].type ==
                                                    3
                                                    ? TextStyle(
                                                    color: Color(
                                                        0xFF888888),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize: 12)
                                                    : TextStyle(
                                                    color: Color(
                                                        0xFF888888),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${getAddressText(chList[idx]
                                                .startAddress)} > ${getAddressText(
                                                chList[idx].endAddress)}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'noto',
                                                color: Color(0xFF888888)),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Image.asset(
                                        "assets/needsclear/resource/public/small-arrow.png",
                                        width: 24,
                                        height: 24,
                                      )
                                    ],
                                  ),
                                  whiteSpaceH(20)
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                        shrinkWrap: true,
                        itemCount: chList.length,
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(mainColor),
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
