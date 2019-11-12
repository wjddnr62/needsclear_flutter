import 'dart:async';

import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Util/toast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SmsAuth extends StatefulWidget {
  @override
  _SmsAuth createState() => _SmsAuth();
}

class _SmsAuth extends State<SmsAuth> {
  SaveData _saveData = SaveData();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _authController = TextEditingController();

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
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
        print("failed : " + msg);
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showToast(msg: '인증 번호가 발송되었습니다. 인증 번호를 입력해주세요.');
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
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }

    super.dispose();
  }

  movePage() {
    Navigator.of(context).pushReplacementNamed("/HowJoin");
  }

  _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: _authController.text,
    );

    print("verificationId : " + verificationId + ", " + _authController.text);

    //테스트 할때만 주석풀고 진행 실제 폰은 아래 코드 있으면 안됨
//    await _auth.signInWithCredential(credential);

    await _auth.currentUser().then((value) {
      if (value != null) {
        if (value.uid != null) {
          print(value.uid);
          msg = 'Successfully signed in, uid: ' + value.uid;
          setState(() {
            authCheck = true;
          });
          _timer.cancel();
          _saveData.phoneNumber = _phoneController.text;
          print("msg : " + msg);
          showToast(type: 0, msg: "문자 인증에 성공하였습니다.");
          movePage();
        } else {
          showToast(type: 0, msg: "문자 인증에 실패하였습니다.");
        }
      } else {
        showToast(type: 0, msg: "문자 인증에 실패하였습니다.");
      }
    });

//    await _auth.signInWithCredential(credential).then((value) {
//      print("value : " + value.toString());
//    }).catchError((error) {
//      print('error : ' + error.toString());
//    });
//
//    final FirebaseUser user =
//        (await _auth.signInWithCredential(credential)).user;
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//
//    assert(user.uid == currentUser.uid);
//      if (user != null) {
//        msg = 'Successfully signed in, uid: ' + user.uid;
//        setState(() {
//          authCheck = true;
//        });
//        _timer.cancel();
//        _saveData.phoneNumber = _phoneController.text;
//        showToast(type: 0, msg: "문자 인증에 성공하였습니다.");
//        movePage();
//      } else {
//        showToast(type: 0, msg: "문자 인증에 실패하였습니다.");
//        msg = 'Sign in failed';
//      }
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 40),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
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
                    "회원가입을 위해 가입하실\n휴대폰번호를 인증해 주세요.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 18),
                  ),
                ),
              ),
              whiteSpaceH(10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color.fromARGB(255, 167, 167, 167),
              ),
              whiteSpaceH(50),
              Row(
                children: <Widget>[
                  whiteSpaceW(20),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
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
                          hintText: "휴대폰번호 입력해 주세요.",
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor)),
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 5)),
                    ),
                  ),
                  whiteSpaceW(10),
                  RaisedButton(
                    onPressed: () async {
                      if (_timer != null) {
                        _timer.cancel();
                      }
                      _start = 120;
                      oneMin = 59;
                      _sendCodeToPhoneNumber();
                      startTimer();
                      FocusScope.of(context).requestFocus(_authFocus);
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
                      child: Text("인증확인", style: TextStyle(
                          color: white, fontSize: 16, fontWeight: FontWeight.w600
                      ),),
                    ),
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
