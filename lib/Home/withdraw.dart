import 'package:aladdinmagic/Home/withdrawfin.dart';
import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/customDialog.dart';
import 'package:aladdinmagic/Util/numberFormat.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Withdraw extends StatefulWidget {
  int type;

  Withdraw({Key key, this.type}) : super(key: key);

  @override
  _Withdraw createState() => _Withdraw();
}

class _Withdraw extends State<Withdraw> {
  SaveData saveData = SaveData();
  UserProvider userProvider = UserProvider();

  TextEditingController _pointController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();

  FocusNode _bankNameFoucs = FocusNode();
  FocusNode _acouuntFocus = FocusNode();
  FocusNode _accountNumberFocus = FocusNode();

  int deductionReserve = 0;

  SharedPreferences prefs;

  accountInit() async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setString("bankName", _bankNameController.text);
    await prefs.setString("account", _accountController.text);
    await prefs.setString("accountNumber", _accountNumberController.text);

    DateTime now = DateTime.now();
    String date = DateFormat('yyyy.MM.dd').format(now);

    String code =
        (randomAlpha(4) + randomNumeric(4) + randomAlpha(8)).toUpperCase();

    userProvider.withdrawApply(saveData.id, deductionReserve, {

      "code": code,
      "bankName": _bankNameController.text,
      "account": _accountController.text,
      "accountNumber": _accountNumberController.text,
      "depositAmount": deductionReserve - 1000,
      "deductionReserve": deductionReserve,
      "fees": 1000,
      "id": saveData.id,
      "phone": saveData.phoneNumber,
      "name": saveData.name,
      "date": date,
      "type": 0 // 0 = 출금대기, 1 = 출금완료, 2 = 출금취소
    }, {
      'id': saveData.id,
      'name': saveData.name,
      // 유저 이름
      'phone': saveData.phoneNumber,
      // 유저 폰번호
      'type': 1,
      // 0 = 적립, 1 = 사용
      'date': date,
      // 적립, 사용된 날짜
      'savePlace': 0,
      // 0 = 알라딘매직 운영팀
      'saveType': 12, // 12 = 출금 신청
      'point': deductionReserve,
    });
  }

  accountGet() async {
    prefs = await SharedPreferences.getInstance();

    _bankNameController.text = prefs.getString("bankName");
    _accountController.text = prefs.getString("account");
    _accountNumberController.text = prefs.getString("accountNumber");
  }

  @override
  void initState() {
    super.initState();

    accountGet();
  }

  withDrawDialog(type, context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "알림",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color.fromARGB(255, 167, 167, 167),
                  ),
                  whiteSpaceH(20),
                  type == 0
                      ? Column(
                          children: <Widget>[
                            Text(
                              "보유 적립금 : ${numberFormat.format(saveData.point)}원\n\n",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "보유하신 적립금이\n출금금액 보다 부족하여\n출금하실 수 없습니다.",
                              style: TextStyle(fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      : type == 1
                          ? Text(
                              "보유적립금이 부족하여\n출금하실 수 없습니다.\n(50,000원 이상 가능)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: black,
                                  fontSize: 16),
                            )
                          : Column(
                              children: <Widget>[
                                Text(
                                  "출금금액 : ${numberFormat.format(deductionReserve)}원\n",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "출금신청 시 입금수수료 1,000원이\n차감되고 입금됩니다.\n\n출금 하시겠습니까?",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                  whiteSpaceH(30),
                  Row(
                    children: <Widget>[
                      type == 2
                          ? Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color:
                                          Color.fromARGB(255, 167, 167, 167)),
                                  child: Center(
                                    child: Text(
                                      "취소",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      type == 2 ? whiteSpaceW(10) : Container(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (type != 2) {
                              Navigator.of(context).pop();
                            } else {
                              // 출금 신청 완료
                              accountInit();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WithdrawFin(
                                        account: _accountController.text,
                                        accountNumber:
                                            _accountNumberController.text,
                                        bankName: _bankNameController.text,
                                        deductionReserve: deductionReserve,
                                      )));
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 167, 167, 167)),
                            child: Center(
                              child: Text(
                                "확인",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        if (widget.type == 0) {
          Navigator.of(context).pushReplacementNamed('/Home');
        } else if (widget.type == 1) {
          Navigator.of(context).pushReplacementNamed('/SaveBreakDown');
        }

        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text(
            "출금하기",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: black),
          ),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              if (widget.type == 0) {
                Navigator.of(context).pushReplacementNamed('/Home');
              } else if (widget.type == 1) {
                Navigator.of(context).pushReplacementNamed('/SaveBreakDown');
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.dehaze,
                    color: black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/WithdrawHistory");
                  },
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                whiteSpaceH(10),
                Text(
                  "※ 출금금액",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18, color: black),
                ),
                whiteSpaceH(10),
                TextFormField(
                  controller: _pointController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_bankNameFoucs);
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      if (value.isEmpty) {
                        deductionReserve = 0;
                      } else {
                        deductionReserve = int.parse(value);
                      }
                    });
                  },
                  maxLength: 8,
                  decoration: InputDecoration(
                      counterText: "",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 167, 167, 167)),
                      hintText: "출금하실 금액 입력",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor)),
                      contentPadding: EdgeInsets.only(left: 10, right: 10)),
                ),
                whiteSpaceH(10),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "보유 적립금 : ${numberFormat.format(saveData.point)}원",
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                whiteSpaceH(20),
                Text(
                  "※ 입금 계좌정보",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18, color: black),
                ),
                whiteSpaceH(10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _bankNameController,
                        focusNode: _bankNameFoucs,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_acouuntFocus);
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 167, 167, 167)),
                            hintText: "은행명 입력",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                    ),
                    whiteSpaceW(10),
                    Expanded(
                      child: TextFormField(
                        controller: _accountController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        focusNode: _acouuntFocus,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_accountNumberFocus);
                        },
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 167, 167, 167)),
                            hintText: "예금주 입력",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                    ),
                  ],
                ),
                whiteSpaceH(10),
                TextFormField(
                  controller: _accountNumberController,
                  focusNode: _accountNumberFocus,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                      counterText: "",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 167, 167, 167)),
                      hintText: "계좌번호 입력",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: mainColor)),
                      contentPadding: EdgeInsets.only(left: 10, right: 10)),
                ),
                whiteSpaceH(10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: black,
                ),
                whiteSpaceH(10),
                Padding(
                  padding: EdgeInsets.only(left: 7, right: 7),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "차감 적립금",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            "${numberFormat.format(deductionReserve)}원",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      whiteSpaceH(5),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "입금수수료",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            "${numberFormat.format(1000)}원",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      whiteSpaceH(5),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "입금 금액",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Text(
                            deductionReserve >= 1000
                                ? "${numberFormat.format(deductionReserve - 1000)}원"
                                : "0원",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                whiteSpaceH(20),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: RaisedButton(
                    onPressed: () {
                      if (_pointController.text.isEmpty ||
                          _pointController.text == null) {
                        customDialog("출금하실 금액을 입력해주세요.", 0, context);
                      } else if (_bankNameController.text.isEmpty ||
                          _bankNameController.text == null ||
                          _bankNameController.text == "") {
                        customDialog("은행명을 입력해주세요.", 0, context);
                      } else if (_accountController.text.isEmpty ||
                          _accountController.text == null ||
                          _accountController.text == "") {
                        customDialog("예금주를 입력해주세요.", 0, context);
                      } else if (_accountNumberController.text.isEmpty ||
                          _accountNumberController.text == null) {
                        customDialog("계좌번호를 입력해주세요.", 0, context);
                      } else if (saveData.point < 50000 ||
                          deductionReserve < 50000) {
                        withDrawDialog(1, context);
                      } else if (deductionReserve > saveData.point) {
                        withDrawDialog(0, context);
                      } else {
                        withDrawDialog(2, context);
                      }
                    },
                    color: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(color: black)),
                    elevation: 0.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: Center(
                        child: Text(
                          "출금 신청하기",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                whiteSpaceH(20),
                Text(
                  "- 최소 출금금액은 50,000원 입니다.\n- 출금 시 입금수수료 1,000원이 자동 차감됩니다.\n- 계좌정보가 올바르지 않는 경우 출금신청이\n  취소되거나 지연될 수 있습니다.",
                  strutStyle: StrutStyle(height: 1.3),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
