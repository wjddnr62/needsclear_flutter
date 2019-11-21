import 'dart:async';

import 'package:aladdinmagic/Model/savedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserProvider {
  SaveData saveData = SaveData();

  Future<int> addUsers(userData, saveLog) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print('addUserError : ' + e.toString());
      return e;
    });

    Firestore.instance.collection("saveLog").add(saveLog).catchError((e) {
      print("addCallLogError : " + e.toString());
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

  Future<int> recoCodeOverlapCheck(phone) async {
    CollectionReference overLapCollection =
        Firestore.instance.collection("users");

    QuerySnapshot overQuery = await overLapCollection
        .where("recoCode", isEqualTo: phone)
        .getDocuments();

    if (overQuery.documents.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<int> checkUser(id) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery = await userCollection
        .where("id", isEqualTo: id)
        .where("type", isEqualTo: 0)
        .getDocuments();

    if (userQuery.documents.length == 0) {
      return 0;
    } else {
      final List<DocumentSnapshot> docs = userQuery.documents;

      saveData.findId = docs[0].data['id'];

      return 1;
    }
  }

  Future<int> checkPhoneNumber(phone) async {
    CollectionReference phoneCollection =
        Firestore.instance.collection("users");

    QuerySnapshot phoneQuery = await phoneCollection
        .where("phone", isEqualTo: phone)
        .where("type", isEqualTo: 0)
        .getDocuments();

    if (phoneQuery.documents.length == 0) {
      return 0;
    } else {
      final List<DocumentSnapshot> docs = phoneQuery.documents;

      saveData.findId = docs[0].data['id'];

      return 1;
    }
  }

  Future<int> checkSnsUser(phone) async {
    CollectionReference phoneCollection =
        Firestore.instance.collection("users");

    QuerySnapshot phoneQuery =
        await phoneCollection.where("phone", isEqualTo: phone).getDocuments();

    final List<DocumentSnapshot> docs = phoneQuery.documents;

    if (docs[0].data['type'] == 0) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> checkAllUser(phone) async {
  CollectionReference phoneCollection =
  Firestore.instance.collection("users");

  QuerySnapshot phoneQuery =
      await phoneCollection.where("phone", isEqualTo: phone).getDocuments();

  final List<DocumentSnapshot> docs = phoneQuery.documents;

  if (phoneQuery.documents.length == 0) {
    return 0;
  } else {
    return 1;
  }
}

Future<int> deleteUser(id) async {
  CollectionReference userCollection = Firestore.instance.collection("users");

  QuerySnapshot userQuery = await userCollection
      .where("id", isEqualTo: id)
      .getDocuments();

  await Firestore.instance.collection("users").document(userQuery.documents[0].documentID).delete();

  return 0;
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

  Future<int> checkRoyalCode(royalCode) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot recoQuery = await userCollection
        .where("royalCode", isEqualTo: royalCode)
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

    QuerySnapshot recoQuery = await recoCollection
        .where("recoCode", isEqualTo: recoCode)
        .getDocuments();

    return recoQuery.documents.length;
  }

  Future<int> getVersionCode() async {
    CollectionReference versionCollection =
        Firestore.instance.collection("version");

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
    DateTime now = DateTime.now();
    String formatDate =
    DateFormat('yyyy.MM.dd').format(now);

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

    Firestore.instance.collection("saveLog").add({
      'id': userQuery.documents[0].data['id'],
      'name': userQuery.documents[0].data['name'], // 유저 이름
      'phone': userQuery.documents[0].data['phone'], // 유저 폰번호
      'type': 0, // 0 = 적립, 1 = 사용
      'date': formatDate, // 적립, 사용된 날짜
      'savePlace': 0, // 0 = 알라딘매직 운영팀
      'saveType': 1,
      'point': 500,
    }).catchError((e) {
      print("addCallLogError2 : " + e.toString());
    });

    return null;
  }
  
  Future<int> deliverySaveCheck(id) async {
    DateTime now = DateTime.now();
    String formatDate =
    DateFormat('yyyy.MM').format(now);

    CollectionReference recoCollection = Firestore.instance.collection("reco");

    QuerySnapshot recoQuery = await recoCollection.where("id", isEqualTo: id).where("saveDate", isEqualTo: formatDate).getDocuments();

    if (recoQuery.documents.length >= 5) {
      return 0;
    } else {
      return 1;
    }
  }

  deliveryInsertPoint(pushRecoCode, id, point, saveLog) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("id", isEqualTo: id).getDocuments();

    int point = userQuery.documents[0].data['point'] + 300;
    saveData.point = point;
    print("point : " + point.toString());

    Firestore.instance
        .collection("users")
        .document(userQuery.documents[0].documentID)
        .updateData({'point': point});

    if (pushRecoCode != null && pushRecoCode != "") {
      QuerySnapshot pushQuery = await userCollection
          .where("recoCode", isEqualTo: pushRecoCode)
          .getDocuments();
      int pushPoint = pushQuery.documents[0].data['point'] + 100;
      Firestore.instance
          .collection("users")
          .document(pushQuery.documents[0].documentID)
          .updateData({'point': pushPoint});

      Firestore.instance.collection("saveLog").add(saveLog).catchError((e) {
        print("addCallLogError : " + e.toString());
      });
    }
    return null;
  }

  Future<int> getSavePoint(id, type) async {
    CollectionReference saveCollection = Firestore.instance.collection("saveLog");

    QuerySnapshot saveQuery = await saveCollection.where("id", isEqualTo: id).where("type", isEqualTo: type).getDocuments();

    int point = 0;

    if (saveQuery.documents.length == 0) {
      return 0;
    } else {
      for (int i = 0 ; i < saveQuery.documents.length; i++) {
        point += saveQuery.documents[i].data['point'];
      }

      return point;
    }
  }

  Future<int> userPasswordUpdate(id, pass) async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    QuerySnapshot userQuery =
        await userCollection.where("id", isEqualTo: id).where("type", isEqualTo: 0).getDocuments();

    if (userQuery.documents.length != 0) {
      Firestore.instance
          .collection("users")
          .document(userQuery.documents[0].documentID)
          .updateData({'pass': pass});

      return 0;
    } else {
      return 1;
    }
  }

  royalCodeUpdate() async {
    CollectionReference userCollection = Firestore.instance.collection("users");

    for (int i = 0; i < phone.length; i++) {
      QuerySnapshot userQuery = await userCollection
          .where("phone", isEqualTo: phone[i])
          .getDocuments();

      if (userQuery.documents.length != 0) {
        Firestore.instance
            .collection("users")
            .document(userQuery.documents[0].documentID)
            .updateData({'royalCode': royalCode[i]});

        print("updateComplete : ${royalCode[i]}");
      }
    }
  }

  List<String> phone = [
    "01033054080",
    "01067845068",
    "01030323388",
    "01034592063",
    "01084408189",
    "01054287198",
    "01094932345",
    "01071712087",
    "01052669097",
    "01055008707",
    "01050782745",
    "01077582866",
    "01090773013",
    "01077589857",
    "01077003520",
    "01081567622",
    "01030169735",
    "01054567876",
    "01087336655",
    "01088958110",
    "01058008300",
    "01053274614",
    "01037240372",
    "01023126410",
    "01092692533",
    "01026749064",
    "01053205406",
    "01022376861",
    "01037352109",
    "01048083997",
    "01023678805",
    "01071148805",
    "01030042158",
    "01045945850",
    "01021094456",
    "01099047607",
    "01084703839",
    "01077400116",
    "01020185118",
    "01062893589",
    "01031257225",
    "01058004382",
    "01062942714",
    "01066347535",
    "01075113519",
    "01047653401",
    "01087426031",
    "01020213358",
    "01095889687",
    "01032096584",
    "01092802996",
    "01033773100",
    "01047843767",
    "01098879381",
    "01050141084",
    "01085807696",
    "01032052322",
    "01075765533",
    "01023956510",
    "01074667783",
    "01063924710",
    "01043344710",
    "01022100612",
    "01047674987",
    "01090933912",
    "01080043967",
    "01085807696",
    "01048251582",
    "01071212724",
    "01048750008",
    "01032517833",
    "01034249938",
    "01087234496",
    "01093550113",
    "01063387748",
    "01058956188",
    "01023038066",
    "01093082333",
    "01086680779",
    "01087310815"
  ];

  List<String> royalCode = [
    "5942",
    "1001",
    "3388",
    "2063",
    "8189",
    "7198",
    "9493",
    "2087",
    "1869",
    "1234",
    "2745",
    "3377",
    "3013",
    "5577",
    "8880",
    "7622",
    "9735",
    "7876",
    "0929",
    "8899",
    "0907",
    "4616",
    "2136",
    "1175",
    "1111",
    "9064",
    "2908",
    "6861",
    "7979",
    "3776",
    "2080",
    "8805",
    "3004",
    "1224",
    "4456",
    "7607",
    "2088",
    "0116",
    "8888",
    "8253",
    "3318",
    "0419",
    "2714",
    "7535",
    "3519",
    "3401",
    "6031",
    "9988",
    "9687",
    "7140",
    "5522",
    "3377",
    "3767",
    "0912",
    "5154",
    "3368",
    "8183",
    "6910",
    "3360",
    "1004",
    "0000",
    "2222",
    "5555",
    "4987",
    "5560",
    "7988",
    "7696",
    "5120",
    "9988",
    "0008",
    "7833",
    "3424",
    "8723",
    "0113",
    "7788",
    "2020",
    "2233",
    "7777",
    "3333",
    "9999"
  ];
}
