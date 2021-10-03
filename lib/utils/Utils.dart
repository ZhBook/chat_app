import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Utils {
  static Color getRandomColor() {
    return Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  }

  static String getRandomNum(int max) {
    return Random().nextInt(max).toString();
  }
}
