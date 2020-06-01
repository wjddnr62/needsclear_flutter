import 'package:flutter/material.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/text.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class NewRecoList extends StatefulWidget {
  @override
  _NewRecoList createState() => _NewRecoList();
}

class _NewRecoList extends State<NewRecoList> {
  int recoPerson = 0;
  bool type = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColor,
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
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(16),
              color: mainColor,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(StyleCustom(
                            text: "추천인 관리",
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
//                        whiteSpaceH(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            customText(StyleCustom(
                                fontSize: 24,
                                color: Color(0xFFFFE600),
                                text: numberFormat.format(recoPerson) + "명 ")),
                            Expanded(
                              child: Text(
                                "추천하기",
                                style: TextStyle(
                                    color: Color(0xFFFFE600),
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Image.asset(
                              "assets/needsclear/resource/partner.png",
                              width: 80,
                              height: 90,
                              fit: BoxFit.contain,
                            )
                          ],
                        )
                      ],
                    ),
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
