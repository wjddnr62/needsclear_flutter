import 'package:flutter/material.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class InquiryRegister extends StatefulWidget {
  @override
  _InquiryRegister createState() => _InquiryRegister();
}

class _InquiryRegister extends State<InquiryRegister> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  bool activate = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(
          icon: Image.asset(
            "assets/needsclear/resource/home/close.png",
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "제목",
                style: TextStyle(
                    fontSize: 12, fontFamily: 'noto', color: Color(0xFF888888)),
              ),
              whiteSpaceH(4),
              Container(
                height: 40,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  style:
                      TextStyle(fontFamily: 'noto', color: black, fontSize: 16),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: Color(0xFFDDDDDD))),
                      counterText: "",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                          borderRadius: BorderRadius.circular(0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                          borderRadius: BorderRadius.circular(0)),
                      contentPadding: EdgeInsets.only(left: 10, right: 10)),
                ),
              ),
              whiteSpaceH(36),
              Text(
                "내용",
                style: TextStyle(
                    fontSize: 12, fontFamily: 'noto', color: Color(0xFF888888)),
              ),
              whiteSpaceH(4),
              Container(
                height: 160,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  controller: contentController,
                  style:
                      TextStyle(fontFamily: 'noto', color: black, fontSize: 16),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(color: Color(0xFFDDDDDD))),
                      counterText: "",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                          borderRadius: BorderRadius.circular(0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                          borderRadius: BorderRadius.circular(0)),
                      contentPadding: EdgeInsets.only(left: 10, right: 10)),
                ),
              ),
              whiteSpaceH(100),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: RaisedButton(
                  onPressed: () async {
                    if (!activate) {
                      activate = true;
                      await provider
                          .insertInquiry(dataStorage.user.id,
                              titleController.text, contentController.text)
                          .then((value) {
                        activate = false;
                        Navigator.of(context).pop();
                        showToast("문의 완료되었습니다.");
                      });
                    }
                  },
                  color: mainColor,
                  child: Center(
                    child: Text(
                      "보내기",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'noto',
                          fontWeight: FontWeight.w600,
                          color: white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
