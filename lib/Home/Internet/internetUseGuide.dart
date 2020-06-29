import 'package:flutter/material.dart';
import 'package:needsclear/Home/Internet/internet.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import 'internetapply.dart';

class InternetUseGuide extends StatefulWidget {
  @override
  _InternetUseGuide createState() => _InternetUseGuide();
}

class _InternetUseGuide extends State<InternetUseGuide> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Internet()),
                (route) => false);
          },
          icon: Image.asset(
            "assets/needsclear/resource/home/close.png",
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/needsclear/resource/guide/internetUseGuide.png",
              fit: BoxFit.cover,
            ),
            whiteSpaceH(20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 43,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InternetApply()));
                },
                color: mainColor,
                elevation: 0.0,
                child: Center(
                  child: Text(
                    "인터넷 가입 서비스 이용하기",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'noto',
                        color: white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            whiteSpaceH(40)
          ],
        ),
      ),
    );
  }
}
