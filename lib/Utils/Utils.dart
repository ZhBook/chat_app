import 'dart:math';
import 'dart:ui';

class Utils{
  static Color getRandomColor() {
    return Color.fromRGBO(
        Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  }
}