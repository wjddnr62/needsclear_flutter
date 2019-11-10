import 'dart:async';

import 'package:aladdinmagic/Model/savedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  SaveData saveData = SaveData();

  Future<int> addUsers(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print('addUserError : ' + e.toString());
      return e;
    });
    return 0;
  }

  addCallLog(logData) async {
    Firestore.instance.collection("call").add(logData).catchError((e) {
      print("addCallLogError : " + e.toString());
    });
  }

  Future<int> login(id, pass) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot authQuery = await userCollection.where("id", isEqualTo: id).where("pass", isEqualTo: pass).getDocuments();

    // 탈퇴대기, 택배기사 로그인 따로있음 추후 추가

    if (authQuery.documents.length == 0) {
      return 0;
    } else {
      saveData.id = authQuery.documents[0].data['id'];
      saveData.phoneNumber = authQuery.documents[0].data['phone'];
      saveData.name = authQuery.documents[0].data['name'];
      saveData.sex = authQuery.documents[0].data['sex'];
      saveData.point = authQuery.documents[0].data['point'];
      saveData.recoPerson = authQuery.documents[0].data['recoPerson'];
      saveData.recoPrice = authQuery.documents[0].data['recoPrice'];
      saveData.myRecoCode = authQuery.documents[0].data['recoCode'];
      return 1;
    }
  }

  Future<int> idDuplicate(id) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery = await userCollection.where("id", isEqualTo: id).getDocuments();

    print("length : ${userQuery.documents.length}");

      if (userQuery.documents.length == 0) {
        return 0;
      } else {
        return 1;
      }

  }

  insertPoint(id, point) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery = await userCollection.where("id", isEqualTo: id).getDocuments();

    int point = userQuery.documents[0].data['point'] + 500;
    print("point : " + point.toString());

    Firestore.instance
        .collection("users")
        .document(userQuery.documents[0].documentID)
        .updateData({'point': point});

//    Firestore.instance
//        .collection("users")
//        .where("id", isEqualTo: id)
//        .snapshots()
//        .listen((data) {
//      if (data.documents.length == 0) {
//        return 1;
//      } else {
//        final List<DocumentSnapshot> docs = data.documents;
//
//        int point = docs[0].data['point'] + 500;
//        print("point : " + point.toString());
//
//        Firestore.instance
//            .collection("users")
//            .document(docs[0].documentID)
//            .updateData({'point': point});
//
//        return 0;
//      }
//    });

    return null;
  }
}
