import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:needsclear/Home/quick/quickapplyaddress.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class QuickApply extends StatefulWidget {
  @override
  _QuickApply createState() => _QuickApply();
}

class _QuickApply extends State<QuickApply> {
  List<String> vehicle = List();
  List<String> article = List();
  List<String> damage = List();

  bool dataSet = false;

  List<bool> vehicleCheck = List();
  List<bool> articleCheck = List();
  List<bool> damageCheck = List();

  String vehicleSet = "";
  String articleSet = "";
  String damageSet = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vehicle..add("오토바이")..add("승합차");
    article
      ..add("~ 10kg")
      ..add("10kg ~ 20kg")
      ..add("20kg ~ 30kg")
      ..add("30kg ~");
    damage..add("해당없음")..add("파손위험");

    initData();
  }

  initData() async {
    for (int i = 0; i < vehicle.length; i++) {
      vehicleCheck.add(false);
    }

    for (int i = 0; i < article.length; i++) {
      articleCheck.add(false);
    }

    for (int i = 0; i < damage.length; i++) {
      damageCheck.add(false);
    }

    setState(() {
      dataSet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.5,
        centerTitle: true,
        title: mainMove("퀵 배송 신청", context),
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            whiteSpaceH(8),
            Text(
              "배송 옵션",
              style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'noto'),
            ),
            whiteSpaceH(16),
            Text(
              "차량선택",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'noto'),
            ),
            whiteSpaceH(8),
            dataSet
                ? StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (vehicleCheck[idx]) {
                              vehicleCheck[idx] = false;
                              vehicleSet = "";
                            } else {
                              for (int i = 0; i < vehicleCheck.length; i++) {
                                if (i != idx) {
                                  vehicleCheck[i] = false;
                                } else {
                                  vehicleCheck[idx] = true;
                                }
                              }
                              vehicleSet = vehicle[idx];
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 32,
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: white,
                              border: Border.all(
                                  color: vehicleCheck[idx]
                                      ? mainColor
                                      : Color(0xFFDDDDDD))),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              vehicle[idx],
                              style: TextStyle(
                                  color: vehicleCheck[idx]
                                      ? mainColor
                                      : Color(0xFF888888),
                                  fontFamily: 'noto',
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: vehicle.length,
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
              "배송 물품",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'noto'),
            ),
            whiteSpaceH(8),
            dataSet
                ? StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (articleCheck[idx]) {
                              articleCheck[idx] = false;
                              articleSet = "";
                            } else {
                              for (int i = 0; i < articleCheck.length; i++) {
                                if (i != idx) {
                                  articleCheck[i] = false;
                                } else {
                                  articleCheck[idx] = true;
                                }
                              }
                              articleSet = article[idx];
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 32,
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: white,
                              border: Border.all(
                                  color: articleCheck[idx]
                                      ? mainColor
                                      : Color(0xFFDDDDDD))),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              article[idx],
                              style: TextStyle(
                                  color: articleCheck[idx]
                                      ? mainColor
                                      : Color(0xFF888888),
                                  fontFamily: 'noto',
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: article.length,
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
              "파손여부",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'noto'),
            ),
            whiteSpaceH(8),
            dataSet
                ? StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (damageCheck[idx]) {
                              damageCheck[idx] = false;
                              damageSet = "";
                            } else {
                              for (int i = 0; i < damageCheck.length; i++) {
                                if (i != idx) {
                                  damageCheck[i] = false;
                                } else {
                                  damageCheck[idx] = true;
                                }
                              }
                              damageSet = damage[idx];
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 32,
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                              color: white,
                              border: Border.all(
                                  color: damageCheck[idx]
                                      ? mainColor
                                      : Color(0xFFDDDDDD))),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              damage[idx],
                              style: TextStyle(
                                  color: damageCheck[idx]
                                      ? mainColor
                                      : Color(0xFF888888),
                                  fontFamily: 'noto',
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: damage.length,
                    shrinkWrap: true,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    staggeredTileBuilder: (idx) => StaggeredTile.fit(1))
                : Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                    ),
                  ),
            whiteSpaceH(40),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 43,
              child: RaisedButton(
                onPressed: () {
                  if (vehicleSet == "") {
                    showToast("차량을 선택해주세요.");
                  } else if (articleSet == "") {
                    showToast("배송 물품을 선택해주세요.");
                  } else if (damageSet == "") {
                    showToast("파손여부를 선택해주세요.");
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuickApplyAddress(
                              vehicle: vehicleSet,
                              article: articleSet,
                              damage: damageSet,
                            )));
                  }
                },
                elevation: 0.0,
                color: mainColor,
                child: Center(
                  child: Text(
                    "다음",
                    style: TextStyle(
                        fontFamily: 'noto',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
