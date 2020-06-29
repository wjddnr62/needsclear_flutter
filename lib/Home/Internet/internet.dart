import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/internet.dart' as mIt;
import 'package:needsclear/Model/user.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import '../home.dart';
import 'internetUseGuide.dart';
import 'internetapply.dart';
import 'internetbreakdown.dart';

class Internet extends StatefulWidget {
  @override
  _Internet createState() => _Internet();
}

class _Internet extends State<Internet> {
  String internetValue = "전체";
  bool dataSet = false;
  List<mIt.Internet> internets = List();
  bool viewOption = false;
  int viewType = 0;

  getInternet() {
    Provider provider = Provider();
    User user = DataStorage.dataStorage.user;

    provider.getInternet(user.id).then((value) {
      List<dynamic> datas = jsonDecode(value)['data'];

      for (Map<String, dynamic> data in datas) {
        mIt.Internet chModel = mIt.Internet(
            data['idx'],
            data['id'],
            data['name'],
            data['phone'],
            data['applyNewsAgency'],
            data['applyService'],
            data['type'],
            data['payment'],
            data['created_at']);

        internets.add(chModel);
      }
      setState(() {
        dataSet = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getInternet();
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
          centerTitle: true,
          title: mainMoveLogo(context),
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Color(0xFFF7F7F7),
                padding:
                EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "인터넷 가입",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 20,
                                  fontFamily: 'noto',
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => InternetUseGuide()));
                              },
                              child: Text(
                                "이용 가이드 >",
                                style: TextStyle(
                                    fontFamily: 'noto',
                                    fontSize: 14,
                                    color: black),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: Image.asset(
                            "assets/needsclear/resource/service/internet.png",
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
                              builder: (context) => InternetApply()));
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
                            items: <String>['전체', '접수완료', '결제대기', '결제완료', '취소']
                                .map((value) {
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
                            value: internetValue,
                            onChanged: (value) {
                              setState(() {
                                internetValue = value;
                                if (value == "전체") {
                                  viewOption = false;
                                } else {
                                  viewOption = true;
                                  if (value == "접수완료") {
                                    viewType = 0;
                                  } else if (value == "결제대기") {
                                    viewType = 1;
                                  } else if (value == "결제완료") {
                                    viewType = 2;
                                  } else if (value == "취소") {
                                    viewType = 3;
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
                            if (internets[idx].type == viewType) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InternetBreakdown(
                                                type: internets[idx].type,
                                                name: internets[idx].name,
                                                phone: internets[idx].phone,
                                                newsAgency: internets[idx]
                                                    .applyNewsAgency,
                                                selectService:
                                                internets[idx].applyService,
                                              )),
                                          (route) => false);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      internets[idx].created_at.split(" ")[0],
                                      style: TextStyle(
                                          color: Color(0xFF888888),
                                          fontFamily: 'noto',
                                          fontSize: 12),
                                    ),
                                    whiteSpaceH(4),
                                    Row(
                                      children: [
                                        internets[idx].type == 0
                                            ? Image.asset(
                                          "assets/needsclear/resource/internet/contract.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : internets[idx].type == 1
                                            ? Image.asset(
                                          "assets/needsclear/resource/internet/contract.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : internets[idx].type == 2
                                            ? Image.asset(
                                          "assets/needsclear/resource/internet/end.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : internets[idx].type == 3
                                            ? Image.asset(
                                          "assets/needsclear/resource/internet/end.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : Container(),
                                        whiteSpaceW(12),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${internets[idx]
                                                      .applyNewsAgency}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'noto',
                                                      color: black,
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                                whiteSpaceW(12),
                                                Text(
                                                  internets[idx].type == 0
                                                      ? "접수완료"
                                                      : internets[idx].type == 1
                                                      ? "결제대기"
                                                      : internets[idx]
                                                      .type ==
                                                      2
                                                      ? "결제완료"
                                                      : internets[idx]
                                                      .type ==
                                                      3
                                                      ? "취소"
                                                      : "",
                                                  style: internets[idx].type ==
                                                      0
                                                      ? TextStyle(
                                                      color:
                                                      Color(0xFFFFCC00),
                                                      fontFamily: 'noto',
                                                      fontSize: 12)
                                                      : internets[idx].type == 1
                                                      ? TextStyle(
                                                      color: Color(
                                                          0xFFFFCC00),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12)
                                                      : internets[idx]
                                                      .type ==
                                                      2
                                                      ? TextStyle(
                                                      color: Color(
                                                          0xFF00AAFF),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12)
                                                      : internets[idx]
                                                      .type ==
                                                      3
                                                      ? TextStyle(
                                                      color: Color(
                                                          0xFF888888),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize:
                                                      12)
                                                      : TextStyle(
                                                      color: Color(
                                                          0xFFFFCC00),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize:
                                                      12),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "${internets[idx].applyService}",
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
                                            InternetBreakdown(
                                              type: internets[idx].type,
                                              name: internets[idx].name,
                                              phone: internets[idx].phone,
                                              newsAgency: internets[idx]
                                                  .applyNewsAgency,
                                              selectService:
                                              internets[idx].applyService,
                                            )),
                                        (route) => false);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    internets[idx].created_at.split(" ")[0],
                                    style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontFamily: 'noto',
                                        fontSize: 12),
                                  ),
                                  whiteSpaceH(4),
                                  Row(
                                    children: [
                                      internets[idx].type == 0
                                          ? Image.asset(
                                        "assets/needsclear/resource/internet/contract.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : internets[idx].type == 1
                                          ? Image.asset(
                                        "assets/needsclear/resource/internet/contract.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : internets[idx].type == 2
                                          ? Image.asset(
                                        "assets/needsclear/resource/internet/end.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : internets[idx].type == 3
                                          ? Image.asset(
                                        "assets/needsclear/resource/internet/end.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : Container(),
                                      whiteSpaceW(12),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${internets[idx]
                                                    .applyNewsAgency}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'noto',
                                                    color: black,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              whiteSpaceW(12),
                                              Text(
                                                internets[idx].type == 0
                                                    ? "접수완료"
                                                    : internets[idx].type == 1
                                                    ? "결제대기"
                                                    : internets[idx].type ==
                                                    2
                                                    ? "결제완료"
                                                    : internets[idx]
                                                    .type ==
                                                    3
                                                    ? "취소"
                                                    : "",
                                                style: internets[idx].type == 0
                                                    ? TextStyle(
                                                    color:
                                                    Color(0xFFFFCC00),
                                                    fontFamily: 'noto',
                                                    fontSize: 12)
                                                    : internets[idx].type == 1
                                                    ? TextStyle(
                                                    color: Color(
                                                        0xFFFFCC00),
                                                    fontFamily: 'noto',
                                                    fontSize: 12)
                                                    : internets[idx].type ==
                                                    2
                                                    ? TextStyle(
                                                    color: Color(
                                                        0xFF00AAFF),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize: 12)
                                                    : internets[idx]
                                                    .type ==
                                                    3
                                                    ? TextStyle(
                                                    color: Color(
                                                        0xFF888888),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize:
                                                    12)
                                                    : TextStyle(
                                                    color: Color(
                                                        0xFFFFCC00),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize:
                                                    12),
                                              )
                                            ],
                                          ),
                                          Text(
                                            "${internets[idx].applyService}",
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
                        itemCount: internets.length,
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
