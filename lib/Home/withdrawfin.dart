import 'package:aladdinmagic/Util/mainMove.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class WithdrawFin extends StatefulWidget {

  String bankName;
  String account;
  String accountNumber;

  int deductionReserve = 0;

  WithdrawFin({Key key, this.bankName, this.account, this.accountNumber, this.deductionReserve})
      : super(key: key);

  @override
  _WithdrawFin createState() => _WithdrawFin();
}

class _WithdrawFin extends State<WithdrawFin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: mainMove("출금신청 완료", context),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            whiteSpaceH(15),
            Text("출금신청이 완료되었습니다.", style: TextStyle(
                color: black, fontSize: 16
            ),),
            whiteSpaceH(25),
            Text(
              "아래 계좌로 요청하신 금액을\n출금해 드릴 예정입니다.\n추금까지는 최대 2일이 소요될 수 있으니\n참고 부탁드립니다.",
              textAlign: TextAlign.center, style: TextStyle(
                color: black, fontSize: 16
            ),),
            whiteSpaceH(10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
                decoration: BoxDecoration(
                    border: Border.all(color: black)
                ),
                padding: EdgeInsets.only(
                    top: 20, bottom: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("입 금 금 액", style: TextStyle(
                              color: black, fontSize: 16
                          ),),
                        ),
                        Text(numberFormat.format(widget.deductionReserve -
                            1000) + "원", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                            fontSize: 16
                        ),)
                      ],
                    ),
                    whiteSpaceH(10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("출금신청금액", style: TextStyle(
                              color: black, fontSize: 16
                          ),),
                        ),
                        Text(numberFormat.format(widget.deductionReserve) + "원",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: black,
                              fontSize: 16
                          ),)
                      ],
                    ),
                    whiteSpaceH(10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("입금수수료", style: TextStyle(
                              color: black, fontSize: 16
                          ),),
                        ),
                        Text("1,000원", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16
                        ),)
                      ],
                    ),
                    whiteSpaceH(10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("입금될 은행", style: TextStyle(
                              color: black, fontSize: 16
                          ),),
                        ),
                        Text(widget.bankName, style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16
                        ),)
                      ],
                    ),
                    whiteSpaceH(10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("입금될 계좌", style: TextStyle(
                              color: black, fontSize: 16
                          ),),
                        ),
                        Text(widget.accountNumber, style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16
                        ),)
                      ],
                    ),
                    whiteSpaceH(10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("예 금 주", style: TextStyle(
                              color: black, fontSize: 16
                          ),),
                        ),
                        Text(widget.account, style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 16
                        ),)
                      ],
                    )
                  ],
                ),
              ),
            ),
            whiteSpaceH(20),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/Home", (Route<dynamic> route) => false);
                },
                color: white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                    side: BorderSide(color: black)),
                elevation: 0.0,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 45,
                  child: Center(
                    child: Text("확인"),
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