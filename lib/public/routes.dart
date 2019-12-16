

import 'package:aladdinmagic/Check/loading.dart';
import 'package:aladdinmagic/Check/permission.dart';
import 'package:aladdinmagic/DrawerMenu/memberw.dart';
import 'package:aladdinmagic/DrawerMenu/memberwfin.dart';
import 'package:aladdinmagic/DrawerMenu/recolist.dart';
import 'package:aladdinmagic/DrawerMenu/savebreakdown.dart';
import 'package:aladdinmagic/DrawerMenu/settings.dart';
import 'package:aladdinmagic/Home/delivery.dart';
import 'package:aladdinmagic/Home/home.dart';
import 'package:aladdinmagic/Home/reco.dart';
import 'package:aladdinmagic/Home/withdraw.dart';
import 'package:aladdinmagic/Home/withdrawfin.dart';
import 'package:aladdinmagic/Home/withdrawhistory.dart';
import 'package:aladdinmagic/Login/findid.dart';
import 'package:aladdinmagic/Login/findpass.dart';
import 'package:aladdinmagic/Login/login.dart';
import 'package:aladdinmagic/SignUp/howjoin.dart';
import 'package:aladdinmagic/SignUp/signup.dart';
import 'package:aladdinmagic/SignUp/smsauth.dart';

final routes = {
  '/Home': (context) => Home(),
  '/Loading': (context) => Loading(),
  '/Permission': (context) => Permission(),
  '/Login': (context) => Login(),
  '/SmsAuth': (context) => SmsAuth(),
  '/HowJoin': (context) => HowJoin(),
  '/SignUp': (context) => SignUp(),
  '/Reco': (context) => Reco(),
  '/RecoList': (context) => RecoList(),
  '/Delivery': (context) => Delivery(),
  '/FindId': (context) => FindId(),
  '/FindPass': (context) => FindPass(),
  '/Settings': (context) => Settings(),
  '/MemberW': (context) => MemberW(),
  '/MemberWFin': (context) => MemberWFin(),
  '/SaveBreakDown': (context) => SaveBreakDown(),
  '/Withdraw': (context) => Withdraw(),
  '/WithdrawFin': (context) => WithdrawFin(),
  '/WithdrawHistory': (context) => WithdrawHistory()
};