import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:needsclear/Model/savedata.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class WithdrawHistory extends StatefulWidget {
  @override
  _WithdrawHistory createState() => _WithdrawHistory();
}

class _WithdrawHistory extends State<WithdrawHistory> {
  SaveData saveData = SaveData();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: mainMove("출금내역", context),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('withdraw')
            .where("id", isEqualTo: saveData.id)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.documents.sort(
                (a, b) => b['date'].toString().compareTo(a['date'].toString()));

            return Container(
              color: white,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            whiteSpaceW(20),
                            Column(
                              children: <Widget>[
                                whiteSpaceH(5),
                                Image.asset("assets/resource/money.png"),
                                whiteSpaceH(5),
                                Text(document['date']),
                              ],
                            ),
                            whiteSpaceW(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    numberFormat.format(
                                            document['deductionReserve']) +
                                        "원 출금신청",
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  whiteSpaceH(5),
                                  Text(
                                    document['bankName'] +
                                        "(${document['accountNumber']})",
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            whiteSpaceW(20),
                            Text(
                              document['type'] == 0
                                  ? "출금대기"
                                  : document['type'] == 1 ? "출금완료" : "출금취소",
                              style: document['type'] == 0
                                  ? TextStyle(color: Colors.blueAccent)
                                  : document['type'] == 1
                                      ? TextStyle(color: black)
                                      : TextStyle(color: Colors.redAccent),
                            ),
                            whiteSpaceW(20)
                          ],
                        ),
                        whiteSpaceH(10),
                        Container(
                          color: black,
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          padding: EdgeInsets.only(left: 15, right: 15),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
