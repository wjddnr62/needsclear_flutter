import 'dart:io';

import 'package:aladdinmagic/public/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: Platform.isIOS ? ToastGravity.CENTER : ToastGravity.BOTTOM,
      backgroundColor: black,
      textColor: white,
      fontSize: 14);
}
