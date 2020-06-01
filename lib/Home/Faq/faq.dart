import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:needsclear/Model/faq.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class Faq extends StatefulWidget {
  @override
  _Faq createState() => _Faq();
}

class _Faq extends State<Faq> {
  List<bool> viewVisible = new List();
  List<FaqM> faqList = new List();

  @override
  void initState() {
    super.initState();
    faqInit();
  }

  faqInit() async {
    await provider.getFaq().then((value) {
      List<dynamic> faq = json.decode(value)['data'];

      for (int i = 0; i < faq.length; i++) {
        faqList.add(FaqM(
            created_at: faq[i]['created_at'],
            idx: faq[i]['idx'],
            answer: faq[i]['answer'],
            question: faq[i]['question']));
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
        title: Text(
          "FAQ",
          style: TextStyle(
              fontFamily: 'noto',
              fontSize: 14,
              color: black,
              fontWeight: FontWeight.w600),
        ),
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
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "assets/needsclear/resource/public/q.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            whiteSpaceW(12),
                            Text(
                              faqList[idx].question,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'noto',
                                  color: black,
                                  fontSize: 14),
                            ),
                          ],
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "assets/needsclear/resource/public/a.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            whiteSpaceW(12),
                            Text(
                              faqList[idx].answer,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'noto',
                                  color: black),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            );
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: faqList.length,
        ),
      ),
    );
  }
}
