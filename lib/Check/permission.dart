import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:needsclear/Login/combinelogin.dart';
import 'package:needsclear/Model/users.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print("path : $path");
    return File('$path/data.json');
  }

//  void printWrapped(List text) {
//    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
//    pattern.allMatches(text.toString()).forEach((match) => print("wrap : " + match.group(0)));
//  }

  Future<File> writeCounter(List jsonList) async {
    final file = await _localFile;

    print("uri : ${file.path}, ${file.uri}");

    // 파일 쓰기
    return file.writeAsString('$jsonList');
  }

  _write(List text) async {
    try {
      final Directory directory = await getExternalStorageDirectory();
      final File file = File('${directory.path}/my_file.json');
      print("filePath : ${file.path}");
      await file.writeAsString(text.toString());
    } catch (e) {
      print("catch : " + e.toString());
    }
  }

  jsonConvert() async {
    CollectionReference userCollection = Firestore.instance.collection("users");
    QuerySnapshot userQuery = await userCollection.getDocuments();
    List<Users> users = List();
    List jsonList = List();

    if (userQuery.documents.length != 0) {
      for (int i = 0; i < userQuery.documents.length; i++) {
        users.add(Users(
            name: "\"${userQuery.documents[i].data['name']}\"",
            pass: (userQuery.documents[i].data['pass'] != null &&
                userQuery.documents[i].data['pass'] != "")
                ? "\"${userQuery.documents[i].data['pass']}\""
                : "\"\"",
            phone: "\"${userQuery.documents[i].data['phone']}\"",
            birthDay: "\"${userQuery.documents[i].data['birthDay']}\"",
            id: "\"${userQuery.documents[i].data['id']}\"",
            sex: userQuery.documents[i].data['sex'],
            signDate: "\"${userQuery.documents[i].data['signDate']}\"",
            signRoot: "\"${userQuery.documents[i].data['signRoot']}\"",
            type: userQuery.documents[i].data['type']));
      }

      for (int i = 0; i < users.length; i++) {
//        print("type: " + users[i].type.toString());
        if (users[i].type == 3) {
          jsonList.add(users[i].toJson());
        }
      }
//      users
//          .map((item) =>
////        if (item.type == 0) {
////          print("type : ${item.type}");
//                  jsonList.add(item.toJson())
////        }
//              )
//          .toList();

//      writeCounter(jsonList).then((value) {
//        print("finish : $value}");
//      }).catchError((value) {
//        print('error : $value');
//      });
//      printWrapped(jsonList);
      await _write(jsonList);
      print("jsonList : $jsonList");
    }
  }

  @override
  void initState() {
    super.initState();

//    jsonConvert();
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
                    Text(
                      "권한 승인 안내",
                      style: TextStyle(
                          fontSize: 28,
                          color: black,
                          fontWeight: FontWeight.bold),
                    ),
                    whiteSpaceH(MediaQuery.of(context).size.height / 5),
                    Text(
                      "니즈클리어을(를) 이용하시려면\n아래의 권한을 허용해주세요.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(40),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: black, width: 1)),
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "연락처",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            whiteSpaceH(10),
                            Expanded(
                              child: Text(
                                "- 연락처 기반 친구추천 서비스 제공",
                                style: TextStyle(color: black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    whiteSpaceH(40),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "필수 권한을 설정하지 않으시면, 앱 사용이 제한됩니다.\n(안드로이드 마시멜로6.0이상 사용자 대상)",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: black),
                      ),
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
//                        jsonConvert();

                        sharedInit();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CombineLogin()));
//                        Navigator.of(context).push(
//                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        showToast("연락처 권한을 승인해주세요.");
                      }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Color.fromARGB(255, 167, 167, 167),
                    child: Center(
                      child: Text(
                        "승인하기",
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
        ),
      ),
    );
  }
}
