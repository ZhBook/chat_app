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

  static void showMessageDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('提示'),
          content: new Text(message),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //返回6位随机数字+时间戳
  static int getUUid() {
    String randomStr = Random().nextInt(10).toString();
    for (var i = 0; i < 5; i++) {
      var str = Random().nextInt(10);
      randomStr = "$randomStr" + "$str";
    }
    var timeNumber = DateTime.now().millisecondsSinceEpoch; //时间
    var uuid = "$randomStr" + "$timeNumber";
    int id = 0;
    try {
      id = int.parse(uuid);
    } catch (e) {
      getUUid();
    }
    return id;
  }
}
