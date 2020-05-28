import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/customDialog.dart';
import 'package:aladdinmagic/Util/showToast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindPass extends StatefulWidget {
  @override
  _FindPass createState() => _FindPass();
}

class _FindPass extends State<FindPass> {
  SaveData saveData = SaveData();
  UserProvider userProvider = UserProvider();

  TextEditingController _passController = TextEditingController();
  TextEditingController _rePassController = TextEditingController();

  FocusNode _passFocus = FocusNode();
  FocusNode _rePassFocus = FocusNode();

  SharedPreferences prefs;

  sharedLogout() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt("autoLogin", 0);
    await prefs.setString("id", "");
    await prefs.setString("pass", "");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            whiteSpaceH(60),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: <Widget>[
                  Icon(Icons.check, color: black,),
                  Text("새로운 비밀번호를 입력해주세요.", style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14, color: black
                  ),)
                ],
              ),
            ),
            whiteSpaceH(40),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: _passController,
                focusNode: _passFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_rePassFocus);
                },
                obscureText: true,
                maxLength: 12,
                decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 167, 167, 167)),
                    hintText: "비밀번호를 입력해 주세요(4자~12자)",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    contentPadding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5)),
              ),
            ),
            whiteSpaceH(20),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: _rePassController,
                focusNode: _rePassFocus,
                textInputAction: TextInputAction.done,
                obscureText: true,
                maxLength: 12,
                decoration: InputDecoration(
                    counterText: "",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 167, 167, 167)),
                    hintText: "비밀번호를 다시 입력해 주세요(4자~12자)",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    contentPadding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 5)),
              ),
            ),
            whiteSpaceH(50),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: GestureDetector(
                onTap: () {
                  if ((_passController.text != null && _passController.text != "" && _passController.text.isNotEmpty) && _rePassController.text != null && _rePassController.text != "" && _rePassController.text.isNotEmpty) {
                    if (_passController.text.length < 4 || _rePassController.text.length < 4) {
                      showToast("4자리 이상 입력해주세요.");
                    } else {
                      if (_passController.text == _rePassController.text) {
                        userProvider.userPasswordUpdate(saveData.findId, _passController.text).then((value) {
                          if (value == 0) {
                            sharedLogout();
                            customDialog("비밀번호가 변경되었습니다.\n\n변경하신 비밀번호로\n로그인을 해주세요.", 1, context);
                          }
                        });
                      } else {
                        showToast("비밀번호가 서로 일치하지 않습니다.");
                      }
                    }
                  } else {
                    showToast("비밀번호를 입력해주세요.");
                  }
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
                    child: Text("비밀번호 변경완료", style: TextStyle(
                        color: black
                    ),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}