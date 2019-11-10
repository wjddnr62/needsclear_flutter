

import 'package:aladdinmagic/Check/loading.dart';
import 'package:aladdinmagic/Check/permission.dart';
import 'package:aladdinmagic/Home/home.dart';
import 'package:aladdinmagic/Home/reco.dart';
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
};