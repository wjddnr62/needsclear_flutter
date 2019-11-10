
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  @override
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading> with SingleTickerProviderStateMixin {
  var connectivityResult;
  bool networking = false;
  SharedPreferences prefs;

  UserProvider userProvider = UserProvider();

  String id = "";
  String pass = "";

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
        return 2;
      }
    }
  }

  autoLoginCheck() {
    sharedInit().then((result) {
      if (result == 0) {
        print("movePermission");
        Navigator.of(context).pushReplacementNamed("/Permission");
      } else if (result == 1) {
        print("moveLogin");
        Navigator.of(context).pushReplacementNamed("/Login");
      } else {
        userProvider.login(id, pass).then((value) {
          if (value == 1) {

            Navigator.of(context).pushNamedAndRemoveUntil("/Home",
                    (Route<dynamic> route) => false);
          }
        });
        print("moveHome");
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // 자동 로그인 체크도 해야 함

    connectivityResult = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        setState(() {
          networking = true;
          autoLoginCheck();
          print("mobile");
        });
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          networking = true;
          autoLoginCheck();
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
