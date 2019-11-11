import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecoList extends StatefulWidget {
  @override
  _RecoList createState() => _RecoList();
}

class _RecoList extends State<RecoList> {
  SaveData saveData = SaveData();
  UserProvider userProvider = UserProvider();
  int recoPerson = 0;

  @override
  void initState() {
    super.initState();

    userProvider.getrecoLength(saveData.myRecoCode).then((value) {
      setState(() {
        recoPerson = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text(
            "추천인목록",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: black),
          ),
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              whiteSpaceH(20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "추천인 ${recoPerson}명",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ),
              ),
              whiteSpaceH(20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: Color.fromARGB(255, 129, 129, 129),
                child: Row(
                  children: <Widget>[
                    whiteSpaceW(30),
                    Expanded(
                      child: Text(
                        "성  명",
                        style:
                        TextStyle(fontWeight: FontWeight.w600, color: white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 15,
                      color: white,
                    ),
                    Expanded(
                      child: Text(
                        "전화번호",
                        style:
                        TextStyle(fontWeight: FontWeight.w600, color: white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 15,
                      color: white,
                    ),
                    Expanded(
                      child: Text(
                        "가입일",
                        style:
                        TextStyle(fontWeight: FontWeight.w600, color: white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    whiteSpaceW(30)
                  ],
                ),
              ),
              whiteSpaceH(20),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('reco')
                    .where("recoCode", isEqualTo: saveData.myRecoCode)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height - 40 - 90 - MediaQuery.of(context).padding.top - 60,
                      child: ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                whiteSpaceW(30),
                                Expanded(
                                  child: Text(document['name'], textAlign: TextAlign.center,),
                                ),
                                Expanded(
                                  child: Text(document['phone'], textAlign: TextAlign.center,),
                                ),
                                Expanded(
                                  child: Text(document['signDate'], textAlign: TextAlign.center,),
                                ),
                                whiteSpaceW(30)
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
            ],
          ),
        ));
  }
}
