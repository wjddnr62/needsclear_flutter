import 'dart:convert';

import 'package:aladdinmagic/Login/login.dart';
import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/toast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  final int type; // type = 0 일반 가입, 1 = 카카오, 2 = 구글, 3 = 페이스북

  SignUp({Key key, this.type}) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  UserProvider userProvider = UserProvider();

  SaveData _saveData = SaveData();

  bool appBar = false;

  int type;

  bool nextPage = false;
  int sex = 0;

  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  final facebookLogin = FacebookLogin();

  TextEditingController _idController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _rePassController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthDayController = TextEditingController();
  TextEditingController _recoCodeController = TextEditingController();

  FocusNode _idFocus = FocusNode();
  FocusNode _passFocus = FocusNode();
  FocusNode _rePassFocus = FocusNode();
  FocusNode _nameFocus = FocusNode();

  String selectBoxValue = "가입경로 선택";

  bool allAgree = false;
  bool useCheck = false;
  bool privacyCheck = false;
  bool locationCheck = false;

  String reCoCode = "";

  bool reCoCheck = false;

  bool idCheck = false;

  bool snsLogin = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      if (user.uid == currentUser.uid) {
        _saveData.id = currentUser.uid;
        setState(() {
          nextPage = true;
        });
      } else {
        showToast(type: 0, msg: "구글 회원가입 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
        Navigator.of(context).pop();
      }

      print("currentUser : ${currentUser.uid}");
    } catch (error) {
      print("googleError : ${error}");
      if (error.toString().contains("authentication") &&
          error.toString().contains("null")) {
        showToast(type: 0, msg: "구글 회원가입을 취소하였습니다.");
        Navigator.of(context).pop();
      } else {
        showToast(type: 0, msg: "구글 회원가입 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
        Navigator.of(context).pop();
      }
    }
  }

