import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({msg, type}) {
  if (type == 0) {
    return Fluttertoast.showToast(msg: msg);
  } else {
    return Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }
}
