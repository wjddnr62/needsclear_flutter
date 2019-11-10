import 'package:aladdinmagic/Login/login.dart';
import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/toast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  final int type; // type = 0 일반 가입, 1 = 카카오, 2= 구글, 3 = 페이스북

  SignUp({Key key, this.type}) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  UserProvider userProvider = UserProvider();

  SaveData _saveData = SaveData();

  int type;

  bool nextPage = false;
  int sex = 0;

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

  String reCoCode = "";

  bool reCoCheck = false;

  bool idCheck = false;

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
                              if (reCoCheck) {
                                userProvider.insertPoint(_saveData.reCoId, 500);
                                print("insertPoint");
                                reCoCheck = false;
                              }

                              userProvider.addUsers({
                                'id': _saveData.id,
                                'pass': _saveData.pass,
                                'name': _nameController.text,
                                'phone': _saveData.phoneNumber,
                                'birthDay': _birthDayController.text,
                                'sex': sex,
                                'signRoot': selectBoxValue,
                                'type': 0,
                                'recoCode': reCoCode,
                                'point': 0,
                                'recoPerson': 0,
                                'recoPrice': 0
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

  Future<int> checkReCoCode(reCoCode) async {
    Firestore.instance
        .collection("users")
        .where('recoCode', isEqualTo: reCoCode)
        .snapshots()
        .listen((data) {
      if (data.documents.length == 0) {
        return 0;
      } else {
        final List<DocumentSnapshot> docs = data.documents;

        _saveData.reCoId = docs[0].data['id'];
        return 1;
      }
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
                      customDialog("화면을 닫으시는 경우\n회원가입이 중단됩니다.\n\n회원가입을\n중단하시겠습니까?", 0);
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
                        userProvider
                            .idDuplicate(value.trim())
                            .then((value) {
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
                      customDialog("화면을 닫으시는 경우\n회원가입이 중단됩니다.\n\n회원가입을\n중단하시겠습니까?", 0);
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
                        items: <String>['가입경로 선택', '알라딘박스'].map((value) {
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
                      onChanged: (value) {
                        checkReCoCode(_recoCodeController.text).then((value) {
                          if (value != 0) {
                            reCoCheck = true;
                          } else {
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
                        } else if (!reCoCheck) {
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

  signUpView() {
    if (type == 0) {
      return normalSign();
    } else if (type == 1) {
    } else if (type == 2) {
    } else if (type == 3) {
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
