import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class Terms extends StatefulWidget {
  @override
  _Terms createState() => _Terms();
}

class _Terms extends State<Terms> {
  bool type = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
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
        title: mainMove("약관 및 정책", context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        type = true;
                      });
                    },
                    child: Container(
                      width: 52,
                      height: 32,
                      child: Column(
                        children: [
                          Text(
                            "이용약관",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          type
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 4,
                                  color: mainColor,
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  whiteSpaceW(10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        type = false;
                      });
                    },
                    child: Container(
                      width: 112,
                      height: 32,
                      child: Column(
                        children: [
                          Text(
                            "개인정보 처리방침",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          !type
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 4,
                                  color: mainColor,
                                )
                              : Container()
                        ],
                      ),
                    ),
                  )
                ],
              ),
              whiteSpaceH(32),
              Text(
                type ? "이용약관" : "개인정보 처리방침",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'noto',
                    color: black,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
