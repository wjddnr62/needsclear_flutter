import 'dart:convert';

import 'package:aladdinmagic/Home/home.dart';
import 'package:aladdinmagic/Model/datastorage.dart';
import 'package:aladdinmagic/Model/register.dart';
import 'package:aladdinmagic/Model/user.dart';
import 'package:aladdinmagic/Model/usercheck.dart';
import 'package:aladdinmagic/Provider/provider.dart';
import 'package:aladdinmagic/Util/text.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewSignUp extends StatefulWidget {
  final UserCheck userCheck;

  NewSignUp({this.userCheck});

  @override
  _NewSignUp createState() => _NewSignUp();
}

class _NewSignUp extends State<NewSignUp> {
  UserCheck userCheck;

  Provider provider = Provider();

  bool recoCheck = false;

  bool signFinish = false;

  bool getData = false;
  List<Register> registerList = List();

  @override
  void initState() {
    super.initState();

    userCheck = widget.userCheck;

    registerInit();
  }

  registerInit() async {
    print("name : ${userCheck.name}, phone: ${userCheck.phone}");
    await provider
        .selectRecoRegister(userCheck.name, userCheck.phone)
        .then((value) async {
      List<dynamic> result = json.decode(value)['data'];
      print('result : $result, value : $value');
      if (result.length == 1) {
        await provider
            .insertUser(userCheck.username, userCheck.name, userCheck.phone,
                userCheck.birth, userCheck.sex)
            .then((value) {
          dynamic result = json.decode(value);
          if (result['data'] == "OK") {
            provider
                .saveLogInsert(
                    id: userCheck.username,
                    name: userCheck.name,
                    phone: userCheck.phone,
                    type: 0,
                    point: 10000,
                    date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
                    saveMonth: "",
                    savePlace: 0,
                    saveType: 0)
                .then((value) async {
              print("saveLog : $value");
              dynamic result = json.decode(value);
              if (result['data'] == "OK") {
                // 회원가입 완료
                setState(() {
                  signFinish = true;
                });

                await provider
                    .selectUser(userCheck.username)
                    .then((value) async {
                  dynamic data = json.decode(value);
                  User user = User.fromJson(data['data']);

                  dataStorage.user = user;

                  await provider
                      .recoUpdate(user.idx, user.id, registerList[0].recoCode)
                      .then((value) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Home()),
                        (Route<dynamic> route) => false);
                  });
                });
              }
            });
          }
        });
      } else if (result.length != 0 && result.length <= 2) {
        for (int i = 0; i < result.length; i++) {
          registerList.add(Register(
              recoCode: result[i]['recoCode'], recoIdx: result[i]['recoIdx']));
        }
        selectReco();
      } else {
        userInsert();
      }
    });
  }

  userInsert() async {
    await provider
        .insertUser(userCheck.username, userCheck.name, userCheck.phone,
            userCheck.birth, userCheck.sex)
        .then((value) {
      dynamic result = json.decode(value);
      if (result['data'] == "OK") {
        provider
            .saveLogInsert(
                id: userCheck.username,
                name: userCheck.name,
                phone: userCheck.phone,
                type: 0,
                point: 10000,
                date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
                saveMonth: "",
                savePlace: 0,
                saveType: 0)
            .then((value) async {
          print("saveLog : $value");
          dynamic result = json.decode(value);
          if (result['data'] == "OK") {
            // 회원가입 완료
            setState(() {
              signFinish = true;
            });

            await provider.selectUser(userCheck.username).then((value) async {
              dynamic data = json.decode(value);
              User user = User.fromJson(data['data']);

              dataStorage.user = user;

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false);
            });
          }
        });
      }
      print("insertUser : " + value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () => null,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(mainColor),
            ),
          ),
        ),
      ),
    );
  }

  selectReco() {
    return showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (_) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              backgroundColor: white,
              child: Container(
                width: 240,
                height: 360,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(0)),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          whiteSpaceH(12),
                          customText(StyleCustom(
                              text: "추천인을 선택해주세요.",
                              color: Color(0xFF444444),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                          whiteSpaceH(12),
                          SingleChildScrollView(
                            child: ListView.builder(
                              itemBuilder: (context, idx) {
                                return InkWell(
                                  onTap: () async {
                                    await provider
                                        .insertUser(
                                        userCheck.username, userCheck.name,
                                        userCheck.phone,
                                        userCheck.birth, userCheck.sex)
                                        .then((value) {
                                      dynamic result = json.decode(value);
                                      if (result['data'] == "OK") {
                                        provider
                                            .saveLogInsert(
                                            id: userCheck.username,
                                            name: userCheck.name,
                                            phone: userCheck.phone,
                                            type: 0,
                                            point: 10000,
                                            date: DateFormat("yyyy-MM-dd")
                                                .format(DateTime.now()),
                                            saveMonth: "",
                                            savePlace: 0,
                                            saveType: 0)
                                            .then((value) async {
                                          print("saveLog : $value");
                                          dynamic result = json.decode(value);
                                          if (result['data'] == "OK") {
                                            // 회원가입 완료
                                            setState(() {
                                              signFinish = true;
                                            });

                                            await provider.selectUser(
                                                userCheck.username).then((
                                                value) async {
                                              dynamic data = json.decode(value);
                                              User user = User.fromJson(
                                                  data['data']);

                                              dataStorage.user = user;

                                              await provider.recoUpdate(user
                                                  .idx, user.id,
                                                  registerList[idx].recoCode)
                                                  .then((value) {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Home()),
                                                        (Route<
                                                        dynamic> route) => false);
                                              });
                                            });
                                          }
                                        });
                                      }
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      whiteSpaceH(4),
                                      Text(
                                        registerList[idx].recoCode,
                                        style: TextStyle(
                                            fontSize: 16, fontFamily: 'noto'),
                                      ),
                                      whiteSpaceH(4),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        height: 1,
                                        color: Color(0xFFDDDDDD),
                                      )
                                    ],
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount: registerList.length,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text("※ 선택하지 않을 시\n자동으로 추천인이 매칭됩니다.",
                          textAlign: TextAlign.center, style: TextStyle(
                              fontFamily: 'noto', fontSize: 12, color: black
                          ),),
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
                                  onPressed: () async {
                                    await provider
                                        .insertUser(
                                        userCheck.username, userCheck.name,
                                        userCheck.phone,
                                        userCheck.birth, userCheck.sex)
                                        .then((value) {
                                      dynamic result = json.decode(value);
                                      if (result['data'] == "OK") {
                                        provider
                                            .saveLogInsert(
                                            id: userCheck.username,
                                            name: userCheck.name,
                                            phone: userCheck.phone,
                                            type: 0,
                                            point: 10000,
                                            date: DateFormat("yyyy-MM-dd")
                                                .format(DateTime.now()),
                                            saveMonth: "",
                                            savePlace: 0,
                                            saveType: 0)
                                            .then((value) async {
                                          print("saveLog : $value");
                                          dynamic result = json.decode(value);
                                          if (result['data'] == "OK") {
                                            // 회원가입 완료
                                            setState(() {
                                              signFinish = true;
                                            });

                                            await provider.selectUser(
                                                userCheck.username).then((
                                                value) async {
                                              dynamic data = json.decode(value);
                                              User user = User.fromJson(
                                                  data['data']);

                                              dataStorage.user = user;

                                              await provider.recoUpdate(
                                                  user.idx, user.id,
                                                  registerList[0].recoCode)
                                                  .then((value) {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Home()),
                                                        (Route<
                                                        dynamic> route) => false);
                                              });
                                            });
                                          }
                                        });
                                      }
                                    });
                                  },
                                  color: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "선택 안 함",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'noto'),
                                      textAlign: TextAlign.center,
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
            ),
          );
        });
  }
}
