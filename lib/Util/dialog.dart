import 'package:aladdinmagic/Util/text.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

serviceDialog(context) {
  return showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: white,
          child: Container(
            width: 300,
            height: 241,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(12)),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      whiteSpaceH(50),
                      customText(StyleCustom(fontSize: 16, text: "서비스 준비중입니다."))
                    ],
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              color: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12)),
                              ),
                              child: Center(
                                child: Text(
                                  "확인",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        );
      });
}
