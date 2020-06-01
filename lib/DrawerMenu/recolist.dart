import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:needsclear/Model/savedata.dart';
import 'package:needsclear/Provider/userprovider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

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

    print(saveData.myRecoCode);
    print(saveData.recoCode);
    print(saveData.royalCode);

    userProvider
        .getrecoLength(saveData.royalCode, saveData.myRecoCode)
        .then((value) {
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
          title: mainMove("추천인목록", context),
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
                    "추천인 ${saveData.recoPerson}명",
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: white),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: white),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: white),
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
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  print(snapshot.hasData);
//                  snapshot.data.documents.where((doc) => doc['recoCode'] == saveData.royalCode || doc['recoCode'] == saveData.myRecoCode).map(f).toList();
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height -
                          40 -
                          90 -
                          MediaQuery.of(context).padding.top -
                          60,
                      child: ListView(
                        children: snapshot.data.documents.where((doc) =>
                        doc['recoCode'] == saveData.royalCode ||
                            doc['recoCode'] == saveData.myRecoCode).map((
                            DocumentSnapshot document) {
                          print("check : ${document['name']}");
                          return Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                whiteSpaceW(30),
                                Expanded(
                                  child: Text(
                                    document['name'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    document['phone'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    document['signDate'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                whiteSpaceW(30)
                              ],
                            ),
                          );
                        }).toList(),

//                        snapshot.data.documents
//                            .map((DocumentSnapshot document) {
//                              print("check : ${document['name']}");
//                          return Padding(
//                            padding: EdgeInsets.only(top: 5, bottom: 5),
//                            child: Row(
//                              children: <Widget>[
//                                whiteSpaceW(30),
//                                Expanded(
//                                  child: Text(
//                                    document['name'],
//                                    textAlign: TextAlign.center,
//                                  ),
//                                ),
//                                Expanded(
//                                  child: Text(
//                                    document['phone'],
//                                    textAlign: TextAlign.center,
//                                  ),
//                                ),
//                                Expanded(
//                                  child: Text(
//                                    document['signDate'],
//                                    textAlign: TextAlign.center,
//                                  ),
//                                ),
//                                whiteSpaceW(30)
//                              ],
//                            ),
//                          );
//                        }).toList(),
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
