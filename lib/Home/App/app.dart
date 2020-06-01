import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  AppBar appBar;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: appBar = AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(
            "assets/needsclear/resource/public/prev.png",
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: Container(
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
                .top -
            MediaQuery
                .of(context)
                .padding
                .bottom -
            appBar.preferredSize.height,
        color: white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Image.asset(
                    "assets/icon/logo.png", fit: BoxFit.contain,),
                ),
              ),
              whiteSpaceH(24),
              Text("현재버전 : V.1.0.0\n최신버전을 사용 중입니다.", style: TextStyle(
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'noto',
                  fontSize: 14
              ), textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}
