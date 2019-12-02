import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

customDialog(msg, type, context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "알림",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: black,
                      fontSize: 16),
                ),
                whiteSpaceH(20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Color.fromARGB(255, 167, 167, 167),
                ),
                whiteSpaceH(20),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: black,
                      fontSize: 16),
                ),
                whiteSpaceH(30),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (type == 0) {
                            Navigator.of(context).pop();
                          } else if (type == 1) {
                            Navigator.of(context).pushNamedAndRemoveUntil("/Login", (Route<dynamic> route) => false);
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 167, 167, 167)),
                          child: Center(
                            child: Text(
                              "확인",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}