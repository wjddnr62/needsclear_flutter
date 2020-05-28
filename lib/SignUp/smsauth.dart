import 'dart:async';

import 'package:aladdinmagic/DrawerMenu/memberwfin.dart';
import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/customDialog.dart';
import 'package:aladdinmagic/Util/showToast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SmsAuth extends StatefulWidget {
  int type;

  SmsAuth({Key key, this.type}) : super(key: key);

  @override
  _SmsAuth createState() => _SmsAuth();
}

class _SmsAuth extends State<SmsAuth> {
  UserProvider userProvider = UserProvider();

  int type = 0;

  SaveData _saveData = SaveData();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _authController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  FocusNode _phoneFocus = FocusNode();
  FocusNode _authFocus = FocusNode();

  String verificationId;
  String msg = "";

  Timer _timer;
  int _start = 120;
  bool authCheck = false;

  Future<void> _sendCodeToPhoneNumber() async {
    _auth.setLanguageCode("kr");

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        msg =
        'Received phone auth credential: ${phoneAuthCredential.toString()}';
        print("verificationCom : " + msg);
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        msg =
        'Phone number verification failed. Code: ${authException
            .code}. Message: ${authException.message}';
        print("failed : " + msg);
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast('인증 번호가 발송되었습니다. 인증 번호를 입력해주세요.');
      this.verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "+82" + _phoneController.text,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  @override
  void initState() {
    super.initState();

    if (widget.type != null && widget.type != 0) {
      type = widget.type;
    }

    if (type == 2) {
      if (_saveData.findId != null &&
          _saveData.findId != "" &&
          _saveData.findId.isNotEmpty) {
        _idController.text = _saveData.findId;
      }
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }

    super.dispose();
  }

  memberWDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                    "정말 회원 탈퇴하시겠습니까?\n(유의사항 확인필요)",
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
                            Navigator.of(context)
                                .pushReplacementNamed("/Settings");
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
                            DateTime now = DateTime.now();
                            String formatDate =
                            DateFormat('yyyy-MM-dd').format(now);
                            userProvider
                                .deleteUser(
                                _saveData.phoneNumber, _saveData.royalCode)
                                .then((value) {
                              if (value == 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MemberWFin(
                                          date: formatDate,
                                        )));
                              }
                            });
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

  movePage() {
    if (type == 0) {
      Navigator.of(context).pushReplacementNamed("/HowJoin");
    } else if (type == 1) {
      Navigator.of(context).pushReplacementNamed("/FindId");
    } else if (type == 2) {
      Navigator.of(context).pushReplacementNamed("/FindPass");
    } else if (type == 3) {
      memberWDialog();
    }
  }

  _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: _authController.text,
    );

    print("verificationId : " + verificationId + ", " + _authController.text);

    // TODO : 테스트 할때만 주석풀고 진행 실제 폰은 아래 코드 있으면 안됨
    // await _auth.signInWithCredential(credential);

    await _auth.currentUser().then((value) {
      if (value != null) {
        if (value.uid != null) {
          print(value.uid);
          msg = 'Successfully signed in, uid: ' + value.uid;
          setState(() {
            authCheck = true;
          });
          _timer.cancel();
          showToast("문자 인증에 성공하였습니다.");

          if (type == 0) {
            _saveData.phoneNumber = _phoneController.text;
          }
          print("msg : " + msg);
          movePage();
        } else {
          showToast("문자 인증에 실패하였습니다.");
        }
      } else {
        showToast("문자 인증에 실패하였습니다.");
      }
    });
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) =>
          setState(
                () {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            },
          ),
    );
  }

  int oneMin = 59;

  setTime(time) {
    if (time >= 120) {
      return "2:00";
    } else if (time < 120 && time >= 60) {
      if (time == 119) {
        return "1:${oneMin}";
      } else {
        oneMin--;
        if (oneMin < 10) {
          return "1:0${oneMin}";
        } else {
          return "1:${oneMin}";
        }
      }
    } else if (time < 60 && time >= 1) {
      if (time == 59) {
        oneMin = 59;
        return "0:${oneMin}";
      } else {
        oneMin--;
        if (oneMin < 10) {
          return "0:0${oneMin}";
        } else {
          return "0:${oneMin}";
        }
      }
    } else {
      return "0:00";
    }
  }

  authStart() {
    if (_timer != null) {
      _timer.cancel();
    }
    _start = 120;
    oneMin = 59;
    _sendCodeToPhoneNumber();
    startTimer();
    FocusScope.of(context).requestFocus(_authFocus);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        if (type == 3) {
          Navigator.of(context).pushReplacementNamed("/MemberW");
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height -
                MediaQuery
                    .of(context)
                    .padding
                    .top,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 40),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        if (type == 3) {
                          Navigator.of(context)
                              .pushReplacementNamed("/MemberW");
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                whiteSpaceH(30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      type == 0
                          ? "회원가입을 위해 가입하실\n휴대폰번호를 인증해 주세요."
                          : type == 1
                          ? "아이디를 찾기 위해 회원가입 시 사용하신\n휴대폰번호를 인증해 주세요."
                          : type == 3
                          ? "회원탈퇴를 위해 가입하신 휴대폰번호를 인증해주세요."
                          : "회원가입 하신 아이디 및\n휴대폰번호를 인증해 주세요.",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: black,
                          fontSize: 18),
                    ),
                  ),
                ),
                whiteSpaceH(10),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 1,
                  color: Color.fromARGB(255, 167, 167, 167),
                ),
                whiteSpaceH(50),
                type == 2
                    ? Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _idController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) async {
                      FocusScope.of(context).requestFocus(_phoneFocus);
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 167, 167, 167)),
                        hintText: "아이디를 입력해 주세요.",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mainColor)),
                        contentPadding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 10)),
                  ),
                )
                    : Container(),
                type == 2 ? whiteSpaceH(20) : Container(),
                Row(
                  children: <Widget>[
                    whiteSpaceW(20),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        focusNode: _phoneFocus,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _phoneController.text = "";
                              },
                            ),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 167, 167, 167)),
                            hintText: "휴대폰번호를 입력해 주세요.",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),
                            contentPadding:
                            EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                      ),
                    ),
                    whiteSpaceW(10),
                    RaisedButton(
                      onPressed: () async {
                        if (_phoneController.text.isEmpty ||
                            _phoneController.text == "" ||
                            _phoneController.text == null) {
                          showToast("휴대폰번호를 입력해 주세요.");
                        } else {
                          if (type == 1) {
                            userProvider
                                .checkPhoneNumber(_phoneController.text)
                                .then((value) {
                              if (value == 0) {
                                customDialog(
                                    "가입된 휴대폰번호가 아닙니다.\n휴대폰번호를 확인해 주세요.",
                                    0,
                                    context);
                              } else {
                                authStart();
                              }
                            });
                          } else if (type == 2) {
                            if (_idController.text.isEmpty ||
                                _idController.text == "" ||
                                _idController.text == null) {
                              showToast("아이디를 입력해 주세요.");
                            } else {
                              userProvider
                                  .checkUser(_idController.text)
                                  .then((value) {
                                if (value == 0) {
                                  customDialog(
                                      "가입되지 않은 회원정보 입니다.\n아이디 또는 휴대폰번호를 확인해주세요.",
                                      0,
                                      context);
                                } else {
                                  userProvider
                                      .checkPhoneNumber(_phoneController.text)
                                      .then((value) {
                                    if (value == 0) {
                                      customDialog(
                                          "가입되지 않은 회원정보 입니다.\n아이디 또는 휴대폰번호를 확인해주세요.",
                                          0,
                                          context);
                                    } else {
                                      authStart();
                                    }
                                  });
                                }
                              });
                            }
                          } else if (type == 3) {
                            if (_saveData.phoneNumber !=
                                _phoneController.text) {
                              customDialog("본인 휴대폰번호가 아닙니다.\n휴대폰번호를 확인해주세요.", 0,
                                  context);
                            } else {
                              userProvider
                                  .checkAllUser(_phoneController.text)
                                  .then((value) {
                                if (value == 1) {
                                  authStart();
                                } else {
                                  customDialog(
                                      "가입된 휴대폰번호가 아닙니다.\n휴대폰번호를 확인해주세요.",
                                      0, context);
                                }
                              });
                            }
                          } else {
                            userProvider
                                .checkAllUser(_phoneController.text)
                                .then((value) {
                              if (value == 1) {
                                showToast("이미 가입되어있는 회원입니다.");
                              } else {
                                authStart();
                              }
                            });
                          }
                        }
                      },
                      color: Color.fromARGB(255, 167, 167, 167),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0.0,
                      child: Center(
                        child: Text(
                          "인증요청",
                          style: TextStyle(
                              color: white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    whiteSpaceW(20)
                  ],
                ),
                whiteSpaceH(20),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _authController,
                    focusNode: _authFocus,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _signInWithPhoneNumber();
                    },
                    decoration: InputDecoration(
                        suffix: Text(
                          setTime(_start),
                          style: TextStyle(color: mainColor),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 167, 167, 167)),
                        hintText: "인증번호를 입력해 주세요.",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: mainColor)),
                        contentPadding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 10)),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 40, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (_timer != null) {
                          _timer.cancel();
                        }
                        _start = 120;
                        oneMin = 59;
                        _sendCodeToPhoneNumber();
                        startTimer();
                        FocusScope.of(context).requestFocus(_authFocus);
                      },
                      child: Text(
                        "인증번호 재전송",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ),
                whiteSpaceH(50),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _signInWithPhoneNumber();
                    },
                    color: Color.fromARGB(255, 167, 167, 167),
                    elevation: 0.0,
                    child: Container(
                      width: 150,
                      height: 50,
                      child: Center(
                        child: Text(
                          "인증확인",
                          style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
