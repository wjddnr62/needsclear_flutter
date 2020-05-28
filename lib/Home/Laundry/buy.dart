import 'package:aladdinmagic/Home/Laundry/laundrybreakdown.dart';
import 'package:aladdinmagic/Model/datastorage.dart';
import 'package:aladdinmagic/Model/dress.dart';
import 'package:aladdinmagic/Provider/provider.dart';
import 'package:aladdinmagic/Util/mainMove.dart';
import 'package:aladdinmagic/Util/showToast.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:random_string/random_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Buy extends StatefulWidget {
  final String address;
  final int amount;
  final int allPay;
  final List<DressSet> dressNormal;
  final List<DressSet> dressPremium;
  final List<int> dressPaymentNormal;
  final List<int> dressPaymentPremium;
  final int collectionType;

  Buy(
      {this.address,
      this.amount,
      this.allPay,
      this.dressNormal,
      this.dressPremium,
      this.dressPaymentNormal,
      this.dressPaymentPremium,
      this.collectionType});

  @override
  _Buy createState() => _Buy();
}

class _Buy extends State<Buy> {
  Provider provider = Provider();
  AppBar appBar;
  String buyerName = "테스트";
  String buyerTel = "010-1234-5678";
  WebViewController webViewController;

  List<DressSet> dressNormal = List();
  List<DressSet> dressPremium = List();
  List<DressSet> addAllDress = List();

  bool ispOn = false;

  @override
  void initState() {
    super.initState();

    buyerName = dataStorage.user.name;
    buyerTel = dataStorage.user.phone;

    dressNormal = widget.dressNormal;
    dressPremium = widget.dressPremium;

    for (int i = 0; i < dressNormal.length; i++) {
      addAllDress.add(DressSet(
          dressName: dressNormal[i].dressName,
          dressCount: dressNormal[i].dressCount,
          dressPay: dressNormal[i].dressPay,
          dressType: 0));
    }

    for (int i = 0; i < dressPremium.length; i++) {
      addAllDress.add(DressSet(
          dressName: dressPremium[i].dressName,
          dressCount: dressPremium[i].dressCount,
          dressPay: dressPremium[i].dressPay,
          dressType: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IamportPayment(
      appBar: appBar = AppBar(
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        title: mainMove("결제하기", context),
      ),
      initialChild: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            appBar.preferredSize.height,
        child: Center(
          child: ispOn
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                )
              : Container(),
        ),
      ),
      userCode: "imp95610586",
      data: PaymentData.fromJson({
        'pg': 'inicis',
        'payMethod': 'card',
        'name': '니즈클리어 세탁결제',
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}',
        'amount': widget.amount,
        'buyerName': buyerName,
        'buyerTel': buyerTel,
        'buyerEmail': "",
        'buyerAddr': widget.address,
        'buyerPostcode': "",
        'appScheme': "needsclear"
      }),
      callback: (Map<String, String> result) async {
        if (result['imp_success'] == "true") {
          setState(() {
            ispOn = true;
          });
          String code = (randomAlpha(4) + randomNumeric(4) + randomAlpha(8))
              .toUpperCase();

          await provider
              .insertWash(
                  collectionType: widget.collectionType,
                  id: dataStorage.user.id,
                  phone: dataStorage.user.phone,
                  name: dataStorage.user.name,
                  address: widget.address,
                  code: code,
                  washPayment: widget.allPay)
              .then((value) async {
            print("insertWash : $value");
            for (int i = 0; i < addAllDress.length; i++) {
              await provider.insertLaundry(
                  code: code,
                  name: addAllDress[i].dressName,
                  id: dataStorage.user.id,
                  type: addAllDress[i].dressType,
                  count: addAllDress[i].dressCount,
                  payment: addAllDress[i].dressPay);
            }
            for (int i = 0; i < dataStorage.pointManage.length; i++) {
              if (dataStorage.pointManage[i].type == dataStorage.user.type &&
                  dataStorage.pointManage[i].serviceType == 3) {
                await provider
                    .pointInsert(
                        id: dataStorage.user.idx,
                        point: dataStorage.user.point +
                            (widget.allPay *
                                dataStorage.pointManage[i].myselfPercent /
                                100))
                    .then((value) {
                  print("pointInsert : $value");
                  dataStorage.user.point = dataStorage.user.point +
                      (widget.allPay *
                              dataStorage.pointManage[i].myselfPercent /
                              100)
                          .toInt();

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => LaundryBreakDown(
                              type: 0,
                              allPay: widget.allPay,
                              dressNormal: widget.dressNormal,
                              dressPaymentNormal: widget.dressPaymentNormal,
                              dressPremium: widget.dressPremium,
                              dressPaymentPremium: widget.dressPaymentPremium,
                              ncpPoint: (widget.allPay *
                                      dataStorage.pointManage[i].myselfPercent /
                                      100)
                                  .toInt())),
                      (route) => false);
                });
                break;
              }
            }
          });
        } else {
          showToast("결제를 실패하였습니다.");
          Navigator.of(context).pop();
        }
      },
    );
  }
}
