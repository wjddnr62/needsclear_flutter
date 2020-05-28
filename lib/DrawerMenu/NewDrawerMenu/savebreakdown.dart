import 'package:aladdinmagic/Home/Exchange/exchange.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/text.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class NewSaveBreakDown extends StatefulWidget {
  @override
  _NewSaveBreakDown createState() => _NewSaveBreakDown();
}

class _NewSaveBreakDown extends State<NewSaveBreakDown> {
  AppBar appBar;
  int point = 0;
  bool type = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: appBar = AppBar(
        backgroundColor: Color(0xFF000C5B),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Exchange(type: 1)));
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: subColor,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(StyleCustom(
                            text: "적립 내역",
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                        whiteSpaceH(44),
                        Row(
                          children: [
                            customText(StyleCustom(
                                fontSize: 24,
                                color: mainColor,
                                text: numberFormat.format(point) + " ")),
                            customText(StyleCustom(
                                text: "NCP 환전하기",
                                fontSize: 16,
                                color: mainColor))
                          ],
                        )
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/needsclear/resource/exchange.png",
                    width: 72,
                    height: 72,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: white,
            child: Row(
              children: [
                whiteSpaceW(16),
                Expanded(
                  child: customText(StyleCustom(
                      color: Color(0xFF444444),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      text: "정렬")),
                ),
                GestureDetector(
                  onTap: () {
                    if (type) {
                      setState(() {
                        type = false;
                      });
                    }
                  },
                  child: customText(StyleCustom(
                      text: "최신순",
                      color: !type ? mainColor : Color(0xFF444444))),
                ),
                whiteSpaceW(16),
                GestureDetector(
                  onTap: () {
                    if (!type) {
                      setState(() {
                        type = true;
                      });
                    }
                  },
                  child: customText(StyleCustom(
                      text: "과거순",
                      color: type ? mainColor : Color(0xFF444444))),
                ),
                whiteSpaceW(16)
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color(0xFFCCCCCC),
          ),
          SingleChildScrollView()
        ],
      ),
    );
  }
}
