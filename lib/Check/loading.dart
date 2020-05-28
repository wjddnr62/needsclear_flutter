import 'package:aladdinmagic/Login/combinelogin.dart';
import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Loading extends StatefulWidget {
  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> with SingleTickerProviderStateMixin {
  var connectivityResult;
  bool networking = false;
  bool appUpdate = false;
  SharedPreferences prefs;

  SaveData saveData = SaveData();

  UserProvider userProvider = UserProvider();

  String id = "";
  String pass = "";
  int type;

  int storeVersionCode;
  int nowVersionCode;

  String projectCode;

  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> googleLogout() async {
    print("googleLogout");
    googleSignIn.disconnect();
  }

  kakaoLogOut() async {
    print("logout");
    final KakaoLoginResult result = await kakaoSignIn.logOut();
    print("logout");
    switch (result.status) {
      case KakaoLoginStatus.loggedIn:
        print('LoggedIn by the user.\n'
            '- UserID is ${result.account.userID}\n'
            '- UserEmail is ${result.account.userEmail} ');

        break;
      case KakaoLoginStatus.loggedOut:
        print('LoggedOut by the user.');
        break;
      case KakaoLoginStatus.error:
        print('This is Kakao error message : ${result.errorMessage}');
        break;
    }
    // To-do Someting ...
  }

  final facebookLogin = FacebookLogin();

  fbLogout() async {
    await facebookLogin.logOut();
  }

  sharedLogout() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("autoLogin", 0);
    await prefs.setString("id", "");
    await prefs.setString("pass", "");

    kakaoLogOut();
    googleLogout();
    fbLogout();
  }

  Future<int> sharedInit() async {
    prefs = await SharedPreferences.getInstance();

    print(prefs.getInt("permission").toString());

    if (prefs.getInt("permission") == null || prefs.getInt("permission") == 0) {
      return 0;
    } else {
      if (prefs.getInt("autoLogin") == null || prefs.getInt("autoLogin") == 0) {
        return 1;
      } else {
        id = prefs.getString("id");
        pass = prefs.getString("pass");
        type = prefs.getInt("type");

        return 2;
      }
    }
  }

  notFindUserData() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("autoLogin", 0);
    await prefs.setString("id", "");
    await prefs.setString("pass", "");
  }

  autoLoginCheck() {
    sharedInit().then((result) {
      if (result == 0) {
        print("movePermission");
        sharedLogout();
        Navigator.of(context).pushReplacementNamed("/Permission");
      } else if (result == 1) {
        print("moveLogin");
        sharedLogout();
//        Navigator.of(context).pushReplacement(MaterialPageRoute(
//            builder: (context) => Login()
//        ));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => CombineLogin()
        ));
      } else {
        if (type == 0) {
          userProvider.login(id, pass, type).then((value) {
            if (value == 1) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/Home", (Route<dynamic> route) => false);
            } else {
              notFindUserData();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CombineLogin()
              ));
            }
          });
        } else {
          userProvider.snsLogin(id, type).then((value) {
            if (value == 1) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/Home", (Route<dynamic> route) => false);
            } else {
              notFindUserData();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CombineLogin()
              ));
            }
          });
        }

        print("moveHome");
      }
    });
  }

  movePage() {
    connectivityResult = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        setState(() {
          networking = true;
          getVersionCode();
          print("mobile");
        });
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          networking = true;
          getVersionCode();
          print("wifi");
        });
      } else {
        setState(() {
          networking = false;
          print("none");
        });
      }
    });
  }

  Future<String> loadVersion(context) async {
    saveData.nowVersionCode = await DefaultAssetBundle.of(context)
        .loadString("assets/version.txt");

    print('saveData : ${saveData.nowVersionCode}');

    return await DefaultAssetBundle.of(context)
        .loadString("assets/version.txt");
  }

  getVersionCode() async {
    print("getVersionCode");

    int nowCode;
    int versionCode;

    await loadVersion(context).then((value) {
      userProvider.getVersionCode().then((value) {
        nowCode = int.parse(saveData.nowVersionCode);
        versionCode = saveData.storeVersionCode;

        print("code : ${nowCode}, ${versionCode}");

        if (nowCode < versionCode) {
          print("storeUpdate");
          setState(() {
            appUpdate = true;
          });
        } else {
          autoLoginCheck();
          print("releaseVersion");
        }
      });
    });

//    autoLoginCheck();
  }

  @override
  void initState() {
    super.initState();

    movePage();
  }

  appUpdateDialog() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 4,
        left: 40,
        right: 40,
        bottom: MediaQuery.of(context).size.height / 3,
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: black, width: 1),
            color: Color.fromARGB(255, 219, 219, 219)),
        child: Column(
          children: <Widget>[
            whiteSpaceH(25),
            Text(
              "알림",
              style: TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            whiteSpaceH(25),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: black,
              ),
            ),
            whiteSpaceH(25),
            Text(
              "앱 최신 버전이 있습니다.",
              style: TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            whiteSpaceH(25),
            Text(
              "스토어로 이동하여 업데이트 하시겠습니까?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            whiteSpaceH(25),
            Row(
              children: <Widget>[
                whiteSpaceW(20),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    color: Color.fromARGB(255, 167, 167, 167),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Center(
                        child: Text(
                          "취소",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(10),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      launch(
                          "https://play.google.com/store/apps/details?id=com.laon.aladdinmagic");
                    },
                    color: Color.fromARGB(255, 167, 167, 167),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Center(
                        child: Text(
                          "확인",
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                whiteSpaceW(20),
              ],
            )
          ],
        ),
      ),
    );
  }

  networkDialog() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 4,
        left: 40,
        right: 40,
        bottom: MediaQuery.of(context).size.height / 3,
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: black, width: 1),
            color: Color.fromARGB(255, 219, 219, 219)),
        child: Column(
          children: <Widget>[
            whiteSpaceH(25),
            Text(
              "알림",
              style: TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            whiteSpaceH(25),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: black,
              ),
            ),
            whiteSpaceH(25),
            Text(
              "네트워크에 연결되어 있지 않습니다.",
              style: TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            whiteSpaceH(25),
            Text(
              "네트워크 연결 상태 확인 중,\n네트워크를 연결해 주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: black, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            whiteSpaceH(25),
            Center(
              child: SpinKitFadingCircle(
                color: black,
                size: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SpinKitFadingCircle(
                    color: black,
                    size: 80.0,
                  ),
                ),
              ],
            ),
            networking == false
                ? Positioned.fill(child: networkDialog())
                : Container(),
            appUpdate == true
                ? Positioned.fill(child: appUpdateDialog())
                : Container()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    connectivityResult.cancel();
  }
}
