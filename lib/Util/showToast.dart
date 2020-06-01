import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:needsclear/public/colors.dart';

showToast(msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: Platform.isIOS ? ToastGravity.CENTER : ToastGravity.BOTTOM,
      backgroundColor: black,
      textColor: white,
      fontSize: 14);
}
