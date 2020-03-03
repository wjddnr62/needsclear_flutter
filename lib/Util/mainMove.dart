import 'package:aladdinmagic/public/colors.dart';
import 'package:flutter/material.dart';

mainMove(text, context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/Home", (Route<dynamic> route) => false);
    },
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: black),
    ),
  );
}
