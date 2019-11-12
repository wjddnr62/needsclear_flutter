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

  Future<int> login(id, pass, type) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot authQuery = await userCollection
        .where("id", isEqualTo: id)
        .where("pass", isEqualTo: pass)
        .where("type", isEqualTo: type)
        .getDocuments();

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
      saveData.pushRecoCode = authQuery.documents[0].data['pushRecoCode'];
      saveData.signDate = authQuery.documents[0].data['signDate'];
      return 1;
    }
  }

  Future<int> snsLogin(id, type) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot authQuery = await userCollection
        .where("id", isEqualTo: id)
        .where("type", isEqualTo: type)
        .getDocuments();

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
      saveData.pushRecoCode = authQuery.documents[0].data['pushRecoCode'];
      saveData.signDate = authQuery.documents[0].data['signDate'];
      return 1;
    }
  }

  Future<int> checkReCoCode(reCoCode) async {

    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot recoQuery = await userCollection
        .where("recoCode", isEqualTo: reCoCode)
        .getDocuments();

    if (recoQuery.documents.length == 0) {
      return 0;
    } else {
      final List<DocumentSnapshot> docs = recoQuery.documents;

      saveData.reCoId = docs[0].data['id'];
      return 1;
    }
  }

  Future<int> getrecoLength(recoCode) async {
    CollectionReference recoCollection = Firestore.instance.collection("reco");

    QuerySnapshot recoQuery =
    await recoCollection.where("recoCode", isEqualTo: recoCode).getDocuments();

    return recoQuery.documents.length;
  }

  Future<int> getVersionCode() async {
    CollectionReference versionCollection = Firestore.instance.collection("version");

    QuerySnapshot versionQuery = await versionCollection.getDocuments();

    saveData.storeVersionCode = versionQuery.documents[0].data['versionCode'];

    print("saveData2 : ${saveData.storeVersionCode}");

    return versionQuery.documents[0].data['versionCode'];
  }

  Future<int> idDuplicate(id) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("id", isEqualTo: id).getDocuments();

    print("length : ${userQuery.documents.length}");

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  insertPoint(id, point, recoLog) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("id", isEqualTo: id).getDocuments();

    int point = userQuery.documents[0].data['point'] + 500;
    int recoPerson = userQuery.documents[0].data['recoPerson'] + 1;
    int recoPrice = userQuery.documents[0].data['recoPrice'] + 500;

    print("point : " + point.toString());

    Firestore.instance
        .collection("users")
        .document(userQuery.documents[0].documentID)
        .updateData(
            {'point': point, 'recoPerson': recoPerson, 'recoPrice': recoPrice});

    Firestore.instance.collection("reco").add(recoLog).catchError((e) {
      print("addCallLogError : " + e.toString());
    });

    return null;
  }

  deliveryInsertPoint(pushRecoCode, id, point, recoLog) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
    await userCollection.where("id", isEqualTo: id).getDocuments();

    int point = userQuery.documents[0].data['point'] + 300;
    print("point : " + point.toString());

    Firestore.instance
        .collection("users")
        .document(userQuery.documents[0].documentID)
        .updateData(
        {'point': point});

    if (pushRecoCode != null && pushRecoCode != "") {
      QuerySnapshot pushQuery = await userCollection.where("recoCode", isEqualTo: pushRecoCode).getDocuments();
      int pushPoint = pushQuery.documents[0].data['point'] + 100;
      Firestore.instance
          .collection("users")
          .document(pushQuery.documents[0].documentID)
          .updateData(
          {'point': pushPoint});

      Firestore.instance.collection("reco").add(recoLog).catchError((e) {
        print("addCallLogError : " + e.toString());
      });
    }



    return null;
  }
}