//  Future<void> _handleSignOut() async {
//    _googleSignIn.disconnect();
//  }

  customDialog(msg, type) {
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
                                "취소",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      whiteSpaceW(5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (type == 0) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } else {
                              DateTime now = DateTime.now();
                              String formatDate =
                                  DateFormat('yyyy.MM.dd').format(now);

                              if (reCoCheck) {
                                userProvider
                                    .insertPoint(_saveData.reCoId, 500, {
                                  'recoCode': _recoCodeController.text,
                                  'name': _nameController.text,
                                  'phone': _saveData.phoneNumber,
                                  'signDate': formatDate,
                                  'type': 0
                                });
                                print("insertPoint");
                                reCoCheck = false;
                              }

                              int signType;

                              if (type == 1) {
                                signType = 0;
                              } else if (type == 2) {
                                signType = 1;
                              } else if (type == 3) {
                                signType = 2;
                              } else if (type == 4) {
                                signType = 3;
                              }

                              userProvider.addUsers({
                                'id': _saveData.id,
                                'pass': signType == 0 ? _saveData.pass : "",
                                'name': _nameController.text,
                                'phone': _saveData.phoneNumber,
                                'birthDay': _birthDayController.text,
                                'sex': sex,
                                'signRoot': selectBoxValue,
                                'type': signType,
                                'recoCode': _saveData.phoneNumber,
                                'point': 1000,
                                'recoPerson': 0,
                                'recoPrice': 0,
                                'signDate': formatDate,
                                'pushRecoCode': _recoCodeController.text
                              }).then((value) {
                                if (value == 0) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/Login",
                                      (Route<dynamic> route) => false);
                                }
                              }).catchError((error) {
                                showToast(type: 0, msg: "잠시 후 다시 시도해주세요.");
                              });
                            }
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
  void initState() {
    super.initState();

    type = widget.type;

    reCoCode =
        (randomAlpha(6) + randomNumeric(2) + randomAlpha(2)).toUpperCase();
  }

  normalSign() {
    return !nextPage
        ? Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 40),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      customDialog(
                          "화면을 닫으시는 경우\n회원가입이 중단됩니다.\n\n회원가입을\n중단하시겠습니까?", 0);
                    },
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              whiteSpaceH(30),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "사용하실 계정정보를\n입력해 주세요.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 18),
                  ),
                ),
              ),
              whiteSpaceH(10),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Color.fromARGB(255, 167, 167, 167),
                ),
              ),
              whiteSpaceH(50),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _idController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_passFocus);
                      },
                      onChanged: (value) {
                        print("value : " + value);
                        userProvider.idDuplicate(value.trim()).then((value) {
                          print("dupl : " + value.toString());
                          if (value != 0) {
                            idCheck = false;
                          } else {
                            idCheck = true;
                          }
                          print("idCheck : ${idCheck}");
                        });
                      },
                      maxLength: 20,
                      decoration: InputDecoration(
                          counterText: "",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "아이디를 입력해 주세요(20자 이내)",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor)),
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                    ),
                    whiteSpaceH(20),
                    TextFormField(
                      controller: _passController,
                      focusNode: _passFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_rePassFocus);
                      },
                      obscureText: true,
                      maxLength: 12,
                      decoration: InputDecoration(
                          counterText: "",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "비밀번호를 입력해 주세요(4자~12자)",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor)),
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                    ),
                    whiteSpaceH(20),
                    TextFormField(
                      controller: _rePassController,
                      focusNode: _rePassFocus,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      maxLength: 12,
                      decoration: InputDecoration(
                          counterText: "",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "비밀번호를 다시 입력해 주세요(4자~12자)",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor)),
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                    ),
                    whiteSpaceH(40),
                    GestureDetector(
                      onTap: () {
                        if (_idController.text == null ||
                            _idController.text == "") {
                          showToast(
                              type: 0,
                              msg: "아이디를 입력해 주세요."); // 이미 사용중인 아이디 체크 필요
                        } else if (!idCheck) {
                          showToast(type: 0, msg: "이미 사용중인 아이디 입니다.");
                        } else if (_passController.text == null ||
                            _passController.text == "") {
                          showToast(type: 0, msg: "비밀번호를 입력해 주세요.");
                        } else if (_rePassController.text == null ||
                            _rePassController.text == "") {
                          showToast(type: 0, msg: "비밀번호를 다시 입력해 주세요.");
                        } else if (_passController.text.length < 4) {
                          showToast(type: 0, msg: "비밀번호를 4자리 이상 입력해주세요.");
                        } else if (_passController.text !=
                            _rePassController.text) {
                          showToast(type: 0, msg: "비밀번호가 서로 일치하지 않습니다.");
                        } else {
                          _saveData.id = _idController.text.trim();
                          _saveData.pass = _passController.text.trim();
                          setState(() {
                            nextPage = true;
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(width: 1, color: black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "다음",
                            style: TextStyle(color: black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        : Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 40),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      customDialog(
                          "화면을 닫으시는 경우\n회원가입이 중단됩니다.\n\n회원가입을\n중단하시겠습니까?", 0);
                    },
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              whiteSpaceH(30),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "서비스 이용을 위해 기본정보 입력 및\n약관에 동의해 주세요.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 18),
                  ),
                ),
              ),
              whiteSpaceH(10),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Color.fromARGB(255, 167, 167, 167),
                ),
              ),
              whiteSpaceH(30),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      maxLength: 9,
                      decoration: InputDecoration(
                          counterText: "",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "성명을 입력해 주세요(10자 이내)",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor)),
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                    ),
                    whiteSpaceH(20),
                    TextFormField(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            minTime: DateTime(1930, 1, 1),
                            showTitleActions: true, onChanged: (date) {
                          print(
                              "change ${date.year}.${date.month}.${date.day}");
                          _birthDayController.text =
                              "${date.year}년${date.month}월${date.day}일";
                        }, onConfirm: (date) {
                          print(
                              "confirm ${date.year}.${date.month}.${date.day}");
                          _birthDayController.text =
                              "${date.year}년${date.month}월${date.day}일";
                        }, locale: LocaleType.ko);
                      },
                      controller: _birthDayController,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      decoration: InputDecoration(
                          counterText: "",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "생년월일을 선택해 주세요",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor)),
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                    ),
                    whiteSpaceH(30),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                sex = 0;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              color: sex == 0
                                  ? black
                                  : Color.fromARGB(255, 219, 219, 219),
                              child: Center(
                                child: Text(
                                  "남자",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: sex == 0 ? white : black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        whiteSpaceW(5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                sex = 1;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              color: sex == 1
                                  ? black
                                  : Color.fromARGB(255, 219, 219, 219),
                              child: Center(
                                child: Text(
                                  "여자",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: sex == 1 ? white : black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        elevation: 2,
                        style: TextStyle(color: black),
                        items: <String>[
                          '가입경로 선택',
                          '알라딘박스',
                          'ABO 회원',
                          'ABM 회원',
                          '대리점 회원',
                          '총판 회원',
                          '지인추천',
                          '인터넷 검색',
                          '기타'
                        ].map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: black),
                            ),
                          );
                        }).toList(),
                        value: selectBoxValue,
                        onChanged: (value) {
                          setState(() {
                            selectBoxValue = value;
                          });
                        },
                      ),
                    ),
                    whiteSpaceH(20),
                    TextFormField(
                      controller: _recoCodeController,
                      textInputAction: TextInputAction.done,
                      maxLength: 10,
                      onChanged: (value) async {
                        await userProvider
                            .checkReCoCode(_recoCodeController.text)
                            .then((value) {
                          print("value : ${value}");
                          if (value != 0) {
                            reCoCheck = true;
                          } else if (value == 0) {
                            reCoCheck = false;
                          }

                          print("recoCheck : " + reCoCheck.toString());
                        });

                        print("value222 : ${value}");

                        if ((_recoCodeController.text != null &&
                                _recoCodeController.text != "") &&
                            !reCoCheck) {
                          print("aa");
                        } else {
                          print("test");
                        }
                      },
                      decoration: InputDecoration(
                          counterText: "",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "추천코드를 입력해 주세요(선택사항)",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor)),
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                    ),
                    whiteSpaceH(30),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: allAgree,
                          activeColor: mainColor,
                          onChanged: (value) {
                            setState(() {
                              allAgree = value;
                              useCheck = value;
                              privacyCheck = value;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            "전체 동의",
                            style: TextStyle(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: useCheck,
                          activeColor: mainColor,
                          onChanged: (value) {
                            setState(() {
                              if (value && privacyCheck) {
                                useCheck = value;
                                allAgree = value;
                              } else {
                                if (!value && allAgree) {
                                  useCheck = value;
                                  allAgree = value;
                                } else {
                                  useCheck = value;
                                }
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            "이용약관(필수)",
                            style: TextStyle(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "내용",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: privacyCheck,
                          activeColor: mainColor,
                          onChanged: (value) {
                            setState(() {
                              if (value && useCheck) {
                                privacyCheck = value;
                                allAgree = value;
                              } else {
                                if (!value && allAgree) {
                                  privacyCheck = value;
                                  allAgree = value;
                                } else {
                                  privacyCheck = value;
                                }
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            "개인정보 취급방침(필수)",
                            style: TextStyle(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "내용",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: black,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(30),
                    GestureDetector(
                      onTap: () {
                        if (_nameController.text == null ||
                            _nameController.text == "") {
                          showToast(type: 0, msg: "성명을 입력해 주세요.");
                        } else if (_birthDayController.text == null ||
                            _birthDayController.text == "") {
                          showToast(type: 0, msg: "생년월일을 선택해 주세요.");
                        } else if (selectBoxValue == "가입경로 선택" ||
                            selectBoxValue == "") {
                          showToast(type: 0, msg: "가입경로를 선택해 주세요.");
                        } else if ((_recoCodeController.text != null &&
                                _recoCodeController.text != "") &&
                            !reCoCheck) {
                          showToast(type: 0, msg: "추천코드가 올바르지 않습니다.");
                        } else if (!allAgree) {
                          showToast(type: 0, msg: "필수약관을 모두 동의해 주세요.");
                        } else {
                          customDialog("입력하신 정보로\n회원가입 하시겠습니까?", 1);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "완료",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    whiteSpaceH(30)
                  ],
                ),
              )
            ],
          );
  }

  Future<Null> _getAccountInfo() async {
    final KakaoLoginResult result = await kakaoSignIn.getUserMe();
    if (result != null && result.status != KakaoLoginStatus.error) {
      final KakaoAccountResult account = result.account;
      final userID = account.userID;
      final userEmail = account.userEmail;
      final userPhoneNumber = account.userPhoneNumber;
      final userDisplayID = account.userDisplayID;
      final userNickname = account.userNickname;
      // To-do Someting ...

      print(
          "userID : ${userID}, userEmail : ${userEmail}, userPhoneNumber : ${userPhoneNumber}, userDisplayId : ${userDisplayID}, userNickName : ${userNickname}");
    }
  }

  kakaoLogin() async {
    print("login");
    final KakaoLoginResult result = await kakaoSignIn.logIn();
    switch (result.status) {
      case KakaoLoginStatus.loggedIn:
//        _getAccessToken();
//        _getAccountInfo();
        print('LoggedIn by the user.\n'
            '- UserID is ${result.account.userID}\n'
            '- UserEmail is ${result.account.userEmail} ');

        _saveData.id = result.account.userID;
        _saveData.snsEmail = result.account.userEmail;

        setState(() {
          nextPage = true;
        });

        break;
      case KakaoLoginStatus.loggedOut:
        print('LoggedOut by the user.');
        break;
      case KakaoLoginStatus.error:
        print('This is Kakao error message : ${result.errorMessage}');
        if (result.errorMessage.contains("CANCELED_OPERATION")) {
          showToast(type: 0, msg: "회원가입을 취소하였습니다.");
          Navigator.of(context).pop();
        } else {
          showToast(type: 0, msg: "회원가입 중 오류가 발생하였습니다. 다시시도해주세요.");
          Navigator.of(context).pop();
        }
        break;
    }
  }

  fbLogin() async {
    final result = await facebookLogin.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
        final profile = json.decode(graphResponse.body);
        print("id : ${profile['id']}");
        print("token : ${result.accessToken.token}");
        if (profile['id'] != null) {
          _saveData.id = profile['id'];
          setState(() {
            nextPage = true;
          });
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        showToast(type: 0, msg: "facebook 회원가입을 취소하였습니다.");
        Navigator.of(context).pop();
        break;
      case FacebookLoginStatus.error:
        showToast(type: 0, msg: "facebook 회원가입 중 오류가 발생하였습니다. 잠시 후에 다시 시도해주세요.");
        print("fbError : " + result.errorMessage.toString());
        Navigator.of(context).pop();
        break;
    }
  }

//  Future<Null> _getAccessToken() async {
//    final KakaoAccessToken accessToken = await (kakaoSignIn.currentAccessToken);
//    print("accessToken : ${accessToken}");
//    if (accessToken != null) {
//      final token = accessToken.token;
//      print("token : ${token}");
//      // To-do Someting ...
//    }
//  }

  snsNextPage(type) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20, top: 40),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                customDialog(
                    "화면을 닫으시는 경우\n회원가입이 중단됩니다.\n\n회원가입을\n중단하시겠습니까?", 0);
              },
              child: Icon(Icons.close),
            ),
          ),
        ),
        whiteSpaceH(30),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "서비스 이용을 위해 기본정보 입력 및\n약관에 동의해 주세요.",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: black, fontSize: 18),
            ),
          ),
        ),
        whiteSpaceH(10),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color.fromARGB(255, 167, 167, 167),
          ),
        ),
        whiteSpaceH(30),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                maxLength: 9,
                decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 167, 167, 167)),
                    hintText: "성명을 입력해 주세요(10자 이내)",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    contentPadding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 5)),
              ),
              whiteSpaceH(20),
              TextFormField(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      minTime: DateTime(1930, 1, 1),
                      showTitleActions: true, onChanged: (date) {
                    print("change ${date.year}.${date.month}.${date.day}");
                    _birthDayController.text =
                        "${date.year}년${date.month}월${date.day}일";
                  }, onConfirm: (date) {
                    print("confirm ${date.year}.${date.month}.${date.day}");
                    _birthDayController.text =
                        "${date.year}년${date.month}월${date.day}일";
                  }, locale: LocaleType.ko);
                },
                controller: _birthDayController,
                textInputAction: TextInputAction.next,
                readOnly: true,
                decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 167, 167, 167)),
                    hintText: "생년월일을 선택해 주세요",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    contentPadding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 5)),
              ),
              whiteSpaceH(30),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          sex = 0;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        color: sex == 0
                            ? black
                            : Color.fromARGB(255, 219, 219, 219),
                        child: Center(
                          child: Text(
                            "남자",
                            style: TextStyle(
                                fontSize: 14,
                                color: sex == 0 ? white : black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  whiteSpaceW(5),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          sex = 1;
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        color: sex == 1
                            ? black
                            : Color.fromARGB(255, 219, 219, 219),
                        child: Center(
                          child: Text(
                            "여자",
                            style: TextStyle(
                                fontSize: 14,
                                color: sex == 1 ? white : black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              whiteSpaceH(30),
              Container(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  isExpanded: true,
                  elevation: 2,
                  style: TextStyle(color: black),
                  items: <String>[
                    '가입경로 선택',
                    '알라딘박스',
                    'ABO 회원',
                    'ABM 회원',
                    '대리점 회원',
                    '총판 회원',
                    '지인추천',
                    '인터넷 검색',
                    '기타'
                  ].map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: black),
                      ),
                    );
                  }).toList(),
                  value: selectBoxValue,
                  onChanged: (value) {
                    setState(() {
                      selectBoxValue = value;
                    });
                  },
                ),
              ),
              whiteSpaceH(20),
              TextFormField(
                controller: _recoCodeController,
                textInputAction: TextInputAction.done,
                maxLength: 10,
                onChanged: (value) async {
                  await userProvider
                      .checkReCoCode(_recoCodeController.text)
                      .then((value) {
                    print("value : ${value}");
                    if (value != 0) {
                      reCoCheck = true;
                    } else if (value == 0) {
                      reCoCheck = false;
                    }
                  });
                },
                decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 167, 167, 167)),
                    hintText: "추천코드를 입력해 주세요(선택사항)",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    contentPadding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 5)),
              ),
              whiteSpaceH(30),
              Row(
                children: <Widget>[
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: allAgree,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        allAgree = value;
                        useCheck = value;
                        privacyCheck = value;
                        locationCheck = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "전체 동의",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: useCheck,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        if (value && privacyCheck && locationCheck) {
                          useCheck = value;
                          allAgree = value;
                        } else {
                          if (!value && allAgree) {
                            useCheck = value;
                            allAgree = value;
                          } else {
                            useCheck = value;
                          }
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "이용약관(필수)",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "내용",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: privacyCheck,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        if (value && useCheck && locationCheck) {
                          privacyCheck = value;
                          allAgree = value;
                        } else {
                          if (!value && allAgree) {
                            privacyCheck = value;
                            allAgree = value;
                          } else {
                            privacyCheck = value;
                          }
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "개인정보 취급방침(필수)",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "내용",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: locationCheck,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        if (value && useCheck && privacyCheck) {
                          locationCheck = value;
                          allAgree = value;
                        } else {
                          if (!value && allAgree) {
                            locationCheck = value;
                            allAgree = value;
                          } else {
                            locationCheck = value;
                          }
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "위치기반 서비스 이용약관(필수)",
                      style: TextStyle(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "내용",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: black,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              whiteSpaceH(30),
              GestureDetector(
                onTap: () {
                  if (_nameController.text == null ||
                      _nameController.text == "") {
                    showToast(type: 0, msg: "성명을 입력해 주세요.");
                  } else if (_birthDayController.text == null ||
                      _birthDayController.text == "") {
                    showToast(type: 0, msg: "생년월일을 선택해 주세요.");
                  } else if (selectBoxValue == "가입경로 선택" ||
                      selectBoxValue == "") {
                    showToast(type: 0, msg: "가입경로를 선택해 주세요.");
                  } else if ((_recoCodeController.text != null &&
                          _recoCodeController.text != "") &&
                      !reCoCheck) {
                    showToast(type: 0, msg: "추천코드가 올바르지 않습니다.");
                  } else if (!allAgree) {
                    showToast(type: 0, msg: "필수약관을 모두 동의해 주세요.");
                  } else {
                    customDialog("입력하신 정보로\n회원가입 하시겠습니까?", type);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "완료",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: black,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              whiteSpaceH(30)
            ],
          ),
        )
      ],
    );
  }

  signUpView() {
    print('type : ${type}');
    if (type == 0) {
      return normalSign();
    } else if (type == 1) {
//      kakaoLogOut();
      if (!snsLogin) {
        kakaoLogin();
        snsLogin = true;
      }

      return nextPage ? snsNextPage(2) : Container();
    } else if (type == 2) {
      if (!snsLogin) {
        _handleSignIn();
        snsLogin = true;
      }

      return nextPage ? snsNextPage(3) : Container();
    } else if (type == 3) {
      if (!snsLogin) {
        fbLogin();
        snsLogin = true;
      }

      return nextPage ? snsNextPage(4) : Container();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        customDialog("화면을 닫으시는 경우\n회원가입이 중단됩니다.\n\n회원가입을\n중단하시겠습니까?", 0);
      },
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: signUpView(),
          ),
        ),
      ),
    );
  }
}
