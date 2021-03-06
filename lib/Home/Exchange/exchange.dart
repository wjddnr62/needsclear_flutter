import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:needsclear/Home/Exchange/exchangebreakdown.dart';
import 'package:needsclear/Model/datastorage.dart';
import 'package:needsclear/Provider/provider.dart';
import 'package:needsclear/Util/mainMove.dart';
import 'package:needsclear/Util/numberFormat.dart';
import 'package:needsclear/Util/showToast.dart';
import 'package:needsclear/Util/whiteSpace.dart';
import 'package:needsclear/public/colors.dart';

class Exchange extends StatefulWidget {
  final int type;

  Exchange({this.type});

  @override
  _Exchange createState() => _Exchange();
}

class _Exchange extends State<Exchange> {
  AppBar appBar;
  int point = 0;
  TextEditingController ncpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    point = dataStorage.user.point;
//    ncpController.text = "0";
  }

  bool pointInput = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();

        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        appBar: appBar = AppBar(
          elevation: 1,
          backgroundColor: white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              'assets/needsclear/resource/public/prev.png',
              width: 24,
              height: 24,
            ),
          ),
          title: mainMove("환전하기", context),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                appBar.preferredSize.height,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  whiteSpaceH(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "환전 NCP수량 ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontFamily: 'noto'),
                      ),
                      RichText(
                        text: TextSpan(
                            text: "보유 NCP : ",
                            style: TextStyle(
                                fontFamily: 'noto', color: black, fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${numberFormat.format(point)} NCP",
                                  style: TextStyle(
                                    fontFamily: 'noto',
                                    fontSize: 12,
                                    color: mainColor,
                                  ))
                            ]),
                      )
                    ],
                  ),
                  whiteSpaceH(5),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: Color(0xFFCCCCCC))),
                    child: TextFormField(
                      maxLines: 1,
                      controller: ncpController,
                      maxLength: point.toString().length,
                      onChanged: (value) {
                        setState(() {
                          if (int.parse(value) >= 1000) {}
                        });
//                        setState(() {
//                          if (!pointInput) {
//                            if (point.toString().length > value.length) {
//                              pointInput = true;
//                            }
//                          }
//
//                          if (!pointInput) {
//                            ncpController.selection = TextSelection.collapsed(
//                                offset: point.toString().length);
//                            ncpController.text = point.toString();
//                          } else {
//                            if (point.toString().length <= value.length) {
//                              print("test");
//                              if (point <= int.parse(value)) {
//                                print("check");
////                                ncpController.selection =C
////
//
//                                setState(() {
//                                  ncpController.text = point.toString();
//                                });
//
//                                pointInput = false;
//                              }
//                            }
//                          }
////                          if (point < int.parse(value)) {
////                            print("point : $point, $value");
////                            ncpController.text = point.toString();
////                          }
//                        });
                      },
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(fontSize: 16, color: black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "0",
                          suffixText: "NCP",
                          suffixStyle: TextStyle(
                              fontSize: 16, color: black, fontFamily: 'noto'),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10, right: 10, top: 0, bottom: 10)),
                    ),
                  ),
                  whiteSpaceH(24),
                  Text(
                    "환전결과",
                    style: TextStyle(
                        fontFamily: 'noto',
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  whiteSpaceH(16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "잔여 NCP",
                          style: TextStyle(
                              fontSize: 14, fontFamily: 'noto', color: black),
                        ),
                      ),
                      Text(
                        "${numberFormat.format(point - int.parse(ncpController.text != "" ? ncpController.text : "0"))} NCP",
                        style: TextStyle(
                            color: black, fontFamily: 'noto', fontSize: 14),
                      )
                    ],
                  ),
                  whiteSpaceH(16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color(0xFFCCCCCC),
                  ),
                  whiteSpaceH(8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "환전 DL",
                          style: TextStyle(
                              fontSize: 16, fontFamily: 'noto', color: black),
                        ),
                      ),
                      Text(
                        int.parse(ncpController.text != ""
                                    ? ncpController.text
                                    : "0") <
                                1000
                            ? "+ 0 DL"
                            : "+ ${numberFormat.format(int.parse(ncpController.text != "" ? ncpController.text : "0") / 1000)} DL",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'noto',
                            color: mainColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  whiteSpaceH(16),
                  Text(
                    "* 1,000 NCP 당 1DL입니다.",
                    style: TextStyle(
                        color: Color(0xFF888888),
                        fontFamily: 'noto',
                        fontSize: 12),
                  ),
                  whiteSpaceH(5),
                  Text(
                    "* NCP 수량 충족시 환전가능합니다.",
                    style: TextStyle(
                        color: Color(0xFF888888),
                        fontFamily: 'noto',
                        fontSize: 12),
                  ),
                  whiteSpaceH(56),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: RaisedButton(
                      elevation: 0.0,
                      onPressed: () {
                        if (ncpController.text == null ||
                            ncpController.text == "") {
                          showToast("환전할 NCP 수량을 입력해주세요.");
                        } else if (int.parse(ncpController.text) < 1000) {
                          showToast("1000 NCP 부터 환전 가능합니다.");
                        } else if (int.parse(ncpController.text) % 1000 != 0) {
                          showToast("1000 NCP 단위로 환전 가능합니다.");
                        } else if (point < int.parse(ncpController.text)) {
                          showToast("가지고 있는 포인트보다\n많은 포인트에 환전은 불가합니다.");
                        } else {
                          exchange(
                              point,
                              int.parse(ncpController.text),
                              dataStorage.user.dl,
                              int.parse(ncpController.text) / 1000.toInt());
                        }
//                        serviceDialog(context);
                      },
                      color: mainColor,
                      child: Center(
                          child: Text(
                        "환전하기",
                        style: TextStyle(
                            fontSize: 14,
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'noto'),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  exchange(retentionNcp, deductionNcp, retentionDL, exchangeDL) async {
    await provider.exchange(dataStorage.user.idx, exchangeDL).then((value) {
      dataStorage.user.point = retentionNcp - deductionNcp;
      dataStorage.user.dl = dataStorage.user.dl + exchangeDL;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ExchangeBreakdown(
                retentionNcp: retentionNcp,
                deductionNcp: deductionNcp,
                retentionDL: retentionDL,
                exchangeDL: exchangeDL,
              )));
    });
  }
}
