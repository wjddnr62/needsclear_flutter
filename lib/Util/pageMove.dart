import 'package:flutter/material.dart';

pushPageMove(pageName, context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => pageName));
}
