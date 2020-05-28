import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

class StyleCustom {
  String text = "";
  FontWeight fontWeight = FontWeight.normal;
  Color color = black;
  double fontSize = 12;
  TextDecoration textDecoration = TextDecoration.none;

  StyleCustom(
      {this.text,
      this.fontWeight,
      this.color,
      this.fontSize,
      this.textDecoration});
}

Text customText(StyleCustom styleCustom) {
  return Text(
    styleCustom.text,
    style: TextStyle(
        color: styleCustom.color,
        fontSize: styleCustom.fontSize,
        fontWeight: styleCustom.fontWeight,
        fontFamily: 'noto',
        decoration: styleCustom.textDecoration),
  );
}
