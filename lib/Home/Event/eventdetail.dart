import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class EventDetail extends StatefulWidget {
  final String eventTitle;
  final String eventImage;

  EventDetail({this.eventTitle, this.eventImage});

  _EventDetail createState() => _EventDetail();
}

class _EventDetail extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        centerTitle: true,
        title: mainMove(widget.eventTitle, context),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image.memory(
                  base64.decode(widget.eventImage),
                  fit: BoxFit.contain,
                ),
                whiteSpaceH(16),
                Text(
                  widget.eventTitle,
                  style:
                      TextStyle(fontSize: 14, color: black, fontFamily: 'noto'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
