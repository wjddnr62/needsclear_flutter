import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/public/colors.dart';

class Premium extends StatefulWidget {
  @override
  _Premium createState() => _Premium();
}

class _Premium extends State<Premium> {
  String content = "";

  dataSet() async {
    await provider.selectPremium().then((value) {
      List<dynamic> data = json.decode(value)['data'];

      content = data[0]['content'];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    dataSet();
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
        title: Text(
          "모집안내",
          style: TextStyle(
              fontFamily: 'noto',
              fontSize: 14,
              color: black,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
                "assets/needsclear/resource/guide/premiumMembership.png"),
          ),
//          Container(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
//            child: Text(
//              content,
//              style: TextStyle(
//                color: black,
//                fontFamily: 'noto',
//                fontSize: 14,
//              ),
//            ),
//          ),
        ),
      ),
    );
  }
}
