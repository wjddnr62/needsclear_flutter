import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Util/mainMove.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Reco extends StatefulWidget {
  @override
  _Reco createState() => _Reco();
}

class _Reco extends State {
  SaveData saveData = SaveData();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("royalCode : ${saveData.royalCode}");

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: mainMove("추천하기", context),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          whiteSpaceH(MediaQuery.of(context).size.height / 6),
          Center(
            child: Text(
              "알라딘매직이 필요하거나\n초대하고 싶은 친구들에게\n지금 추천해 보세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: black, fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          whiteSpaceH(20),
          Center(
            child: Text(
              "아래 [추천하기] 버튼을 터치하시면\n추천하기 팝업이 노출됩니다.",
              textAlign: TextAlign.center,
              style: TextStyle(color: black, fontWeight: FontWeight.w600),
            ),
          ),
          whiteSpaceH(20),
          Text(
            saveData.royalCode != null
                ? "내 추천코드 : ${saveData.royalCode}"
                : "내 추천코드 : ${saveData.myRecoCode.substring(2, 11)}",
            textAlign: TextAlign.center,
            style: TextStyle(color: black, fontWeight: FontWeight.w600),
          ),
          whiteSpaceH(20),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: GestureDetector(
              onTap: () {
                // 이미지는 base64로 convert 하여 보내면 됨
                Share.share(
                  saveData.royalCode != null
                      ? "생활서비스의 모든것 알라딘매직\n새로운 경험을 지금 시작해 보세요.\nhttps://play.google.com/store/apps/details?id=com.laon.aladdinmagic\n추천인 : ${saveData
                      .royalCode}"
                      : "생활서비스의 모든것 알라딘매직\n새로운 경험을 지금 시작해 보세요.\nhttps://play.google.com/store/apps/details?id=com.laon.aladdinmagic\n추천인 : ${saveData
                      .myRecoCode.substring(2, 11)}",
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: black),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text("추천하기"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
