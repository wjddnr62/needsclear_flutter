import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:needsclear/Model/savedata.dart';
import 'package:needsclear/Provider/userprovider.dart';
import 'package:needsclear/SignUp/smsauth.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  UserProvider userProvider = UserProvider();
  SaveData saveData = SaveData();

  SharedPreferences prefs;

  DateTime currentBackPressTime;

  TextEditingController _idController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  FocusNode _passFocus = FocusNode();

  bool autoLoginCheck = false;

  int passEdit = 0;

//  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();

  bool loginBtnClick = false;

//  kakaoLogin() async {
//    print("login");
//    final KakaoLoginResult result = await kakaoSignIn.logIn();
//    switch (result.status) {
//      case KakaoLoginStatus.loggedIn:
//        print('LoggedIn by the user.\n'
//            '- UserID is ${result.account.userID}\n'
//            '- UserEmail is ${result.account.userEmail} ');
//
//        userProvider.snsLogin(result.account.userID, 1).then((value) {
//          if (value == 0) {
//            customDialog("등록되지 않은 회원 입니다.", 0);
//          } else {
//            if (autoLoginCheck) {
//              sharedInit(1, result.account.userID);
//            }
//
//            Navigator.of(context).pushNamedAndRemoveUntil("/Home",
//                    (Route<dynamic> route) => false);
//          }
//        });
//
//        break;
//      case KakaoLoginStatus.loggedOut:
//        print('LoggedOut by the user.');
//        break;
//      case KakaoLoginStatus.error:
//        print('This is Kakao error message : ${result.errorMessage}');
//        if (result.errorMessage.contains("CANCELED_OPERATION")) {
//          showToast("로그인을 취소하였습니다.");
//        } else {
//          showToast("로그인 중 오류가 발생하였습니다. 다시시도해주세요.");
//        }
//        break;
//    }
//  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

//  final GoogleSignIn googleSignIn = GoogleSignIn();

