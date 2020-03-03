import 'package:aladdinmagic/Util/mainMove.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class MemberWFin extends StatefulWidget {

  String date;

  MemberWFin({Key key, this.date}) : super(key : key);

  @override
  _MemberWFin createState() => _MemberWFin();
}

class _MemberWFin extends State<MemberWFin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: mainMove("회원탈퇴", context),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          whiteSpaceH(40),
          Row(
            children: <Widget>[
              whiteSpaceW(40),
              Icon(Icons.info, color: black,),
              whiteSpaceW(10),
              Column(
                children: <Widget>[
                  Text("회원탈퇴가 완료되었습니다.", style: TextStyle(
                      color: black, fontWeight: FontWeight.w600, fontSize: 16
                  ),),
                  whiteSpaceH(10),
                  Text("(탈퇴 날짜 : ${widget.date})", style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: black
                  ),)
                ],
              ),
              whiteSpaceW(40),
            ],
          ),
//          whiteSpaceH(60),
//          Padding(
//            padding: EdgeInsets.only(left: 20, right: 20),
//            child: Row(
//              children: <Widget>[
//                Text("14일 이내 재 로그인 시 ", style: TextStyle(color: black),),
//                Text("탈퇴회원복구", style: TextStyle(
//                  color: Colors.blueAccent, decoration: TextDecoration.underline
//                ),),
//                Text(" 절차를 진행 하실 수 있습니다.", style: TextStyle(color: black),)
//              ],
//            ),
//          ),
          whiteSpaceH(80),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil("/Login",
                      (Route<dynamic> route) => false);
            },
            color: Color.fromARGB(255, 167, 167, 167),
            elevation: 0.0,
            child: Container(
              width: 100,
              height: 40,
              child: Center(
                child: Text("확인", style: TextStyle(
                    color: white, fontWeight: FontWeight.w600
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }

}