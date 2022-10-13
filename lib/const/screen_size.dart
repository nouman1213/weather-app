
import 'package:flutter/material.dart';

class ScreenSize {
  late MediaQueryData _mediaQueryData;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double getScreenWidth(double width) {
    double screenWidth = ScreenSize.screenWidth;
    return (width / 375.0) * screenWidth;
  }

  static double getScreenHieght(double height) {
    double screenheight = ScreenSize.screenWidth;
    return (height / 812.0) * screenheight;
  }
}
