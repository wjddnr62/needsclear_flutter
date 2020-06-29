import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:needsclear/Model/dress.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

import 'laundryapply.dart';

class LaundrySet extends StatefulWidget {
  @override
  _LaundrySet createState() => _LaundrySet();
}

class _LaundrySet extends State<LaundrySet> {
  List<Dress> laundryItem = List();

  List<bool> laundryNormalCheck = List();
  List<int> laundryNormalCheckNum = List();
  List<DressSet> laundryNormalSet = List();

  List<bool> laundryPremiumCheck = List();
  List<int> laundryPremiumCheckNum = List();
  List<DressSet> laundryPremiumSet = List();

  Provider provider = Provider();

  bool getData = false;

  dataSet() async {
    if (!getData) {
      laundryItem.clear();
      laundryNormalCheck.clear();
      laundryNormalCheckNum.clear();
      laundryNormalSet.clear();
      laundryPremiumCheck.clear();
      laundryPremiumCheckNum.clear();
      laundryPremiumSet.clear();

      await provider.getDress().then((value) {
        List<dynamic> getDress = json.decode(value)['data'];
        if (getDress.length != 0) {
          for (int i = 0; i < getDress.length; i++) {
            laundryItem.add(Dress(
                dressPayment: getDress[i]['payment'],
                dressType: getDress[i]['type'],
                dressName: getDress[i]['name']));
          }

          for (int i = 0; i < laundryItem.length; i++) {
            if (laundryItem[i].dressType == 0) {
              laundryNormalCheck.add(false);
              laundryNormalCheckNum.add(i);
            } else if (laundryItem[i].dressType == 1) {
              laundryPremiumCheck.add(false);
              laundryPremiumCheckNum.add(i);
            }
          }

          setState(() {
            getData = true;
          });
        }
      });
    }
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
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
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
        centerTitle: true,
        title: mainMove("세탁신청", context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              whiteSpaceH(8),
              Text(
                "세탁물 종류",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'noto',
                    fontSize: 16,
                    color: black),
              ),
              whiteSpaceH(16),
              Text(
                "일반세탁",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: black,
                    fontFamily: 'noto'),
              ),
              whiteSpaceH(8),
              getData
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, idx) {
                        if (laundryItem[laundryNormalCheckNum[idx]].dressType ==
                            0) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (laundryNormalCheck[idx]) {
                                  laundryNormalCheck[idx] = false;
                                  for (int i = 0;
                                      i < laundryNormalSet.length;
                                      i++) {
                                    if (laundryNormalSet[i].dressName ==
                                        laundryItem[laundryNormalCheckNum[idx]]
                                            .dressName) {
                                      laundryNormalSet.removeAt(i);
                                    }
                                  }
                                } else {
                                  laundryNormalCheck[idx] = true;
                                  laundryNormalSet.add(DressSet(
                                      dressName: laundryItem[
                                              laundryNormalCheckNum[idx]]
                                          .dressName,
                                      dressPay: laundryItem[
                                              laundryNormalCheckNum[idx]]
                                          .dressPayment,
                                      dressCount: 0));
                                }
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(
                                      color: laundryNormalCheck[idx]
                                          ? mainColor
                                          : Color(0xFFDDDDDD))),
                              child: Center(
                                child: Text(
                                  laundryItem[laundryNormalCheckNum[idx]]
                                          .dressName +
                                      " ${numberFormat.format(laundryItem[laundryNormalCheckNum[idx]].dressPayment)}원",
                                  style: TextStyle(
                                      color: laundryNormalCheck[idx]
                                          ? mainColor
                                          : Color(0xFF888888),
                                      fontFamily: 'noto',
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                      itemCount: laundryNormalCheckNum.length,
                      shrinkWrap: true,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      staggeredTileBuilder: (idx) => StaggeredTile.fit(1))
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                      ),
                    ),
              whiteSpaceH(24),
              Text(
                "명품세탁",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: black,
                    fontFamily: 'noto'),
              ),
              whiteSpaceH(8),
              getData
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, idx) {
                        if (laundryItem[laundryPremiumCheckNum[idx]]
                                .dressType ==
                            1) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (laundryPremiumCheck[idx]) {
                                  laundryPremiumCheck[idx] = false;
                                  for (int i = 0;
                                      i < laundryPremiumSet.length;
                                      i++) {
                                    if (laundryPremiumSet[i].dressName ==
                                        laundryItem[laundryPremiumCheckNum[idx]]
                                            .dressName) {
                                      laundryPremiumSet.removeAt(i);
                                    }
                                  }
                                } else {
                                  laundryPremiumCheck[idx] = true;
                                  laundryPremiumSet.add(DressSet(
                                      dressName: laundryItem[
                                              laundryPremiumCheckNum[idx]]
                                          .dressName,
                                      dressPay: laundryItem[
                                              laundryPremiumCheckNum[idx]]
                                          .dressPayment,
                                      dressCount: 0));
                                }
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(
                                      color: laundryPremiumCheck[idx]
                                          ? mainColor
                                          : Color(0xFFDDDDDD))),
                              child: Center(
                                child: Text(
                                  laundryItem[laundryPremiumCheckNum[idx]]
                                          .dressName +
                                      " ${numberFormat.format(laundryItem[laundryPremiumCheckNum[idx]].dressPayment)}원",
                                  style: TextStyle(
                                      color: laundryPremiumCheck[idx]
                                          ? mainColor
                                          : Color(0xFF888888),
                                      fontFamily: 'noto',
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                      itemCount: laundryPremiumCheckNum.length,
                      shrinkWrap: true,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      staggeredTileBuilder: (idx) => StaggeredTile.fit(1))
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              whiteSpaceH(56),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 44,
                child: RaisedButton(
                  color: mainColor,
                  elevation: 0.0,
                  onPressed: () {
//                    final page = LaundryApply(
//                      type: 0,
//                    );
//                    Navigator.of(context).pushReplacement(
//                        MaterialPageRoute(builder: (context) => page));
                    if (laundryNormalSet.length == 0 &&
                        laundryPremiumSet.length == 0) {
                      showToast("세탁물을 선택해주세요.");
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LaundryApply(
                                dressNormal: laundryNormalSet,
                                dressPremium: laundryPremiumSet,
                              )));
                    }
                  },
                  child: Center(
                    child: Text(
                      "다음",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'noto',
                          color: white,
                          fontWeight: FontWeight.w600),
                    ),
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
