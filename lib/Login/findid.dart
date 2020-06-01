import 'package:flutter/material.dart';
import 'package:needsclear/Model/savedata.dart';
import 'package:needsclear/SignUp/smsauth.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class FindId extends StatefulWidget {
  @override
  _FindId createState() => _FindId();
}

class _FindId extends State<FindId> {
  SaveData saveData = SaveData();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20, top: 40),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close),
                ),
              ),
            ),
            whiteSpaceH(70),
            Text("아이디를 확인해 주세요.", style: TextStyle(
              color: black, fontSize: 14, fontWeight: FontWeight.w600
            ),),
            whiteSpaceH(50),
            Text("아이디 : ${saveData.findId}", style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: black
            ),),
            whiteSpaceH(40),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: black)
                  ),
                  child: Center(
                    child: Text("로그인", style: TextStyle(
                        color: black
                    ),),
                  ),
                ),
              ),
            ),
            whiteSpaceH(30),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color.fromARGB(255, 219, 219, 219),
              ),
            ),
            whiteSpaceH(30),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmsAuth(type: 2, )));
              },
              child: Text("비밀번호찾기", style: TextStyle(
                color: black, fontSize: 20, fontWeight: FontWeight.w600
              ),),
            )
          ],
        ),
      ),
    );
  }

}