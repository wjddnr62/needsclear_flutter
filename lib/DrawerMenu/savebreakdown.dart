import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/main.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaveBreakDown extends StatefulWidget {
  @override
  _SaveBreakDown createState() => _SaveBreakDown();
}

class _SaveBreakDown extends State<SaveBreakDown> {
  SaveData saveData = SaveData();
  UserProvider userProvider = UserProvider();

  bool bubble = false;

  int alignment = 0;

  int allSavePoint = 0;
  int useSavePoint = 0;

  getPoint() {
    userProvider.getSavePoint(saveData.id, 0).then((value) {
      setState(() {
        allSavePoint = value;
      });
    });
    userProvider.getSavePoint(saveData.id, 1).then((value) {
      setState(() {
        useSavePoint = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getPoint();
  }

  serviceDialog(msg) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "알림",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromARGB(255, 167, 167, 167),
                  ),
                  whiteSpaceH(20),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 167, 167, 167)),
                            child: Center(
                              child: Text(
                                "확인",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "적립금내역",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: black),
        ),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: bubble ? NeverScrollableScrollPhysics() : null,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              whiteSpaceH(20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (bubble) {
                      bubble = false;
                    } else {
                      bubble = true;
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      numberFormat.format(saveData.point) + "원",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: mainColor),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      whiteSpaceH(5),
                      Center(
                        child: Text(
                          "(보유 적립금)",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      whiteSpaceH(5),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            serviceDialog("서비스 준비 중입니다.");
                          },
                          child: Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 167, 167, 167),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                "출금하기",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      whiteSpaceH(15),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        color: Color.fromARGB(255, 219, 219, 219),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  alignment = 0;
                                });
                              },
                              child: Text(
                                "최신순",
                                style: TextStyle(
                                    color: alignment == 0
                                        ? Colors.blueAccent
                                        : black),
                              ),
                            ),
                            whiteSpaceW(15),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  alignment = 1;
                                });
                              },
                              child: Text(
                                "과거순",
                                style: TextStyle(
                                    color: alignment == 1
                                        ? Colors.blueAccent
                                        : black),
                              ),
                            ),
                            whiteSpaceW(15),
                          ],
                        ),
                      ),
                      StreamBuilder(
                        stream: Firestore.instance
                            .collection('saveLog')
                            .where("id", isEqualTo: saveData.id)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (alignment == 1) {
                              snapshot.data.documents.sort((a, b) => a['date']
                                  .toString()
                                  .compareTo(b['date'].toString()));
                            } else {
                              snapshot.data.documents.sort((a, b) => b['date']
                                  .toString()
                                  .compareTo(a['date'].toString()));
                            }
                            return Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              whiteSpaceW(10),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(document['saveType'] ==
                                                            0
                                                        ? "회원가입 적립"
                                                        : document['saveType'] ==
                                                                1
                                                            ? "추천인 회원가입"
                                                            : document['saveType'] ==
                                                                    2
                                                                ? "택배 적립"
                                                                : document['saveType'] ==
                                                                        3
                                                                    ? "운영팀 적립"
                                                                    : document['saveType'] ==
                                                                            4
                                                                        ? "관리자 세탁 적립"
                                                                        : document['saveType'] ==
                                                                                5
                                                                            ? "관리자 택배 적립"
                                                                            : document['saveType'] == 6
                                                                                ? "관리자 꽃배달 적립"
                                                                                : document['saveType'] == 7 ? "관리자 대리운전 적립" : document['saveType'] == 8 ? "관리자 퀵서비스 적립" : document['saveType'] == 9 ? "관리자 렌트카 적립" : document['saveType'] == 10 ? "관리자 영화예매 적립" : document['saveType'] == 11 ? "관리자 추천인 적립" : ""),
                                                    whiteSpaceH(10),
                                                    Text(
                                                      document['date'],
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              129,
                                                              129,
                                                              129)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                numberFormat.format(
                                                        document['point']) +
                                                    "원",
                                                style: TextStyle(
                                                    color: document['type'] == 0
                                                        ? Colors.blueAccent
                                                        : Colors.redAccent,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              whiteSpaceW(20),
                                            ],
                                          ),
                                          whiteSpaceH(15),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 1,
                                            color: Color.fromARGB(
                                                255, 167, 167, 167),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                  bubble
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              bubble = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Color.fromRGBO(129, 129, 129, 0.5),
                          ),
                        )
                      : Container(),
                  bubble
                      ? Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Bubble(
                            margin: BubbleEdges.only(top: 20),
                            radius: Radius.circular(15),
                            alignment: Alignment.center,
                            nip: BubbleNip.no,
                            color: white,
                            padding: BubbleEdges.all(20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("총 적립금"),
                                    ),
                                    Text(
                                      numberFormat.format(allSavePoint) + "원",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                whiteSpaceH(5),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text("사용 적립금"),
                                    ),
                                    Text(
                                      numberFormat.format(useSavePoint) + "원",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                whiteSpaceH(10),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 2,
                                  color: black,
                                ),
                                whiteSpaceH(10),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "보유 적립금",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Text(
                                      numberFormat.format(saveData.point) + "원",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
