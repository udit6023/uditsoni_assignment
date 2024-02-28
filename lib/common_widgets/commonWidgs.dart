import 'package:flutter/material.dart';

double setWidth(double width, BuildContext context) {
  double defaultWidth = 400;
  var screenWidth = MediaQuery.of(context).size.width;
  return width * (screenWidth / defaultWidth);
}
