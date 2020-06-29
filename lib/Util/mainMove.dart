import 'package:flutter/material.dart';
import 'package:needsclear/public/colors.dart';

mainMove(text, context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/Home", (Route<dynamic> route) => false);
    },
    child: Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: black,
          fontFamily: 'noto'),
    ),
  );
}

mainMoveLogo(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/Home", (Route<dynamic> route) => false);
    },
    child: Image.asset(
      "assets/icon/logolong.png",
      fit: BoxFit.cover,
    ),
  );
}
