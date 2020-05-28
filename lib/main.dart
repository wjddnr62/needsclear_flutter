import 'dart:async';
import 'dart:io';

import 'package:aladdinmagic/Model/users.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/text.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:aladdinmagic/public/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'Util/whiteSpace.dart';

void main() => runApp(MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: ThemeData(cursorColor: mainColor),
    ));

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  List<String> test = List();

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Loading');
  }

  UserProvider userProvider = UserProvider();

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
                : "",
            phone: "\"${userQuery.documents[i].data['phone']}\"",
            birthDay: "\"${userQuery.documents[i].data['birthDay']}\"",
            id: "\"${userQuery.documents[i].data['id']}\"",
            sex: userQuery.documents[i].data['sex'],
            signDate: "\"${userQuery.documents[i].data['signDate']}\"",
            signRoot: "\"${userQuery.documents[i].data['signRoot']}\"",
            type: userQuery.documents[i].data['type']));
      }

      for (int i = 0; i < users.length; i++) {
        print("type: " + users[i].type.toString());
        if (users[i].type == 0) {
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
      _write(jsonList);
      print("jsonList : $jsonList");
    }
  }

  @override
  void initState() {
    super.initState();

//    userProvider.userUpdate();
//    userProvider.recoUpdate();

//    jsonConvert();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            whiteSpaceH(80),
            Image.asset(
              "assets/icon/logo.png",
              fit: BoxFit.contain,
              width: 100,
            ),
            whiteSpaceH(24),
            customText(StyleCustom(
                text: "생활서비스의\n모든 것",
                fontSize: 14,
                fontWeight: FontWeight.w600
            ))
//            whiteSpaceH(MediaQuery.of(context).size.height / 5),
//            Image.asset(
//              "assets/appicon/app_icon.png",
//              width: MediaQuery.of(context).size.width / 2.5,
//              fit: BoxFit.fill,
//            ),
//            whiteSpaceH(30),
//            Text(
//              "Aladin Magic",
//              style: TextStyle(
//                  color: black, fontSize: 18, fontWeight: FontWeight.bold),
//            )
          ],
        ),
      ),
    );
  }
}
