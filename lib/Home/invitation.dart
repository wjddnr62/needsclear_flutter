import 'package:flutter/material.dart';
import 'package:needsclear/Util/text.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';
import 'package:share/share.dart';

class Invitation extends StatefulWidget {
  @override
  _Invitation createState() => _Invitation();
}

class _Invitation extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
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
        height: MediaQuery.of(context).size.height,
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            whiteSpaceH(24),
            Image.asset(
              "assets/needsclear/resource/home/reco/invite.png",
              width: 200,
              height: 200,
            ),
            Padding(
              padding: EdgeInsets.only(top: 24, left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: white,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    customText(StyleCustom(
                        fontSize: 20,
                        color: black,
                        text: "나의 친구들에게도",
                        fontWeight: FontWeight.w600)),
                    whiteSpaceH(4),
                    RichText(
                      text: TextSpan(
                          text: "니즈클리어",
                          style: TextStyle(
                              fontFamily: 'noto',
                              fontWeight: FontWeight.w600,
                              color: mainColor,
                              fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: "를 추천해보세요.",
                                style: TextStyle(
                                    fontFamily: 'noto',
                                    fontSize: 20,
                                    color: black,
                                    fontWeight: FontWeight.w600))
                          ]),
                    ),
//                    whiteSpaceH(32),
//                    Container(
//                      width: MediaQuery.of(context).size.width,
//                      height: 40,
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          customText(StyleCustom(
//                              text: "내 추천코드",
//                              fontSize: 14,
//                              color: Color(0xFF444444))),
//                          whiteSpaceW(16),
//                          customText(StyleCustom(
//                              text: dataStorage.user.recoCode,
//                              color: mainColor,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 14))
//                        ],
//                      ),
//                    ),
                    whiteSpaceH(40),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: RaisedButton(
                        onPressed: () {
                          Share.share("생활서비스의 모든것 니즈클리어\n새로운 경험을 지금 시작해 보세요.");
                        },
                        elevation: 0.0,
                        color: mainColor,
                        child: Center(
                          child: customText(StyleCustom(
                              fontSize: 14,
                              color: white,
                              text: "추천하기",
                              fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
