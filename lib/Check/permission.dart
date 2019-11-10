
import 'package:aladdinmagic/Util/toast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Permission extends StatefulWidget {
  @override
  _Permission createState() => _Permission();
}

class _Permission extends State<Permission> {

  Map<PermissionGroup, PermissionStatus> permissions;
  SharedPreferences prefs;

  sharedInit() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("permission", 1);
  }

  Future<bool> permissionCheck() async {
    permissions = await PermissionHandler()
        .requestPermissions([PermissionGroup.contacts]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);

    print("check: " + permission.toString());
    bool pass = false;

    if (permission == PermissionStatus.granted) {
      pass = true;
    }

    return pass;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    whiteSpaceH(40),
                    Text("권한 승인 안내", style: TextStyle(
                        fontSize: 28, color: black, fontWeight: FontWeight.bold
                    ),),
                    whiteSpaceH(MediaQuery.of(context).size.height / 5),
                    Text("알라딘매직을 이용하시려면\n아래의 권한을 허용해주세요.", textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),),
                    whiteSpaceH(40),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: black, width: 1)
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("연락처", style: TextStyle(
                              color: black, fontSize: 16, fontWeight: FontWeight.w600
                            ),),
                            whiteSpaceH(10),
                            Expanded(
                              child: Text("- 연락처 기반 친구추천 서비스 제공", style: TextStyle(color: black),),
                            )
                          ],
                        ),
                      ),
                    ),
                    whiteSpaceH(40),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text("필수 권한을 설정하지 않으시면, 앱 사용이 제한됩니다.\n(안드로이드 마시멜로6.0이상 사용자 대상)",  textAlign: TextAlign.center, style: TextStyle(
                        color: black
                      ),),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    permissionCheck().then((pass) {
                      if (pass == true) {
                        sharedInit();
                        Navigator.of(context).pushReplacementNamed("/Login");
                      } else {
                        showToast(msg: "연락처 권한을 승인해주세요.");
                      }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Color.fromARGB(255, 167, 167, 167),
                    child: Center(
                      child: Text("승인하기", style: TextStyle(
                          fontSize: 14, color: white, fontWeight: FontWeight.w600
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