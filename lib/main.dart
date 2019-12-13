import 'dart:async';

import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:aladdinmagic/public/routes.dart';
import 'package:flutter/material.dart';

import 'Util/whiteSpace.dart';

void main() => runApp(MaterialApp(
  home: Splash(),
  debugShowCheckedModeBanner: false,
  routes: routes,
  theme: ThemeData(
      cursorColor: mainColor
  ),
));

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Loading');
  }

  UserProvider userProvider = UserProvider();


  @override
  void initState() {
    super.initState();

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
        child: Column(
          children: <Widget>[
            whiteSpaceH(MediaQuery.of(context).size.height / 5),
            Image.asset("assets/appicon/app_icon.png", width: MediaQuery.of(context).size.width / 2.5, fit: BoxFit.fill,),
            whiteSpaceH(30),
            Text("Aladin Magic", style: TextStyle(
                color: black, fontSize: 18, fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }

}