//  Future<void> googleLogin() async {
//    try {
//      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//      final GoogleSignInAuthentication googleSignInAuthentication =
//      await googleSignInAccount.authentication;
//
//      final AuthCredential credential = GoogleAuthProvider.getCredential(
//        accessToken: googleSignInAuthentication.accessToken,
//        idToken: googleSignInAuthentication.idToken,
//      );
//
//      final AuthResult authResult = await _auth.signInWithCredential(credential);
//      final FirebaseUser user = authResult.user;
//
//      assert(!user.isAnonymous);
//      assert(await user.getIdToken() != null);
//
//      final FirebaseUser currentUser = await _auth.currentUser();
//      assert(user.uid == currentUser.uid);
//
//      if (user.uid == currentUser.uid) {
//        userProvider.snsLogin(currentUser.uid, 2).then((value) {
//          if (value == 0) {
//            customDialog("등록되지 않은 회원 입니다.", 0);
//          } else {
//            if (autoLoginCheck) {
//              sharedInit(2, currentUser.uid);
//            }
//
//            Navigator.of(context).pushNamedAndRemoveUntil("/Home",
//                    (Route<dynamic> route) => false);
//          }
//        });
//      } else {
//        showToast("구글 로그인 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
//      }
//
//      print("currentUser : ${currentUser.uid}");
//    } catch (error) {
//      print("googleError : ${error}");
//      if (error.toString().contains("authentication") && error.toString().contains("null")) {
//        showToast("구글 로그인을 취소하였습니다.");
//      } else {
//        showToast("구글 로그인 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
//      }
//    }
//  }
//
//  final facebookLogin = FacebookLogin();
//
//  fbLogin() async {
//    final result = await facebookLogin.logIn(['email', 'public_profile']);
//
//    switch (result.status) {
//      case FacebookLoginStatus.loggedIn:
//        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
//        final profile = json.decode(graphResponse.body);
//        print("id : ${profile['id']}");
//        print("token : ${result.accessToken.token}");
//
//        userProvider.snsLogin(profile['id'], 3).then((value) {
//          if (value == 0) {
//            customDialog("등록되지 않은 회원 입니다.", 0);
//          } else {
//            if (autoLoginCheck) {
//              sharedInit(3, profile['id']);
//            }
//
//            Navigator.of(context).pushNamedAndRemoveUntil("/Home",
//                    (Route<dynamic> route) => false);
//          }
//        });
//
//        break;
//      case FacebookLoginStatus.cancelledByUser:
//        showToast("facebook 로그인을 취소하였습니다.");
//        break;
//      case FacebookLoginStatus.error:
//        showToast("facebook 로그인 중 오류가 발생하였습니다. 잠시 후에 다시 시도해주세요.");
//        print("fbError : " + result.errorMessage.toString());
//        break;
//    }
//  }
//
//  Future<Null> _getAccountInfo() async {
//    final KakaoLoginResult result = await kakaoSignIn.getUserMe();
//    if (result != null && result.status != KakaoLoginStatus.error) {
//      final KakaoAccountResult account = result.account;
//      final userID = account.userID;
//      final userEmail = account.userEmail;
//      final userPhoneNumber = account.userPhoneNumber;
//      final userDisplayID = account.userDisplayID;
//      final userNickname = account.userNickname;
//      // To-do Someting ...
//
//      print("userID : ${userID}, userEmail : ${userEmail}, userPhoneNumber : ${userPhoneNumber}, userDisplayId : ${userDisplayID}, userNickName : ${userNickname}");
//    }
//  }

  btnSet() {
    loginBtnClick = false;
  }

  sharedInit(type, userID) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("autoLogin", 1);
    if (type == 0) {
      await prefs.setString("id", _idController.text);
      await prefs.setString("pass", _passController.text);
    } else {
      await prefs.setString("id", userID);
    }

    await prefs.setInt("type", type);
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
  void initState() {
    super.initState();

// royalCodeUpdate
//    userProvider.royalCodeUpdate();
  }

  passFinderDialog() {
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
                    "비밀번호를 5회 이상 틀렸습니다.\n비밀번호 찾기를 하시겠습니까?",
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmsAuth(type: 2)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 167, 167, 167)),
                            child: Center(
                              child: Text(
                                "비밀번호 찾기",
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
//                      Expanded(
//                        child: GestureDetector(
//                          onTap: () {
//                            Navigator.of(context).pop();
//                          },
//                          child: Container(
//                            width: MediaQuery.of(context).size.width,
//                            height: 40,
//                            decoration: BoxDecoration(
//                                color: Color.fromARGB(255, 167, 167, 167)),
//                            child: Center(
//                              child: Text(
//                                "취소",
//                                style: TextStyle(
//                                    fontSize: 14,
//                                    color: white,
//                                    fontWeight: FontWeight.w600),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                      whiteSpaceW(5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (type == 0) {
                              Navigator.of(context).pop();
                            } else {

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

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToast("한번 더 누르면 종료됩니다.");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: WillPopScope(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                children: <Widget>[
                  whiteSpaceH(MediaQuery.of(context).size.height / 8),
                  Row(
                    children: <Widget>[
                      whiteSpaceW(40),
                      Image.asset(
                        "assets/appicon/app_icon.png",
                        width: 80,
                      ),
                      whiteSpaceW(15),
                      Text(
                        "생활서비스의\n모든것 알라딘매직",
                        style: TextStyle(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      whiteSpaceW(40)
                    ],
                  ),
                  whiteSpaceH(20),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _idController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_passFocus);
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 167, 167, 167)),
                              hintText: "아이디를 입력해 주세요.",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              contentPadding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 5)),
                        ),
                        whiteSpaceH(15),
                        TextFormField(
                          focusNode: _passFocus,
                          controller: _passController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          onFieldSubmitted: (value) {},
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 167, 167, 167)),
                              hintText: "비밀번호를 입력해 주세요.",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              contentPadding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 5)),
                        ),
                        whiteSpaceH(10),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              value: autoLoginCheck,
                              activeColor: mainColor,
                              onChanged: (value) {
                                setState(() {
                                  autoLoginCheck = value;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                "자동로그인",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (_idController.text == null || _idController.text == "") {
                                  showToast("아이디를 입력해 주세요.");
                                } else if (_passController.text == null || _passController.text == "") {
                                  showToast("비밀번호를 입력해 주세요.");
                                } else {
                                  userProvider.login(_idController.text, _passController.text, 0).then((value) {
                                    if (value == 0) {
                                      if (passEdit >= 5) {
                                        passFinderDialog();
                                      } else {
                                        passEdit += 1;
                                        customDialog("아이디 혹은 비밀번호를\n잘못 입력하셨거나\n등록되지 않은 회원 입니다.", 0);
                                      }
                                    } else {
                                      if (autoLoginCheck) {
                                        sharedInit(0, "");
                                      }

                                      Navigator.of(context).pushNamedAndRemoveUntil("/Home",
                                              (Route<dynamic> route) => false);
                                    }
                                  });
                                }
                              },
                              color: Color.fromARGB(255, 167, 167, 167),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0.0,
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                        whiteSpaceH(50),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("아이디찾기");
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmsAuth(type: 1)));
                                },
                                child: Text(
                                  "아이디찾기",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 10,
                              color: black,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("비밀번호찾기");
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmsAuth(type: 2)));
                                },
                                child: Text(
                                  "비밀번호찾기",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              width: 2,
                              height: 10,
                              color: black,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("회원가입");
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmsAuth(type: 0)));
//                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp(type: 0,)));
                                },
                                child: Text(
                                  "회원가입",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: black,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  whiteSpaceH(40),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 189, 189, 189),
                    ),
                  ),
                  whiteSpaceH(40),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "SNS 계정 로그인",
                            style: TextStyle(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        whiteSpaceH(20),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("kakaoLogin");
//                                  serviceDialog("서비스 준비 중입니다.");
                                  if (!loginBtnClick) {
//                                    kakaoLogin();
                                    loginBtnClick = true;
                                    Timer(Duration(seconds: 2), btnSet);
                                  }
                                },
                                child: Image.asset(
                                  "assets/icon/kakao_icon.png",
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("facebooeLogin");
//                                  serviceDialog("서비스 준비 중입니다.");
                                  if (!loginBtnClick) {
//                                    fbLogin();
                                    loginBtnClick = true;
                                    Timer(Duration(seconds: 2), btnSet);
                                  }
                                },
                                child: Image.asset(
                                  "assets/icon/facebook_icon.png",
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("googleLogin");
//                                  serviceDialog("서비스 준비 중입니다.");
                                  if (!loginBtnClick) {
//                                    googleLogin();
                                    loginBtnClick = true;
                                    Timer(Duration(seconds: 2), btnSet);
                                  }
                                },
                                child: Image.asset(
                                  "assets/icon/google_icon.png",
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          onWillPop: onWillPop,
        ));
  }
}
