import 'package:aladdinmagic/Model/savedata.dart';
import 'package:aladdinmagic/Provider/userprovider.dart';
import 'package:aladdinmagic/Util/mainMove.dart';
import 'package:aladdinmagic/Util/toast.dart';
import 'package:aladdinmagic/Util/whiteSpace.dart';
import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Delivery extends StatefulWidget {
  @override
  _Delivery createState() => _Delivery();
}

class _Delivery extends State<Delivery> {
  SaveData saveData = SaveData();
  UserProvider userProvider = UserProvider();

  TextEditingController sender = TextEditingController();
  TextEditingController invoice = TextEditingController();

  FocusNode senderFocus = FocusNode();
  FocusNode invoiceFocus = FocusNode();

  String selectBoxValue = "택배사 선택";

  customDialog(msg, type) {
    return showDialog(
        context: context,
        barrierDismissible: true,
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
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: black,
                        fontSize: 16),
                  ),
                  whiteSpaceH(30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (type == 0) {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushReplacementNamed('/Home');
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
        Navigator.of(context).pushReplacementNamed('/Home');
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: mainMove("택배적립", context),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/Home');
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  whiteSpaceH(20),
                  Text("적립을 위해 택배정보를 입력해 주세요."),
                  whiteSpaceH(20),
                  Row(
                    children: <Widget>[
                      Text(
                        "발송인",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: black, fontWeight: FontWeight.w600),
                      ),
                      whiteSpaceW(10),
                      Expanded(
                        child: TextFormField(
                          controller: sender,
                          focusNode: senderFocus,
                          autofocus: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          maxLength: 10,
                          decoration: InputDecoration(
                              counterText: "",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 167, 167, 167)),
                              hintText: "발송인 이름을 입력해 주세요.",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              contentPadding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 5)),
                        ),
                      ),
                    ],
                  ),
                  whiteSpaceH(20),
                  Row(
                    children: <Widget>[
                      Text(
                        "택배정보",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: black, fontWeight: FontWeight.w600),
                      ),
                      whiteSpaceW(10),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            elevation: 2,
                            style: TextStyle(color: black),
                            items: <String>[
                              '택배사 선택',
                              'CJ대한통운',
                              '우체국택배',
                              '한진택배',
                              '롯데택배',
                              '로젠택배',
                              '홈픽택배',
                              'CVSnet 편의점택배',
                              'CU 편의점택배',
                              '경동택배',
                              '대신택배',
                              '일양로지스',
                              '합동택배',
                              '건영택배',
                              '천일택배',
                              '한덱스',
                              '한의사랑택배',
                              'EMS',
                              'DHL',
                              'TNT Express',
                              'UPS',
                              'Fedex',
                              'USPS',
                              'i-Parcel',
                              'DHL Global Mail',
                              '판토스',
                              '에어보이익스프레스',
                              'GSMNtoN',
                              'ECMS Express',
                              'KGL네트웍스',
                              '굿투럭',
                              '호남택배',
                              'GSI Express',
                              '로지스링크(SLX택배)',
                              '우리한방택배',
                              '세방',
                              'KGB택배',
                              'Cway Express',
                              '하이택배',
                              'YJS글로벌(영국)',
                              '워펙스코리아',
                              '성원글로벌카고',
                              '홈이노베이션로지스',
                              '은하쉬핑',
                              'Giant Network Group',
                              'FLF퍼레버택배',
                              '농협택배',
                              'YJS글로벌(월드)',
                              '디디로지스',
                              '대림통운',
                              'LOTOS CORPORATION'
                            ].map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: black),
                                  overflow: TextOverflow.visible,
                                ),
                              );
                            }).toList(),
                            value: selectBoxValue,
                            onChanged: (value) {
                              setState(() {
                                selectBoxValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      whiteSpaceW(10),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: invoice,
                          focusNode: invoiceFocus,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          maxLength: 20,
                          decoration: InputDecoration(
                              counterText: "",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 167, 167, 167)),
                              hintText: "송장번호 입력",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor)),
                              contentPadding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 5)),
                        ),
                      ),
                    ],
                  ),
                  whiteSpaceH(50),
                  GestureDetector(
                    onTap: () {
                      if (sender.text == null || sender.text == "") {
                        showToast(type: 0, msg: "발송인을 입력해 주세요.");
                      } else if (selectBoxValue == "택배사 선택") {
                        showToast(type: 0, msg: "택배사를 선택해 주세요.");
                      } else if (invoice.text == null || invoice.text == "") {
                        showToast(type: 0, msg: "송장번호를 입력해 주세요.");
                      } else if (invoice.text != null &&
                          invoice.text != "" &&
                          invoice.text.length < 10) {
                        showToast(type: 0, msg: "송장번호를 10자 이상 입력해 주세요.");
                      } else {
                        DateTime now = DateTime.now();
                        String saveMonth = DateFormat('yyyy.MM').format(now);
                        String date = DateFormat('yyyy.MM.dd').format(now);

                        userProvider
                            .deliverySaveCheck(saveData.id)
                            .then((value) {
                          if (value == 1) {
                            userProvider.deliveryInsertPoint(
                                saveData.pushRecoCode, saveData.id, 300, {
                              'id': saveData.id,
                              'name': saveData.name,
                              // 유저 이름
                              'phone': saveData.phoneNumber,
                              // 유저 폰번호
                              'type': 0,
                              // 0 = 적립, 1 = 사용
                              'saveMonth': saveMonth,
                              // 택배 한달 5회 확인용 날짜 택배 적립만 들어감
                              'date': date,
                              // 적립, 사용된 날짜
                              'savePlace': 0,
                              // 0 = 알라딘매직 운영팀
                              'saveType': 2,
                              'point': 300,
                            });

                            customDialog(
                                "택배 적립이 신청되었습니다.\n\n신청내역을 확인 후 매월 말일 적립금이 지급됩니다.",
                                0);
                          } else {
                            showToast(type: 0, msg: "한달에 최대 5번까지만 신청 가능합니다.");
                          }
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: black),
                          color: white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "신청",
                          style: TextStyle(color: black, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  whiteSpaceH(20),
                  Text(
                    "- 택배 송장 1개당, 본인에게 300원이 적립되며\n  추천인에게 100원의 적립금이 지급됩니다.\n- 택배 적립은 한달에 5회 한정하여 가능합니다.\n- 택배 적립금은 월말에 정산되며, 해당 월의\n  알라딘매직 사용액이 10,000원 이상일 경우에만\n  지급됩니다.\n- 택배 송장번호나 정보가 부정확한 경우, 적립금이\n  지급되지 않을 수 있습니다.",
                    strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
