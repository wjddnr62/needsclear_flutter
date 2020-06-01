import 'package:needsclear/Check/loading.dart';
import 'package:needsclear/Check/permission.dart';
import 'package:needsclear/DrawerMenu/NewDrawerMenu/recolist.dart';
import 'package:needsclear/DrawerMenu/NewDrawerMenu/savebreakdown.dart';
import 'package:needsclear/DrawerMenu/memberw.dart';
import 'package:needsclear/DrawerMenu/memberwfin.dart';
import 'package:needsclear/DrawerMenu/settings.dart';
import 'package:needsclear/Home/delivery.dart';
import 'package:needsclear/Home/home.dart';
import 'package:needsclear/Home/withdraw.dart';
import 'package:needsclear/Home/withdrawfin.dart';
import 'package:needsclear/Home/withdrawhistory.dart';
import 'package:needsclear/Login/findid.dart';
import 'package:needsclear/Login/findpass.dart';
import 'package:needsclear/Login/login.dart';
import 'package:needsclear/SignUp/howjoin.dart';
import 'package:needsclear/SignUp/signup.dart';
import 'package:needsclear/SignUp/smsauth.dart';

final routes = {
  '/Home': (context) => Home(),
  '/Loading': (context) => Loading(),
  '/Permission': (context) => Permission(),
  '/Login': (context) => Login(),
  '/SmsAuth': (context) => SmsAuth(),
  '/HowJoin': (context) => HowJoin(),
  '/SignUp': (context) => SignUp(),
  '/RecoList': (context) => NewRecoList(),
  '/Delivery': (context) => Delivery(),
  '/FindId': (context) => FindId(),
  '/FindPass': (context) => FindPass(),
  '/Settings': (context) => Settings(),
  '/MemberW': (context) => MemberW(),
  '/MemberWFin': (context) => MemberWFin(),
//  '/SaveBreakDown': (context) => SaveBreakDown(),
  '/SaveBreakDown': (context) => NewSaveBreakDown(),
  '/Withdraw': (context) => Withdraw(),
  '/WithdrawFin': (context) => WithdrawFin(),
  '/WithdrawHistory': (context) => WithdrawHistory()
};