import 'package:flutter/material.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class BusinessInformation extends StatefulWidget {
  @override
  _BusinessInformation createState() => _BusinessInformation();
}

class _BusinessInformation extends State<BusinessInformation> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1.0,
        centerTitle: true,
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
        title: mainMove("사업자 정보", context),
      ),
      backgroundColor: white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "법인명 : 호조아트(니즈클리어)",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(4),
            Text(
              "대표자 : 장수진",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(4),
            Text(
              "사업자번호 : 793-81-00566",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(4),
            Text(
              "연락처 : 070-4350-0318",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(4),
            Text(
              "팩스번호 : 0303-3441-0003",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(4),
            Text(
              "이메일 : pehnice@nate.com",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(4),
            Text(
              "주소 : 서울시 금천구 가산디지털1로 145, 207호 (가산동, 에이스하이엔드3차)",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(4),
            Text(
              "통신판매업 신고번호 : 2019-서울금천-1696호",
              style: TextStyle(color: black, fontFamily: 'noto', fontSize: 14),
            ),
            whiteSpaceH(16)
          ],
        ),
      ),
    );
  }
}
