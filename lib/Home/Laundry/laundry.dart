import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:needsclear/Home/Laundry/laundrybreakdown.dart';
import 'package:needsclear/Home/Laundry/laundryset.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Model/dress.dart';
import 'package:needsclear/Model/washsum.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import '../home.dart';
import 'laundryUseGuide.dart';

class Laundry extends StatefulWidget {
  @override
  _Laundry createState() => _Laundry();
}

class _Laundry extends State<Laundry> {
  AppBar appBar;
  bool dataSet = false;
  bool type = false;
  String laundryValue = '전체';
  Provider provider = Provider();
  List<WashSum> washList = List();
  bool viewOption = false;
  int viewType = 0;

  laundryDataSet() async {
    await provider.getWash(dataStorage.user.id).then((value) async {
      List<dynamic> data = await json.decode(value)['data'];
      print(data);
      Wash wash;

      for (int i = 0; i < data.length; i++) {
        List<dynamic> laundryData = data[i]['laundries'];
        print("laundryData : $laundryData");
        List<Laundries> laundries = List();
        wash = Wash(
            idx: data[i]['wash']['idx'],
            collectionType: data[i]['wash']['collectionType'],
            washType: data[i]['wash']['washType'],
            address: data[i]['wash']['address'],
            washPayment: data[i]['wash']['washPayment'],
            id: data[i]['wash']['id'],
            phone: data[i]['wash']['phone'],
            name: data[i]['wash']['name'],
            code: data[i]['wash']['code'],
            date: data[i]['wash']['date']);

        for (int j = 0; j < laundryData.length; j++) {
          laundries.add(Laundries(
            id: laundryData[j]['id'],
            count: laundryData[j]['count'],
            payment: laundryData[j]['payment'],
            type: laundryData[j]['type'],
            name: laundryData[j]['name'],
            code: laundryData[j]['code'],
          ));
        }

        washList.add(WashSum(wash: wash, laundries: laundries));
      }

      setState(() {
        dataSet = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    laundryDataSet();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: appBar = AppBar(
          backgroundColor: white,
          elevation: 0.0,
          centerTitle: true,
          title: mainMoveLogo(context),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                      (route) => false);
            },
            icon: Image.asset(
              "assets/needsclear/resource/public/prev.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.all(16),
                color: Color(0xFFF7F7F7),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "세탁서비스",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'noto',
                                    fontSize: 20,
                                    color: black),
                              ),
                              whiteSpaceH(5),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LaundryUseGuide()));
                                },
                                child: Text(
                                  "이용 가이드 >",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'noto',
                                      color: black),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 24),
                          child: Image.asset(
                            "assets/needsclear/resource/service/washer.png",
                            width: 72,
                            height: 72,
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(22),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 43,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LaundrySet()));
                        },
                        padding: EdgeInsets.zero,
                        color: white,
                        elevation: 0.0,
                        child: Center(
                          child: Text(
                            "신청하기",
                            style: TextStyle(
                                color: black, fontFamily: 'noto', fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: white,
                  child: Row(
                    children: [
                      Text(
                        "이용내역",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'noto',
                            fontSize: 14,
                            color: black),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: DropdownButton<String>(
                            underline: Container(),
                            elevation: 0,
                            style: TextStyle(
                                color: black, fontSize: 14, fontFamily: 'noto'),
                            items: <String>['전체', '택배대기', '수령대기', '세탁중', '완료']
                                .map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontFamily: 'noto'),
                                ),
                              );
                            }).toList(),
                            value: laundryValue,
                            onChanged: (value) {
                              setState(() {
                                laundryValue = value;
                                if (value == "전체") {
                                  viewOption = false;
                                } else {
                                  viewOption = true;
                                  if (value == "택배대기") {
                                    viewType = 0;
                                  } else if (value == "수령대기") {
                                    viewType = 1;
                                  } else if (value == "세탁중") {
                                    viewType = 2;
                                  } else if (value == "완료") {
                                    viewType = 3;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              whiteSpaceH(16),
              dataSet
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, idx) {
                          print("length : " +
                              washList[idx].laundries.length.toString());
                          if (viewOption) {
                            if (washList[idx].wash.washType == viewType) {
                              return InkWell(
                                onTap: () {
                                  List<DressSet> addAllDress = List();
                                  for (int i = 0;
                                  i < washList[idx].laundries.length;
                                  i++) {
                                    addAllDress.add(DressSet(
                                        dressName:
                                        washList[idx].laundries[i].name,
                                        dressCount:
                                        washList[idx].laundries[i].count,
                                        dressPay: washList[idx]
                                            .laundries[i]
                                            .payment));
                                  }

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LaundryBreakDown(
                                                type: 1,
                                                allPay: washList[idx]
                                                    .wash
                                                    .washPayment,
                                                addAllDress: addAllDress,
                                                date: washList[idx].wash.date,
                                                washType:
                                                washList[idx].wash.washType,
                                              )),
                                          (route) => false);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      washList[idx].wash.date.split(" ")[0],
                                      style: TextStyle(
                                          color: Color(0xFF888888),
                                          fontFamily: 'noto',
                                          fontSize: 12),
                                    ),
                                    whiteSpaceH(4),
                                    Row(
                                      children: [
                                        washList[idx].wash.washType == 0
                                            ? Image.asset(
                                          "assets/needsclear/resource/laundry/sending.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : washList[idx].wash.washType == 1
                                            ? Image.asset(
                                          "assets/needsclear/resource/laundry/diliver.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : washList[idx].wash.washType == 2
                                            ? Image.asset(
                                          "assets/needsclear/resource/laundry/cleaning.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : washList[idx].wash.washType ==
                                            3
                                            ? Image.asset(
                                          "assets/needsclear/resource/laundry/end.png",
                                          width: 48,
                                          height: 48,
                                        )
                                            : Container(),
                                        whiteSpaceW(12),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${numberFormat.format(
                                                      washList[idx].wash
                                                          .washPayment)} 원",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'noto',
                                                      color: black,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                ),
                                                whiteSpaceW(12),
                                                Text(
                                                  washList[idx].wash.washType ==
                                                      0
                                                      ? "택배대기"
                                                      : washList[idx]
                                                      .wash
                                                      .washType ==
                                                      1
                                                      ? "수령대기"
                                                      : washList[idx]
                                                      .wash
                                                      .washType ==
                                                      2
                                                      ? "세탁중"
                                                      : washList[idx]
                                                      .wash
                                                      .washType ==
                                                      3
                                                      ? "완료"
                                                      : "",
                                                  style: washList[idx]
                                                      .wash
                                                      .washType ==
                                                      0
                                                      ? TextStyle(
                                                      color: Color(0xFFFFCC00),
                                                      fontFamily: 'noto',
                                                      fontSize: 12)
                                                      : washList[idx]
                                                      .wash
                                                      .washType ==
                                                      1
                                                      ? TextStyle(
                                                      color:
                                                      Color(0xFFFFCC00),
                                                      fontFamily: 'noto',
                                                      fontSize: 12)
                                                      : washList[idx]
                                                      .wash
                                                      .washType ==
                                                      2
                                                      ? TextStyle(
                                                      color: Color(
                                                          0xFF00AAFF),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12)
                                                      : washList[
                                                  idx]
                                                      .wash
                                                      .washType ==
                                                      3
                                                      ? TextStyle(
                                                      color: Color(
                                                          0xFF888888),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12)
                                                      : TextStyle(
                                                      color: Color(
                                                          0xFFFFCC00),
                                                      fontFamily:
                                                      'noto',
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Text(
                                              washList[idx].laundries.length ==
                                                  1
                                                  ? washList[idx]
                                                  .laundries[0]
                                                  .name +
                                                  "${numberFormat.format(
                                                      washList[idx].laundries[0]
                                                          .payment)}원 x ${washList[idx]
                                                      .laundries[0].count}"
                                                  : washList[idx]
                                                  .laundries[0]
                                                  .name +
                                                  "${numberFormat.format(
                                                      washList[idx].laundries[0]
                                                          .payment)}원 x ${washList[idx]
                                                      .laundries[0]
                                                      .count} 외 ${washList[idx]
                                                      .laundries.length - 1}개",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'noto',
                                                  color: Color(0xFF888888)),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Image.asset(
                                          "assets/needsclear/resource/public/small-arrow.png",
                                          width: 24,
                                          height: 24,
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(20)
                                  ],
                                ),
                              );
                            }
                          } else {
                            return InkWell(
                              onTap: () {
                                List<DressSet> addAllDress = List();
                                for (int i = 0;
                                i < washList[idx].laundries.length;
                                i++) {
                                  addAllDress.add(DressSet(
                                      dressName: washList[idx].laundries[i]
                                          .name,
                                      dressCount:
                                      washList[idx].laundries[i].count,
                                      dressPay:
                                      washList[idx].laundries[i].payment));
                                }

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LaundryBreakDown(
                                              type: 1,
                                              allPay:
                                              washList[idx].wash.washPayment,
                                              addAllDress: addAllDress,
                                              date: washList[idx].wash.date,
                                              washType:
                                              washList[idx].wash.washType,
                                            )),
                                        (route) => false);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    washList[idx].wash.date.split(" ")[0],
                                    style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontFamily: 'noto',
                                        fontSize: 12),
                                  ),
                                  whiteSpaceH(4),
                                  Row(
                                    children: [
                                      washList[idx].wash.washType == 0
                                          ? Image.asset(
                                        "assets/needsclear/resource/laundry/sending.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : washList[idx].wash.washType == 1
                                          ? Image.asset(
                                        "assets/needsclear/resource/laundry/diliver.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : washList[idx].wash.washType == 2
                                          ? Image.asset(
                                        "assets/needsclear/resource/laundry/cleaning.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : washList[idx].wash.washType ==
                                          3
                                          ? Image.asset(
                                        "assets/needsclear/resource/laundry/end.png",
                                        width: 48,
                                        height: 48,
                                      )
                                          : Container(),
                                      whiteSpaceW(12),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${numberFormat.format(
                                                    washList[idx].wash
                                                        .washPayment)} 원",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'noto',
                                                    color: black,
                                                    fontWeight: FontWeight
                                                        .w600),
                                              ),
                                              whiteSpaceW(12),
                                              Text(
                                                washList[idx].wash.washType == 0
                                                    ? "택배대기"
                                                    : washList[idx]
                                                    .wash
                                                    .washType ==
                                                    1
                                                    ? "수령대기"
                                                    : washList[idx]
                                                    .wash
                                                    .washType ==
                                                    2
                                                    ? "세탁중"
                                                    : washList[idx]
                                                    .wash
                                                    .washType ==
                                                    3
                                                    ? "완료"
                                                    : "",
                                                style: washList[idx]
                                                    .wash
                                                    .washType ==
                                                    0
                                                    ? TextStyle(
                                                    color: Color(0xFFFFCC00),
                                                    fontFamily: 'noto',
                                                    fontSize: 12)
                                                    : washList[idx]
                                                    .wash
                                                    .washType ==
                                                    1
                                                    ? TextStyle(
                                                    color:
                                                    Color(0xFFFFCC00),
                                                    fontFamily: 'noto',
                                                    fontSize: 12)
                                                    : washList[idx]
                                                    .wash
                                                    .washType ==
                                                    2
                                                    ? TextStyle(
                                                    color: Color(
                                                        0xFF00AAFF),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize: 12)
                                                    : washList[
                                                idx]
                                                    .wash
                                                    .washType ==
                                                    3
                                                    ? TextStyle(
                                                    color: Color(
                                                        0xFF888888),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize: 12)
                                                    : TextStyle(
                                                    color: Color(
                                                        0xFFFFCC00),
                                                    fontFamily:
                                                    'noto',
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Text(
                                            washList[idx].laundries.length == 1
                                                ? washList[idx]
                                                .laundries[0]
                                                .name +
                                                "${numberFormat.format(washList[idx].laundries[0].payment)}원 x ${washList[idx].laundries[0].count}"
                                                : washList[idx]
                                                .laundries[0]
                                                .name +
                                                "${numberFormat.format(washList[idx].laundries[0].payment)}원 x ${washList[idx].laundries[0].count} 외 ${washList[idx].laundries.length - 1}개",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'noto',
                                                color: Color(0xFF888888)),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Image.asset(
                                        "assets/needsclear/resource/public/small-arrow.png",
                                        width: 24,
                                        height: 24,
                                      )
                                    ],
                                  ),
                                  whiteSpaceH(20)
                                ],
                              ),
                            );
                          }

                          return Container();
                        },
                        shrinkWrap: true,
                        itemCount: washList.length,
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
