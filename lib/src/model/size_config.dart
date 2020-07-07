import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double height;
  static double width;
  static double halfSize;
  static double quarterSize;
  static double threeQuarterSize;

  static double leftDxMin;
  static double leftDxMax;
  static double rightDxMin;
  static double rightDxMax;
  static double topDyMin;
  static double topDyMax;
  static double bottomDyMin;
  static double bottomDyMax;

  static double param1;
  static double param2;
  static double param3;
  static double param4;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    height = _mediaQueryData.size.height;
    width = _mediaQueryData.size.width;

    halfSize = width / 2 - 40;
    quarterSize = width / 4 - 80;
    threeQuarterSize = width * 3 / 4 - 80;

    leftDxMin = width / 8 - 40;  // 1, 3
    leftDxMax = width / 8 + 40;  // 1, 3
    rightDxMin = width * 5 / 8 - 40;  // 2, 4
    rightDxMax = width * 5 / 8 + 40;  // 2, 4
    topDyMin = height - width * 7 / 8 - 40;  // 1, 2
    topDyMax = height - width * 7 / 8 + 40;  // 1, 2
    bottomDyMin = height - width * 3 / 8 - 40;  // 3, 4
    bottomDyMax = height - width * 3 / 8 + 40;  // 3, 4

    param1 = height - width;
    param2 = height - width / 2;
    param3 = height - width * 3 / 2;
    param4 = height + width / 2;
  }
}