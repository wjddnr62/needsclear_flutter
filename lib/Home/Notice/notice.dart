import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:needsclear/Model/notice.dart' as No;
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/public/colors.dart';

class Notice extends StatefulWidget {
  @override
  _Notice createState() => _Notice();
}

class _Notice extends State<Notice> {
  List<No.Notice> noticeList = List();

  @override
  void initState() {
    super.initState();

    noticeInit();
  }

  List<bool> viewVisible = List();

  noticeInit() async {
    await provider.getNotice().then((value) {
      List<dynamic> data = json.decode(value)['data'];

      for (int i = 0; i < data.length; i++) {
        noticeList.add(No.Notice(
            idx: data[i]['idx'],
            title: data[i]['title'],
            content: data[i]['content'],
            created_at: data[i]['created_at']));
        viewVisible.add(false);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: white,
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
        title: mainMove("공지사항", context),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          itemBuilder: (context, idx) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      viewVisible[idx] = !viewVisible[idx];
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noticeList[idx].title,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'noto',
                              color: black,
                              fontSize: 14),
                        ),
                        Text(
                          noticeList[idx].created_at.split(" ")[0],
                          style: TextStyle(
                              color: Color(0xFF888888),
                              fontFamily: 'noto',
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                viewVisible[idx]
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFFF7F7F7),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          noticeList[idx].content,
                          style: TextStyle(
                              fontSize: 12, fontFamily: 'noto', color: black),
                        ),
                      )
                    : Container()
              ],
            );
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: noticeList.length,
        ),
      ),
    );
  }
}
